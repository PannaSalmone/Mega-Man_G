extends State
class_name WalkingState

var is_shooting := false
@onready var timer := %ShootingTimer
var left_right_key_press_time: float = 0
@onready var animator = %AnimationPlayer
var player : CharacterBody2D

func Enter():
	animator.play("Tipping")
	left_right_key_press_time = 0
	player = get_tree().get_first_node_in_group("Player")

func Exit():
	state_transition.emit(self, "Idle")

func Update(_delta:float):
	#Movements
	left_right_key_press_time += 60 * _delta
	if is_shooting == false:
		if Input.is_action_pressed("right"):
			player.direction = 1#Input.get_axis("left", "right")
			player.velocity.x =  player.WALK_SPEED
			if left_right_key_press_time < 7: #max toe tipping frames
				animator.play("Tipping")
			else:
				animator.play("Walk")
	
		elif Input.is_action_pressed("left"):
			player.direction = -1
			player.velocity.x = -1 * player.WALK_SPEED
			if left_right_key_press_time < 7: #max toe tipping frames
				animator.play("Tipping")
			else:
				animator.play("Walk")
		else:
			player.velocity.x = 0
			Exit()
	
	if Input.is_action_just_pressed("shoot"):
		is_shooting = true
		player.change_anim("shoot_walk")
		timer.start()
		player.shoot()
		
	if Input.is_action_just_pressed("jump"):
		player.velocity.y = -player.JUMP_SPEED * 1.0
		state_transition.emit(self, "Onair")
	
	if not player.is_on_floor():
		state_transition.emit(self, "Onair")

func _on_shooting_timer_timeout() -> void:
	is_shooting = false
	animator.play("Walk")
	
#var player
#var anim
#var JUMP_SPEED = 285.0
#var left_right_key_press_time: float = 0
#var timer
#var is_shooting = false
#
## Called when the node enters the scene tree for the first time.
#func _ready():
	#timer = Timer.new()
	#add_child(timer)
	#player = get_parent().get_parent()
	#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#
	##gravity
	#if not player.is_on_floor():
		#get_parent().change_state("Onair")
	#
	#left_right_key_press_time += 60 * delta
	#
	##Actions
	##Movements
	#if is_shooting == false:
		#if Input.is_action_pressed("right"):
			#player.direction = 1#Input.get_axis("left", "right")
			#player.velocity.x =  player.WALK_SPEED
			#if left_right_key_press_time < 7: #max toe tipping frames
				#player.change_anim("Tipping")
			#else:
				#player.change_anim("walk")
	#
		#elif Input.is_action_pressed("left"):
			#player.direction = -1
			#player.velocity.x = -1 * player.WALK_SPEED
			#if left_right_key_press_time < 7: #max toe tipping frames
				#player.change_anim("Tipping")
			#else:
				#player.change_anim("walk")
		#else:
			#get_parent().change_state("Idle")
#
##SHOOT
	#if Input.is_action_just_pressed("shoot"):
		#is_shooting = true
		#player.change_anim("shoot_walk")
		#timer.wait_time = 0.25
		#timer.one_shot = true
		#timer.start()
		#timer.timeout.connect(_on_timer_timeout)
		#player.shoot()
		#
##Jump
	#if Input.is_action_just_pressed("jump"):
		#player.is_rising = true
		#player.velocity.y = -JUMP_SPEED * 1.0
		#get_parent().change_state("Onair")
#
#func _on_timer_timeout():
	#player.change_anim("walk")
	#is_shooting = false
