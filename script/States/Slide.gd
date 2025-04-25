extends State
class_name SlideState

@onready var animator = %AnimationPlayer
var player : CharacterBody2D

func enter():
	%Collision.disabled = true
	%SlidingColl.disabled = false
	player = get_tree().get_first_node_in_group("Player")
	player.velocity = Vector2(0,0)
	player.WALK_SPEED = 150
	animator.play("Slide")
	await get_tree().create_timer(0.6).timeout
	while %Raycast.is_colliding():
		await get_tree().create_timer(0.1).timeout  # Attendi un breve intervallo prima di controllare di nuovo
	
	exit()

func update(_delta) -> void:
	player.velocity.x = player.direction * player.WALK_SPEED
	var direction := Input.get_axis("left", "right")
	if direction != 0:
		player.direction = direction
		player.velocity.x = direction * player.WALK_SPEED
	
	if not player.is_on_floor():
		exit()

func exit():
	player.WALK_SPEED = 82.5
	%Collision.disabled = false
	%SlidingColl.disabled = true
	player.velocity.x = 0
	state_transition.emit(self, "Idle")
