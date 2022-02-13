extends MarginContainer

onready var anchor = $MessageAnchor
onready var tween = $Tween
onready var vis_tween = $Tween2
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _display_message(message, time, location = anchor.global_position):
	var label = Label.new()
	var timer = Timer.new()
	timer.connect("timeout", label, "queue_free")
	label.set_text(message)
	label.add_child(timer)
	add_child(label)
	label.set_global_position(location)
	tween.interpolate_property(label, "rect_position",
		label.rect_position, label.rect_position + Vector2(0, -100), time,
		Tween.TRANS_CIRC, Tween.EASE_IN)
	tween.start()
	vis_tween.interpolate_property(label, "modulate",
		Color(1, 1, 1, 1), Color(1, 1, 1, 0), time,
		Tween.TRANS_CIRC, Tween.EASE_IN)
	vis_tween.start()
	timer.start(time)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



