extends Control

onready var canvas_mod = $CanvasModulate

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func pre_start(params):
	canvas_mod.visible = false
	
func start():
	canvas_mod.visible = true
	pass
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
