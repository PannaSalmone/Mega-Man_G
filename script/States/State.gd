extends Node
class_name State

#NOTE This is the State base-class, all our specific states inherits this logic
# DO NOT CHANGE THIS unless you know what you are doing

@warning_ignore("unused_signal")
signal state_transition

func enter() -> void:
	pass
	
func exit() -> void:
	pass
	
func update(_delta:float) -> void:
	pass

func reset_anim() -> void:
	pass
