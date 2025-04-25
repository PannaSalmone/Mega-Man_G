extends State
class_name HitState

@onready var animator = %AnimationPlayer
var player : CharacterBody2D

func enter():
	player = get_tree().get_first_node_in_group("Player")
	player.velocity = Vector2(0,0)
	animator.play("Damage")
	await get_tree().create_timer(0.6).timeout
	state_transition.emit(self, "Idle")

func exit():
	pass
