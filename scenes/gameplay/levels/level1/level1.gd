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
	var new_dialog = Dialogic.start('tutorial')
	add_child(new_dialog)
	set_process(true)
	yield(new_dialog,"dialogic_signal")
	for child in input_canvas.get_children():
		child.show()
	.start()


