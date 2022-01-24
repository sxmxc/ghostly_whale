extends Node

var elapsed = 0

export var ragdoll_scene = preload("res://scenes/gameplay/Ragdoll.tscn")

onready var launcher = $Input/VectorCreator
onready var round_timer = $HUD/HudTimer
onready var round_end_canvas = $RoundEnd

var game_round_time

# `pre_start()` is called when a scene is loaded.
# Use this function to receive params from `Game.change_scene(params)`.
func pre_start(params):
	print("\ngameplay.gd:pre_start() called with params = ")
	if params:
		for key in params:
			var val = params[key]
			printt("", key, val)
	game_round_time = params["round_time"]
	set_process(false)


# `start()` is called when the graphic transition ends.
func start():
	print("\ngameplay.gd:start() called")
	var active_scene: Node = Game.get_active_scene()
	print("\nCurrent active scene is: ",
		active_scene.name, " (", active_scene.filename, ")")
	var new_dialog = Dialogic.start('tutorial')
	add_child(new_dialog)
	set_process(true)
	yield(new_dialog,"dialogic_signal")
	round_timer.connect("round_over", self, "_on_round_end")
	round_timer._start_round(game_round_time)


#func _process(delta):
#	elapsed += delta
#	$Sprite.position.x = Game.size.x / 2 + 150 * sin(2 * 0.4 * PI * elapsed)
#	$Sprite.position.y = Game.size.y / 2 + 100 * sin(2 * 0.2 *  PI * elapsed)

func _spawn_ragdoll():
	var position = get_tree().get_nodes_in_group("spawn_point")[0]
	var ragdoll = ragdoll_scene.instance()
	ragdoll.global_position = position.global_position
	ragdoll.connect("ragdoll_destroyed", self, "_on_Ragdoll_ragdoll_destroyed")
	ragdoll.connect("ragdoll_high_impact", self, "_on_Ragdoll_ragdoll_high_impact")
	launcher.connect("vector_created", ragdoll, "_on_VectorCreator_vector_created")
	add_child(ragdoll)

func _on_round_end():
	round_end_canvas._end_round()

func _on_Ragdoll_ragdoll_destroyed():
	Game.player_score += 100
	_spawn_ragdoll()
	pass # Replace with function body.


func _on_Ragdoll_ragdoll_high_impact():
	Game.player_score += 10
	pass # Replace with function body.
