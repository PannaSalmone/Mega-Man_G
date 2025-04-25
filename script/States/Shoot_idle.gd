extends State
class_name ShootingState

@onready var timer := %ShootingTimer
@onready var animator = %AnimationPlayer
var player : CharacterBody2D

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	player.velocity = Vector2(0,0)
	animator.play("Idle")
	
func Update(_delta : float):
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		state_transition.emit(self, "Walk")
		
	if Input.is_action_just_pressed("shoot"):
		animator.play("shoot_idle")
		timer.start()
		player.shoot()
	
	if Input.is_action_just_pressed("jump"):
		player.velocity.y = -player.JUMP_SPEED * 1.0
		state_transition.emit(self, "Onair")
	
	if not player.is_on_floor():
		state_transition.emit(self, "Onair")

func Exit():
	pass

func _on_shooting_timer_timeout() -> void:
	print("timer to idle")
	animator.play("Idle")
