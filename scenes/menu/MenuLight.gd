extends Light2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#onready var animation = $AnimationPlayer
onready var flicker_tween = $FlickerTween
onready var sway_tween = $SwayTween
onready var timer = $Timer
var rng = RandomNumberGenerator.new()
var sway_values =[38,-38]

# Called when the node enters the scene tree for the first time.
func _ready():
	var rando = rng.randi_range(0, 5)
	timer.connect("timeout", self, "_surge")
	rng.randomize()
	sway_tween.connect("tween_completed", self, "_on_sway_tween_completed")
	#animation.play("light_swing")
	timer.start(rando)
	_start_sway()


func _start_sway():
	sway_tween.interpolate_property(self,"rotation_degrees", sway_values[0], sway_values[1], 15,Tween.TRANS_ELASTIC,Tween.EASE_OUT_IN)
	sway_tween.start()
	

func _surge():
	var rando = rng.randi_range(0, 5)
	flicker_tween.interpolate_property(self,"energy", .5, 1, .5,Tween.TRANS_ELASTIC,Tween.EASE_IN_OUT)
	flicker_tween.start()
	timer.start(rando)

func _on_sway_tween_completed(_object, key):
	sway_values.invert()
	_start_sway()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
