extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var level_leader_boards = {}

signal data_loaded
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _load_leader_boards():
	for level in Game.level_dictionary:
		level_leader_boards[level] = yield(get_parent().client.list_leaderboard_records_async(get_parent().session, Game.level_dictionary[level].leaderboard_id), "completed")
	emit_signal("data_loaded")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
