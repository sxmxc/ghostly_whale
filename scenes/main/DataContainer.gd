extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var level_weekly_boards = {}
var level_daily_boards = {}
var level_monthly_boards = {}
var level_yearly_boards = {}

signal data_loaded
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _load_leader_boards():
	for level in Game.level_dictionary:
		level_weekly_boards[level] = yield(get_parent().client.list_leaderboard_records_async(get_parent().session, Game.level_dictionary[level].leaderboard_id), "completed")
		level_daily_boards[level] = yield(get_parent().client.list_leaderboard_records_async(get_parent().session, Game.level_dictionary[level].leaderboard_id + "_daily"), "completed")
		level_monthly_boards[level] = yield(get_parent().client.list_leaderboard_records_async(get_parent().session, Game.level_dictionary[level].leaderboard_id + "_monthly"), "completed")
		level_yearly_boards[level] = yield(get_parent().client.list_leaderboard_records_async(get_parent().session, Game.level_dictionary[level].leaderboard_id + "_yearly"), "completed")
	emit_signal("data_loaded")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
