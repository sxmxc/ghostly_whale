extends Area2D

signal vector_created(vector)

export var maximum_length := 400

var touch_down := false
var position_start := Vector2.ZERO
var position_end := Vector2.ZERO

var vector := Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("input_event", self, "_on_input_event")
	for ragdoll in get_tree().get_nodes_in_group("ragdoll"):
		connect("vector_created", ragdoll, "launch")


func _draw():
	draw_line(position_start - global_position, (position_end - global_position), Color.blue, 8)
	draw_line(position_start - global_position, position_start - global_position + vector, Color.red, 16)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _reset():
	position_start = Vector2.ZERO
	position_end = Vector2.ZERO
	vector = Vector2.ZERO
	
	update()

func _input(event):

	if not touch_down:
		return

	if event.is_action_released("ui_touch"):
		touch_down = false
		emit_signal("vector_created", vector * 2)
		_reset()

	if event is InputEventMouseMotion:
		position_end = event.position
		vector = -(position_end - position_start).clamped(maximum_length)
		update()

#func analog_signal_change(analogPosition, analogName):
#	if analogPosition:
#		touch_down = true
#		position_start = analogPosition
#		update()
#	else:
#		touch_down = false
#		vector = -(position_end - position_start).clamped(maximum_length)
#		emit_signal("vector_created", vector * 2)
#		_reset()

func _on_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("ui_touch"):
		touch_down = true
		position_start = event.position

