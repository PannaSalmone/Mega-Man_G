extends State
class_name DeadState

var player : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func enter():
	player = get_tree().get_first_node_in_group("Player")
	player.velocity.x = 0
	player.velocity.y = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
