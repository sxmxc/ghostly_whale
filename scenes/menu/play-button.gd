extends Button


func _ready():
	# needed for gamepads to work
	grab_focus()


func _on_Button_pressed():
	var params = {
		show_progress_bar = true,
		fetch_data = true
#		"round_time" : 90,
#		"a_number": 10,
#		"a_string": "Ciao mamma!",
#		"an_array": [1, 2, 3, 4],
#		"a_dict": {
#			"name": "test",
#			"val": 15
#		},
	}
	SoundManager.play_se("stinger")
	Game.change_scene("res://scenes/gameplay/levels/level-selection/levelSelection.tscn", params)
