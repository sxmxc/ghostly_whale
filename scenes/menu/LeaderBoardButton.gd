extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	disabled = !Game.network_connected


func _on_LeaderBoardButton_pressed():
	var params = {
		show_progress_bar = true,
#		"round_time" : 90,
#		"a_number": 10,
#		"a_string": "Ciao mamma!",
#		"an_array": [1, 2, 3, 4],
#		"a_dict": {
#			"name": "test",
#			"val": 15
#		},
	}
	Game.change_scene("res://scenes/menu/LeaderBoards.tscn", params)
