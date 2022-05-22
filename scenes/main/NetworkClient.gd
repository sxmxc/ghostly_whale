extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var client : NakamaClient
var session : NakamaSession

onready var data_container = $DataContainer
var current_user = "None"

signal data_loaded
signal high_score
signal done

# Called when the node enters the scene tree for the first time.
func _ready():
	var scheme = "https"
	var host = "ghostly_cloud.voidmoose.com"
	var port = 7350
	var server_key = "defaultkey"
	client = Nakama.create_client(server_key, host, port, scheme)
	_connect()
	

func _disconnect():
#	yield(client.session_logout_async(session), "completed")
	current_user = "none"
	Game.network_connected = false

func _connect():
	var deviceid
	if OS.has_feature('HTML5'):
		deviceid = "webuser%d" % rand_range(1000,9999)
		session = yield(client.authenticate_device_async(deviceid, deviceid), "completed")
	else:
		# Unique ID is not supported by Godot in HTML5, use a different way to generate an id, or a different authentication option.
		deviceid = OS.get_unique_id()
		session = yield(client.authenticate_device_async(deviceid), "completed")
	
	if session.is_exception():
		print("An error occured: %s" % session)
		return
	print("Successfully authenticated: %s" % session)
	Game.network_connected = true
	current_user = session.username

func _submit_score(board, score):
	if Game.network_connected:
		var record : NakamaAPI.ApiLeaderboardRecord = yield(client.write_leaderboard_record_async(session, board, score), "completed")
		if record.is_exception():
			print("An error occured: %s" % record)
		else:
			print("New level record username %s and score %s" % [record.username, record.score])
			emit_signal("high_score")
		
		var daily : NakamaAPI.ApiLeaderboardRecord = yield(client.write_leaderboard_record_async(session, board + "_daily", score), "completed")
		if daily.is_exception():
			print("An error occured: %s" % daily)
		else:
			print("New daily record username %s and score %s" % [daily.username, daily.score])
			emit_signal("high_score")
		
		var monthly : NakamaAPI.ApiLeaderboardRecord = yield(client.write_leaderboard_record_async(session, board + "_monthly", score), "completed")
		if monthly.is_exception():
			print("An error occured: %s" % monthly)
		else:
			print("New monthly record username %s and score %s" % [monthly.username, monthly.score])
			emit_signal("high_score")
		
		var yearly : NakamaAPI.ApiLeaderboardRecord = yield(client.write_leaderboard_record_async(session, board +"_yearly", score), "completed")
		if yearly.is_exception():
			print("An error occured: %s" % yearly)
		else:
			print("New yearly record username %s and score %s" % [yearly.username, yearly.score])
			emit_signal("high_score")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
