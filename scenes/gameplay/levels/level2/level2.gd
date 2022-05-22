extends LevelBase

# `pre_start()` is called when a scene is loaded.
# Use this function to receive params from `Game.change_scene(params)`.
func pre_start(params):
	.pre_start(params)
	pass


# `start()` is called when the graphic transition ends.
func start():
	for child in input_canvas.get_children():
		child.hide()
	var new_dialog = Dialogic.start('level2')
	add_child(new_dialog)
	set_process(true)
	yield(new_dialog,"dialogic_signal")
	for child in input_canvas.get_children():
		child.show()
	.start()

func _spawn_ragdoll():
	Game.quality = 100
	var position = get_tree().get_nodes_in_group("spawn_point")[0]
	var ragdoll
	rando = rng.randi_range(0, 1)
	if rando == 0:
		ragdoll = hyoomie_ragdoll_scene.instance()
	elif rando == 1:
		ragdoll = goomie_ragdoll_scene.instance()
	ragdoll.global_position = position.global_position
	ragdoll.connect("ragdoll_destroyed", self, "_on_Ragdoll_ragdoll_destroyed")
	ragdoll.connect("ragdoll_high_impact", self, "_on_Ragdoll_ragdoll_high_impact")
	ragdoll.connect("hole_in_one", self, "_on_Ragdoll_ragdoll_hole_in_one")
	ragdoll.connect("perfect", self, "_on_Ragdoll_ragdoll_perfect")
	launcher.connect("vector_created", ragdoll, "_on_VectorCreator_vector_created")
	launcher.connect("time_slowed", ragdoll,"_on_time_slowed")
	launcher.connect("time_normal", ragdoll,"_on_time_normal")
	add_child(ragdoll)
	ragdoll.camera.limit_right = level_y_bounds
