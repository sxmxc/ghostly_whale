extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal ragdoll_destroyed
signal ragdoll_high_impact
signal hole_in_one
signal perfect

onready var head_rigid_body = $Head
onready var body_rigid_body = $Body
onready var blood_splatter = preload("res://scenes/gameplay/BloodSplatter.tscn")
onready var timer = $Timer
onready var camera = $Body/Camera2D

var destroying = false

export (Main.meat_type) var meat_type = Main.meat_type.HYOOMIE

export var impact_threshold = 50

var impulse_count = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	head_rigid_body.mode = RigidBody2D.MODE_KINEMATIC
	body_rigid_body.mode = RigidBody2D.MODE_KINEMATIC


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _destroy(grinder_type):
	SoundManager.play_se("impact")
	SoundManager.play_se("scream")
	if grinder_type == meat_type:
		add_points()
	else:
		remove_points()

	

func add_points():
	if impulse_count == 1:
		emit_signal("hole_in_one")
	if Game.quality == 100:
		emit_signal("perfect")
	destroying = true
	head_rigid_body.sleeping = true
	body_rigid_body.sleeping = true
	self.visible = false
	timer.start()
	camera.shake(2,15,8)
	var score = Game.quality
	Game.player_score += score
	get_parent().hud._show_message("+%d" % score, 3, get_parent().hud.score_anchor.global_position)
	yield(timer,"timeout")
	self.call_deferred("queue_free")
	emit_signal("ragdoll_destroyed")	
	
func remove_points():
	destroying = true
	head_rigid_body.sleeping = true
	body_rigid_body.sleeping = true
	self.visible = false
	timer.start()
	camera.shake(2,15,8)
	var score = Game.quality
	Game.player_score -= score
	get_parent().hud._show_message("-%d" % score, 3, get_parent().hud.score_anchor.global_position)
	yield(timer,"timeout")
	self.call_deferred("queue_free")
	emit_signal("ragdoll_destroyed")	

func launch(force: Vector2):
	SoundManager.play_se("impact")
	head_rigid_body.mode = RigidBody2D.MODE_RIGID
	body_rigid_body.mode = RigidBody2D.MODE_RIGID
	body_rigid_body.apply_impulse(Vector2.ZERO, force)
	impulse_count += 1

func _on_VectorCreator_vector_created(vector):
	launch(vector)

func _on_time_slowed():
	camera._blur(.01, Vector2(.5,.5))

func _on_time_normal():
	camera._blur(0)
	
func _on_Head_body_entered(body):
	if body in get_tree().get_nodes_in_group("obstacles"):
		SoundManager.play_se("impact")
		if head_rigid_body.linear_velocity.x > impact_threshold || head_rigid_body.linear_velocity.y > impact_threshold:
			SoundManager.play_se("splat")
			var splatter = blood_splatter.instance()
			Game.get_active_scene().add_child(splatter)
			splatter.global_position = head_rigid_body.global_position
			splatter.rotation = global_position.angle_to_point(body.global_position)
			emit_signal("ragdoll_high_impact")
	pass # Replace with function body.


func _on_Body_body_entered(body):
	pass # Replace with function body.
