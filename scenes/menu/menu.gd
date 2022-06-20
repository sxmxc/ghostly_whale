extends Control

onready var canvas_mod = $Background/CanvasModulate
onready var splash = $Splash
onready var settings = $Foreground/SettingsPanel

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func pre_start(params = {"splash": true}):
	print("\nmenu.gd:pre_start() called with params = ")
	if params:
		for key in params:
			var val = params[key]
			printt("", key, val)
	canvas_mod.visible = false
	if params.has("show_splash"):
		if params["show_splash"]:
			splash.visible = true
		else:
			splash.visible = false
	set_process(false)
	
func start():
	canvas_mod.visible = true
	print("\nmenu.gd:start() called")
	var active_scene: Node = Game.get_active_scene()
	print("\nCurrent active scene is: ",
		active_scene.name, " (", active_scene.filename, ")")
	set_process(true)
	pass
# Called when the node enters the scene tree for the first time.
func _ready():
	SoundManager.stop("cold_world")
	SoundManager.stop("too_crazy")
	SoundManager.stop("engine")
	SoundManager.play_bgm("intro1")
	var timer = Timer.new()
	add_child(timer)
	timer.start(5)
	yield(timer,"timeout")
	timer.queue_free()
	splash.transition_out()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SettingsButton_pressed():
	settings.visible = true
	pass # Replace with function body.


func _on_BackButton_pressed():
	settings.visible = false
	pass # Replace with function body.
