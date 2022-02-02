extends CenterContainer

onready var timer = $Timer
onready var label = $Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	
func _display_message(message, time):
	label.set_text(message)
	timer.start(time)
	show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	hide()
