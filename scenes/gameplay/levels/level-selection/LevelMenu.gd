extends MarginContainer

var num_grids = 1
var current_grid = 1
var grid_width = 710

var level_box_scene = preload("res://scenes/gameplay/levels/level-selection/LevelBox.tscn")
var level_grid_scene = preload("res://scenes/gameplay/levels/level-selection/LevelGrid.tscn")

onready var gridbox = $VBoxContainer/HBoxContainer/ClipControl/GridBox
onready var tween = $Tween

onready var grid_prev = $VBoxContainer/HBoxContainer/GridPrev
onready var grid_next = $VBoxContainer/HBoxContainer/GridNext

signal level_selected

func _ready():
	var level_grid = level_grid_scene.instance()
	gridbox.add_child(level_grid)
	for level in Game.level_dictionary:
		var num_elements = level_grid.get_child_count()
		if num_elements >= level_grid.max_elements:
			level_grid = level_grid_scene.instance()
			gridbox.add_child(level_grid)
		var level_box = level_box_scene.instance()
		level_box.connect("level_selected", self, "_on_level_selected")
		#level_box.get_node("local_best").text = "Local best: %d" % Game.level_dictionary[level].current_high 
		if Game.network_connected:
			var global_best = Game.main.network_client.data_container.level_weekly_boards[level]
			if global_best.records.size() > 0:
				level_box.get_node("global_best").text = "Global best: %s" % global_best.records[0].score
		level_grid.add_child(level_box)
		level_box.level_num = level
		level_box.locked = Game.level_dictionary[level].locked
	num_grids = gridbox.get_child_count()
	if num_grids > 1:
		grid_next.disabled = false
	else:
		grid_next.disabled = true
		grid_prev.disabled = true
		
func _process(delta):
	if num_grids > 1:
		if current_grid > 1:
			grid_prev.disabled = false
		else:
			grid_prev.disabled = true
		if current_grid == num_grids:
			grid_next.disabled = true
		else:
			grid_next.disabled = false
	else:
		grid_next.disabled = true
		grid_prev.disabled = true
	

func _on_GridPrev_pressed():
	if current_grid > 1:
		current_grid -= 1
		gridbox.rect_position.x += grid_width
	pass # Replace with function body.


func _on_GridNext_pressed():
	if current_grid < num_grids:
		current_grid += 1
		gridbox.rect_position.x -= grid_width
	pass # Replace with function body.

func _on_level_selected(level_num):
	print("A level has been selected: ", level_num)
	emit_signal("level_selected", level_num)
	pass
