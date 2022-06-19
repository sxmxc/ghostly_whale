extends CanvasLayer

onready var anim = $AnimationPlayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func transition_out():
	anim.play("fade_out")
	
func transition_in():
	anim.play_backwards("fade_out")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
