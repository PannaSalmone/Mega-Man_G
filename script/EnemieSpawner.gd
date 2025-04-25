extends Node2D

@export var enemie : PackedScene

@export_flags("when enter", "timed respawner", "unique" ) var spawn_type = 1 #now unused
@export var respawn_time := 3.0
@export var max_num_enemie = 3


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_visible_on_screen_notifier_2d_screen_entered():
	if spawn_type == 2: #respawner after fixed time
		var num = get_child_count()
		if num < max_num_enemie + 2:
			spawn()
			$Timer.wait_time = respawn_time
			$Timer.start()
	if spawn_type == 1:
		var num = get_child_count()
		if num < 3:
			spawn()
		

func spawn():
	var a = enemie.instantiate()
	add_child(a)
	a.global_position = self.global_position



func _on_timer_timeout():
	var num = get_child_count()
	if num < max_num_enemie + 2:
		spawn()
		$Timer.wait_time = respawn_time
		$Timer.start()


func _on_visible_on_screen_notifier_2d_screen_exited():
	$Timer.stop()
