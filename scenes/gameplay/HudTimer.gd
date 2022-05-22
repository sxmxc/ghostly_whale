extends CenterContainer

onready var timer = $Timer
onready var timer_value = $VBoxContainer/Value
onready var timer_display = $VBoxContainer/CenterContainer/ProgressBar2


signal round_over

var round_time = 90

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	timer_display.max_value = round_time 
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
# warning-ignore:integer_division
	var minutes = int(timer.get_time_left()) / 60
	var seconds = int(timer.get_time_left()) % 60
	
	timer_value.text = "%02d:%02d" % [minutes, seconds]
	timer_display.set_value(timer.get_time_left())
	pass

func _start_round(rt = 90):
	round_time = rt
	timer_display.max_value = round_time
	timer.start(round_time)
	print("Round Timer Starting")

func _on_Timer_timeout():
	emit_signal("round_over")
	print("Round Timer Timeout")
	pass # Replace with function body.
