extends LevelBase

# `pre_start()` is called when a scene is loaded.
# Use this function to receive params from `Game.change_scene(params)`.
func pre_start(params):
	.pre_start(params)
	pass


# `start()` is called when the graphic transition ends.
func start():
	var new_dialog = Dialogic.start('tutorial')
	add_child(new_dialog)
	set_process(true)
	yield(new_dialog,"dialogic_signal")
	.start()


#func _process(delta):
#	elapsed += delta
#	$Sprite.position.x = Game.size.x / 2 + 150 * sin(2 * 0.4 * PI * elapsed)
#	$Sprite.position.y = Game.size.y / 2 + 100 * sin(2 * 0.2 *  PI * elapsed)


