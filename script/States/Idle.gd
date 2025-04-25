extends State
class_name IdleState

@onready var animator = %AnimationPlayer
var player : CharacterBody2D

func enter():
	player = get_tree().get_first_node_in_group("Player")
	animator.play("Idle")
	
func update(_delta : float):
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		state_transition.emit(self, "Walk")

	if Input.is_action_just_pressed("shoot"):
		animator.play("shoot_idle")
		player.shoot()

	if Input.is_action_just_pressed("jump"):
		if Input.is_action_pressed("down"):
			state_transition.emit(self, "Slide")
		else:
			player.velocity.y = -player.JUMP_SPEED * 1.0
			state_transition.emit(self, "Onair")
	
	if not player.is_on_floor():
		state_transition.emit(self, "Onair")

func reset_anim() -> void:
	animator.play("Idle")

func exit():
	pass
