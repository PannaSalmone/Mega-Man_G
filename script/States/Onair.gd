extends State
class_name OnairState

var is_shooting := false
var is_descending = false
@onready var landsfx = preload("res://assets/AUDIO/SFX/Landing.wav")
@onready var animator = %AnimationPlayer
var player : CharacterBody2D

func enter():
	animator.play("Jump")
	is_descending = false
	player = get_tree().get_first_node_in_group("Player")
	
func update(_delta):
	#Air Movements
	var direction := Input.get_axis("left", "right")
	if direction != 0:
		player.direction = direction
		player.velocity.x = direction * player.WALK_SPEED
	else:
		player.velocity.x = 0
	
	if Input.is_action_just_released("jump") and is_descending == false:
		player.velocity.y = 5
		is_descending = true
	
	##SHOOT
	if Input.is_action_just_pressed("shoot"):
		is_shooting = true
		animator.play("shoot_jump")
		player.shoot()
	
	if player.is_on_floor():
		Audio.playsfx(landsfx)
		state_transition.emit(self, "Idle")

func reset_anim() -> void:
	animator.play("Jump")
