# Game autoload. Use `Game` global variable as a shortcut to access
# features.
# Eg: `Game.change_scene("res://scenes/gameplay/gameplay.tscn)`
# Handles also the main game architecture when playing
# a specific scene.
extends Node


var size: Vector2 setget , get_size

onready var main: Main = get_node_or_null("/root/Main")

signal new_high_score
signal score_submitted

var quality = 100

var player_score = 0
var bonus_score = 0
var score_multiplier = 1
var high_score_achieved = false


var network_connected = false

var save_dictionary = {}
var level_dictionary = {
	1 : {"scene": "res://scenes/gameplay/levels/level1/level1.tscn",
		"display_name": " Intro ",
		"locked": false, 
		"current_high" : 0,
		"leaderboard_id" : 'level1'},
	2 : {"scene": "res://scenes/gameplay/levels/level2/level2.tscn",
		"display_name": " Level 2 ",
		"locked": true,
		"current_high" : 0,
		"leaderboard_id" : 'level2'},
	3 : {"scene": "res://scenes/gameplay/levels/level3/level3.tscn",
		"display_name": " Level 3 ",
		"locked": true,
		"current_high": 0,
		"leaderboard_id" : 'level3'},
	4 : {"scene": "res://scenes/gameplay/levels/level3/level3.tscn",
		"display_name": " Level 4 ",
		"locked": true,
		"current_high": 0,
		"leaderboard_id" : 'level4'},
	5 : {"scene": "res://scenes/gameplay/levels/level3/level3.tscn",
		"display_name": " Level 5 ",
		"locked": true,
		"current_high": 0,
		"leaderboard_id" : 'level5'},
	6 : {"scene": "res://scenes/gameplay/levels/level3/level3.tscn",
		"display_name": " Level 6 ",
		"locked": true,
		"current_high": 0,
		"leaderboard_id" : 'level6'},
	7 : {"scene": "res://scenes/gameplay/levels/level3/level3.tscn",
		"display_name": " Level 7 ",
		"locked": true,
		"current_high": 0,
		"leaderboard_id" : 'level7'},
	8 : {"scene": "res://scenes/gameplay/levels/level3/level3.tscn",
		"display_name": " Level 8 ",
		"locked": true,
		"current_high": 0,
		"leaderboard_id" : 'level8'},
	9 : {"scene": "res://scenes/gameplay/levels/level3/level3.tscn",
		"display_name": " Level 9 ",
		"locked": true,
		"current_high": 0,
		"leaderboard_id" : 'level9'},
	10 : {"scene": "res://scenes/gameplay/levels/level3/level3.tscn",
		"display_name": " Level 10 ",
		"locked": true,
		"current_high": 0,
		"leaderboard_id" : 'level10'},
	11 : {"scene": "res://scenes/gameplay/levels/level3/level3.tscn",
		"display_name": " Level 11",
		"locked": true,
		"current_high": 0,
		"leaderboard_id" : 'level11'},
	12 : {"scene": "res://scenes/gameplay/levels/level3/level3.tscn",
		"display_name": " Level 12",
		"locked": true,
		"current_high": 0,
		"leaderboard_id" : 'level12'},
	13 : {"scene": "res://scenes/gameplay/levels/level3/level3.tscn",
		"display_name": " Level 13 ",
		"locked": true,
		"current_high": 0,
		"leaderboard_id" : 'level13'},
	14 : {"scene": "res://scenes/gameplay/levels/level3/level3.tscn",
		"display_name": "Dev Sandbox",
		"locked": false,
		"current_high": 0,
		"leaderboard_id" : 'level3'},
}
var current_level = 1

signal client_data_loaded


func _ready():
	if main == null:
		call_deferred("_force_main_scene_load")



func _score_reset():
	player_score = 0
	bonus_score = 0
	score_multiplier = 1
	high_score_achieved = false

func _submit_score():
	main.network_client._submit_score(level_dictionary[current_level].leaderboard_id, (player_score + bonus_score) * score_multiplier)
	
func _on_high_score():
	emit_signal("new_high_score")
	
func _network_data_load():
	if network_connected:
		pass
	else:
		return

func _force_main_scene_load():
	# Loads scenes/main.tscn and set the currently played
	# scene as ActiveSceneContainer node.
	# Needed when playing a scene which is not
	# scenes/main.tscn (eg:with Play Scene with F6)
	var played_scene = get_tree().current_scene
	var root = get_node("/root")
	main = load("res://scenes/main/main.tscn").instance()
	main.splash_transition_on_start = true
	root.remove_child(played_scene)
	root.add_child(main)
	main.active_scene_container.get_child(0).queue_free()
	main.active_scene_container.add_child(played_scene)
	if played_scene.has_method("pre_start"):
		var params = {
		fetch_data = false,
	}
		played_scene.pre_start(params)
	if played_scene.has_method("start"):
		played_scene.start()
	played_scene.owner = main


func change_scene(new_scene, params= {}):
	main.change_scene(new_scene, params)


func restart_scene():
	main.restart_scene()


func restart_scene_with_params(override_params):
	main.restart_scene_with_params(override_params)


func reparent_node(node: Node2D, new_parent, update_transform = true):
	main.reparent_node(node, new_parent, update_transform)


func get_active_scene() -> Node:
	return main.get_active_scene()


func get_size():
	return main.size
