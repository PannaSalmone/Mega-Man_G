extends Area2D

var speed = 20
var spawned_time = 0.0

func _ready():
	$Sprite2D/AnimationPlayer.play("bubble")
	spawned_time = Time.get_ticks_msec() / 1000.0  # Memorizza il momento della creazione

func _process(delta):
	translate(speed * delta * Vector2(0, -1))

	# Aspetta un piccolo intervallo prima di controllare la collisione
	if Time.get_ticks_msec() / 1000.0 - spawned_time > 0.1:
		if !has_overlapping_bodies():
			print("puff")  # Debug
			queue_free()
	
