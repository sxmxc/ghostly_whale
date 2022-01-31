extends Node2D


onready var button_container = $CenterContainer2/GridContainer

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
		var button = Button.new()
		button.text = Game.level_dictionary[level].display_name
		button.disabled = Game.level_dictionary[level].locked
		button_container.add_child(button)
		button.connect("pressed", self, "_on_LevelButton_pressed", [Game.level_dictionary[level].scene])


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LevelButton_pressed(level):
	var params = {
		show_progress_bar = true,
		"round_time" : 90,
#		"a_number": 10,
#		"a_string": "Ciao mamma!",
#		"an_array": [1, 2, 3, 4],
#		"a_dict": {
#			"name": "test",
#			"val": 15
#		},
	}
	Game.change_scene(level, params)
