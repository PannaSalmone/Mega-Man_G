extends CharacterBody2D

@export var projectile = PackedScene


var WALK_SPEED := 82.5
var JUMP_SPEED = 285.0
var MAX_FALL_SPEED := 420.0

var direction := 1

var under_water := false
var is_taking_damage := false
var is_invincible := false
var is_shooting := false

@onready var attacktimer = $Shootanimtimer
@onready var defeatsfx = preload("res://assets/AUDIO/SFX/MegamanDefeat.wav")
@onready var splashsfx = preload("res://assets/AUDIO/SFX/splash.wav")
@onready var damagesfx = preload("res://assets/AUDIO/SFX/MMdamage.wav")

func _ready():
	$HitSprite.hide()
	
func _physics_process(_delta):
	Global.playerxy = self.global_position	

	if direction == -1:
		$Sprite.flip_h = true
		%Raycast.position.x = 8
	else:
		$Sprite.flip_h = false
		%Raycast.position.x = -8
	if not is_on_floor():
		velocity.y = clamp(velocity.y + 15.0, -MAX_FALL_SPEED, MAX_FALL_SPEED)
		if velocity.y > MAX_FALL_SPEED: #Limits fall speeds
			velocity.y = MAX_FALL_SPEED
	
	if Global.playerHP <= 0:
		death()
	
	move_and_slide()

func _on_pit_ops():
	death()
	

func _on_area_2d_body_entered(body):
	splash()
	under_water = true
	$Bubble.start()
	

func _on_area_2d_body_exited(body):
	splash()
	under_water = false
	
func splash():
	Audio.playsfx2(splashsfx)
	print("splasgh")
	
	#Death anim and explosions + scene reload
func death():
	is_invincible = true
	$Sprite.hide()
	Audio.playsfx2(defeatsfx)
	var piupiu = preload("res://MM_Explosion.tscn")
	var p = piupiu.instantiate()
	get_parent().add_child(p)
	collision_layer = 0
	$Collision.disabled = 1
	$SlidingColl.disabled = 1
	await get_tree().create_timer(3.0).timeout
	get_tree().change_scene_to_file("res://test_man_stage.tscn")
	Global.reset_vars()
	
#Damage
func damage(damage):
	if is_invincible == false:
		$FSM.change_state($FSM.current_state,"Hit")
		Global.playerHP -= damage
		if Global.playerHP > 0:
			is_invincible = true
			#is_taking_damage = true
			$Invincibility.start()
			$Sprite/Flickering.play("flickering")
			Audio.playsfx2(damagesfx)
			#damage effect white sprite anim and stun
			$HitSprite/Anim.play("vis")
			await get_tree().create_timer(0.3).timeout
			$HitSprite/Anim.stop()
			is_taking_damage = false

func _on_invincibility_timeout():
	is_invincible = false
	$Sprite/Flickering.stop()

func _on_bubble_timeout():
	if under_water == true:
		Effect_manager.bubble()
		$Bubble.start()

func change_anim(str):
	$Sprite/AnimationPlayer.play(str)

func shoot():
	%ShootingTimer.start()
	var projectile_pos = $Shootpos.global_position
	$Shootpos.position.x = 13 * direction
	Global.player_dir = direction
	Effect_manager.shoot(projectile_pos)
