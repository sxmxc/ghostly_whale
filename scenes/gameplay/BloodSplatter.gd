extends Particles2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_emitting(true)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	queue_free()
#	set_process(false)
#	set_physics_process(false)
#	set_process_input(false)
#	set_process_internal(false)
#	set_process_unhandled_input(false)
#	set_process_unhandled_key_input(false)
	
