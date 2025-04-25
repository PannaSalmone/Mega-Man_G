extends State
class_name WalkingState

var left_right_key_press_time: float = 0
@onready var animator = %AnimationPlayer
var player : CharacterBody2D

func enter():
	animator.play("Tipping")
	left_right_key_press_time = 0
	player = get_tree().get_first_node_in_group("Player")
	player.is_shooting = false

func exit():
	state_transition.emit(self, "Idle")

func update(_delta: float):
	# Increase var value 
	left_right_key_press_time += 60 * _delta
	
	# Movements
	var direction := Input.get_axis("left", "right")
	if direction != 0:
		player.direction = direction
		player.velocity.x = direction * player.WALK_SPEED
		if player.is_shooting:
			animator.play("shoot_walk")
		else:
			animator.play("Tipping" if left_right_key_press_time < 7 else "Walk")
	else:
		player.velocity.x = 0
		exit()
	
	#slide
	if Input.is_action_just_pressed("slide"):
		state_transition.emit(self, "Slide")
	
	# Shooting
	if Input.is_action_just_pressed("shoot"):
		player.is_shooting = true
		player.change_anim("shoot_walk")
		player.shoot()

	# Jump
	if Input.is_action_just_pressed("jump"):
		if Input.is_action_pressed("down"):
			state_transition.emit(self, "Slide")
		else:
			player.velocity.y = -player.JUMP_SPEED
			state_transition.emit(self, "Onair")
	
	# Check if player is not on floor
	if not player.is_on_floor():
		state_transition.emit(self, "Onair")

func reset_anim() -> void:
	player.is_shooting = false
	animator.play("Walk")
