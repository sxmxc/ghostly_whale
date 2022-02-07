extends Node
class_name LevelBase

export var ragdoll_scene = preload("res://scenes/gameplay/Ragdoll.tscn")

onready var launcher = $Input/VectorCreator
onready var hud = $HUD
onready var round_timer = $HUD/HudTimer
onready var round_end_canvas = $RoundEnd
onready var input_canvas = $Input

var game_round_time

# `pre_start()` is called when a scene is loaded.
# Use this function to receive params from `Game.change_scene(params)`.
func pre_start(params):
	print("\nLevelBase.gd:pre_start() called with params = ")
	if params:
		for key in params:
			var val = params[key]
			printt("", key, val)
	game_round_time = params["round_time"]
	Game._score_reset()
	set_process(false)


# `start()` is called when the graphic transition ends.
func start():
	print("\nLevelBase.gd:start() called")
	var active_scene: Node = Game.get_active_scene()
	print("\nCurrent active scene is: ",
		active_scene.name, " (", active_scene.filename, ")")
	set_process(true)
	_spawn_ragdoll()
	round_timer.connect("round_over", self, "_on_round_end")
	round_timer._start_round(game_round_time)
	
func _spawn_ragdoll():
	var position = get_tree().get_nodes_in_group("spawn_point")[0]
	var ragdoll = ragdoll_scene.instance()
	ragdoll.global_position = position.global_position
	ragdoll.connect("ragdoll_destroyed", self, "_on_Ragdoll_ragdoll_destroyed")
	ragdoll.connect("ragdoll_high_impact", self, "_on_Ragdoll_ragdoll_high_impact")
	ragdoll.connect("hole_in_one", self, "_on_Ragdoll_ragdoll_hole_in_one")
	launcher.connect("vector_created", ragdoll, "_on_VectorCreator_vector_created")
	add_child(ragdoll)

func _on_round_end():
	for child in input_canvas.get_children():
		child.hide()
	Game._submit_score()
	round_end_canvas._end_round(Game.player_score, Game.bonus_score, Game.score_multiplier)
	var total_score = (Game.player_score + Game.bonus_score) * Game.score_multiplier
	if Game.level_dictionary[Game.current_level].current_high < total_score:
		Game.level_dictionary[Game.current_level].current_high = total_score
	if Game.level_dictionary.has(Game.current_level + 1):
		Game.level_dictionary[Game.current_level + 1].locked = false
	

func _on_Ragdoll_ragdoll_destroyed():
	Game.player_score += 100
	_spawn_ragdoll()
	pass # Replace with function body.

func _on_Ragdoll_ragdoll_hole_in_one():
	print("Hole in one")
	hud._show_message("Hole in one!", 3)
	Game.bonus_score += 500

func _on_Ragdoll_ragdoll_high_impact():
	Game.player_score += 10
	pass # Replace with function body.
