extends Node2D



onready var canvas_mod = $CanvasModulate
onready var level_menu = $CanvasLayer/LevelMenu

func pre_start(params):
	print("\nlevelSelection.gd:pre_start() called with params = ")
	if params:
		for key in params:
			var val = params[key]
			printt("", key, val)
	canvas_mod.visible = false
	set_process(false)

func _ready():
	level_menu.connect("level_selected", self, "_on_LevelButton_pressed")
	pass
# `start()` is called when the graphic transition ends.
func start():
	canvas_mod.visible = true
	print("\ngameplay.gd:start() called")
	var active_scene: Node = Game.get_active_scene()
	print("\nCurrent active scene is: ",
		active_scene.name, " (", active_scene.filename, ")")
	set_process(true)
	

func _on_LevelButton_pressed(level_num):
	var params = {
		show_progress_bar = true,
		fetch_data = false
	}
	Game.current_level = level_num
	Game.change_scene(Game.level_dictionary[level_num].scene, params)


func _on_Button_pressed():
	Game.change_scene("res://scenes/menu/menu.tscn", {
		'show_progress_bar': true,
		'fetch_data': false
	})
