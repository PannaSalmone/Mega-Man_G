extends Area2D
#tool 

signal ops  #U fallen in a pit or on some spikes

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(player):
	ops.emit()
