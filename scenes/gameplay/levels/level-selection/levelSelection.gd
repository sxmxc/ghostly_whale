extends Node2D


onready var button_container = $CenterContainer2/GridContainer
onready var canvas_mod = $CanvasModulate

var level_box_scene = preload("res://scenes/gameplay/levels/level-selection/LevelBox.tscn")

func pre_start(params):
	print("\nlevelSelection.gd:pre_start() called with params = ")
	if params:
		for key in params:
			var val = params[key]
			printt("", key, val)
	canvas_mod.visible = false
	set_process(false)

func _ready():
	pass
# `start()` is called when the graphic transition ends.
func start():
	canvas_mod.visible = true
	print("\ngameplay.gd:start() called")
	var active_scene: Node = Game.get_active_scene()
	print("\nCurrent active scene is: ",
		active_scene.name, " (", active_scene.filename, ")")
	for level in Game.level_dictionary:
		var level_box = level_box_scene.instance()
		level_box.get_node("Button").text = Game.level_dictionary[level].display_name
		level_box.get_node("Button").disabled = Game.level_dictionary[level].locked
		level_box.get_node("local_best").text = "Local best: %d" % Game.level_dictionary[level].current_high 
		if Game.network_connected:
			var global_best = Game.main.network_client.data_container.level_weekly_boards[level]
			if global_best.records.size() > 0:
				level_box.get_node("global_best").text = "Global best: %s" % global_best.records[0].score
		button_container.add_child(level_box)
		level_box.get_node("Button").connect("pressed", self, "_on_LevelButton_pressed", [level,Game.level_dictionary[level].scene])
	set_process(true)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LevelButton_pressed(level, level_path):
	var params = {
		show_progress_bar = true,
		fetch_data = false
	}
	Game.current_level = level
	Game.change_scene(level_path, params)


func _on_Button_pressed():
	Game.change_scene("res://scenes/menu/menu.tscn", {
		'show_progress_bar': true,
		'fetch_data': false
	})
