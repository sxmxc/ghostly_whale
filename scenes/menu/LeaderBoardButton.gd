extends Button

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	disabled = !Game.network_connected


func _on_LeaderBoardButton_pressed():
	var params = {
		show_progress_bar = true,
		fetch_data = true
	}
	Game.change_scene("res://scenes/menu/LeaderBoards.tscn", params)
