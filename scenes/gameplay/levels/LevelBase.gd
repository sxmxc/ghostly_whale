extends Node
class_name LevelBase

export var hyoomie_ragdoll_scene = preload("res://scenes/gameplay/ragdolls/HyoomieRagdoll.tscn")
export var goomie_ragdoll_scene = preload("res://scenes/gameplay/ragdolls/GoomieRagdoll.tscn")
export var goomi_ball_scene = preload("res://scenes/gameplay/ragdolls/NonRagdoll.tscn")
export var non_ragdoll_scene = preload("res://scenes/gameplay/ragdolls/NonRagdoll.tscn")
export var game_round_time = 90
export var level_y_bounds = 0

onready var launcher = $Input/VectorCreator
onready var hud = $HUD
onready var round_timer = $HUD/HudTimer
onready var round_end_canvas = $RoundEnd
onready var input_canvas = $Input

var rng = RandomNumberGenerator.new()
var rando = 0



# `pre_start()` is called when a scene is loaded.
# Use this function to receive params from `Game.change_scene(params)`.
func pre_start(params):
	print("\nLevelBase.gd:pre_start() called with params = ")
	if params:
		for key in params:
			var val = params[key]
			printt("", key, val)
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
	Game.connect("new_high_score", self, "_on_high_score")

func _ready():
	rng.randomize()
	rando = rng.randi_range(0, 1)
	
func _spawn_ragdoll():
	pass

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
	
	_spawn_ragdoll()
	pass # Replace with function body.

func _on_Ragdoll_ragdoll_hole_in_one():
	print("Hole in one")
	hud._show_message("Hole in one!", 3, hud.hud_message.anchor.global_position)
	hud._show_message("+500", 3, hud.bonus_anchor.global_position)
	Game.bonus_score += 500

func _on_Ragdoll_ragdoll_perfect():
	print("Perfect")
	hud._show_message("High Quality Meat!", 3, hud.hud_message.anchor.global_position + Vector2(0,20))
	hud._show_message("+1", 3, hud.mult_anchor.global_position)
	Game.score_multiplier += 1

func _on_Ragdoll_ragdoll_high_impact():
	Game.quality -= 10
	if Game.quality <= 0:
		Game.quality = 0
	hud._show_message("-10", 3, hud.quality_anchor.global_position)
	pass # Replace with function body.

func _on_high_score():
	hud._show_message("New High Score!", 3)
