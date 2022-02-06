extends Node2D


onready var button_container = $CenterContainer2/GridContainer

var level_box_scene = preload("res://scenes/gameplay/levels/level-selection/LevelBox.tscn")

func pre_start(params):
	print("\nlevelSelection.gd:pre_start() called with params = ")
	if params:
		for key in params:
			var val = params[key]
			printt("", key, val)
	set_process(false)


# `start()` is called when the graphic transition ends.
func start():
	print("\ngameplay.gd:start() called")
	var active_scene: Node = Game.get_active_scene()
	print("\nCurrent active scene is: ",
		active_scene.name, " (", active_scene.filename, ")")
	set_process(true)
	for level in Game.level_dictionary:
		var level_box = level_box_scene.instance()
		level_box.get_node("Button").text = Game.level_dictionary[level].display_name
		level_box.get_node("Button").disabled = Game.level_dictionary[level].locked
		level_box.get_node("Label").text = "Current high: %d" % Game.level_dictionary[level].current_high 
		button_container.add_child(level_box)
		level_box.get_node("Button").connect("pressed", self, "_on_LevelButton_pressed", [level,Game.level_dictionary[level].scene])


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LevelButton_pressed(level, level_path):
	var params = {
		show_progress_bar = true,
		"round_time" : 90,
	}
	Game.current_level = level
	Game.change_scene(level_path, params)


func _on_Button_pressed():
	Game.change_scene("res://scenes/menu/menu.tscn", {
		'show_progress_bar': true
	})
