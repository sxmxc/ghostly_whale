extends Button


func _ready():
	# needed for gamepads to work
	grab_focus()


func _on_Button_pressed():
	var params = {
		show_progress_bar = true,
		fetch_data = false
	}
	SoundManager.play_se("stinger")
	Game.change_scene("res://scenes/gameplay/levels/level-selection/levelSelection.tscn", params)
