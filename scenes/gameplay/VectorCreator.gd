extends Area2D

signal vector_created(vector)

signal time_slowed
signal time_normal


export var maximum_length := 300

var touch_down := false
var position_start := Vector2.ZERO
var position_end := Vector2.ZERO

var player_position := Vector2.ZERO

var vector := Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("input_event", self, "_on_input_event")
#	for ragdoll in get_tree().get_nodes_in_group("ragdoll"):
#		connect("vector_created", ragdoll, "launch")


func _draw():	
	draw_line(position_start - global_position, position_start - global_position - vector, Color.blue, 8)
	_draw_dashed_line(player_position - global_position, player_position - global_position + vector, Color.red, 8)
	
func _draw_dashed_line(from, to, color, width, dash_length = 5, cap_end = false, antialiased = false):
	var length = (to - from).length()
	var normal = (to - from).normalized()
	var dash_step = normal * dash_length
	
	if length < dash_length: #not long enough to dash
		draw_line(from, to, color, width, antialiased)
		return

	else:
		var draw_flag = true
		var segment_start = from
		var steps = length/dash_length
		for start_length in range(0, steps + 1):
			var segment_end = segment_start + dash_step
			if draw_flag:
				draw_line(segment_start, segment_end, color, width, antialiased)

			segment_start = segment_end
			draw_flag = !draw_flag
		
		if cap_end:
			draw_line(segment_start, to, color, width, antialiased)
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	if touch_down:
		for ragdoll in get_tree().get_nodes_in_group("ragdoll"):
			player_position = ragdoll.get_node("Body").get_global_transform_with_canvas().origin
		update()

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
		Engine.time_scale = 1
		emit_signal("time_normal")
		_reset()

	if event is InputEventMouseMotion:
		position_end = event.position
		vector = -(position_end - position_start).clamped(maximum_length)
		Engine.time_scale = .125
		emit_signal("time_slowed")
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
		

