extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal ragdoll_destroyed
signal ragdoll_high_impact

onready var head_rigid_body = $Head
onready var body_rigid_body = $Body
onready var head_particles = $Head/Particles2D
onready var body_particles = $Body/Particles2D
onready var timer = $Timer
onready var camera = $Body/Camera2D

export var destroying = false

export var impact_threshold = 50
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _destroy():
	destroying = true
	head_particles.restart()
	head_particles.set_emitting(true)
	body_particles.restart()
	body_particles.set_emitting(true)
	head_rigid_body.sleeping = true
	body_rigid_body.sleeping = true
	timer.start()
	camera.shake(2,15,8)
	yield(timer,"timeout")
	emit_signal("ragdoll_destroyed")
	self.call_deferred("queue_free")
	

func launch(force: Vector2):
	body_rigid_body.apply_impulse(Vector2.ZERO, force)

func _on_VectorCreator_vector_created(vector):
	launch(vector)


func _on_Head_body_entered(body):
	if body is TileMap:
		if head_rigid_body.linear_velocity.x > impact_threshold || head_rigid_body.linear_velocity.y > impact_threshold:
			head_particles.restart()
			head_particles.set_emitting(true)
			emit_signal("ragdoll_high_impact")
	pass # Replace with function body.


func _on_Body_body_entered(body):
	if body is TileMap:
		if body_rigid_body.linear_velocity.x > impact_threshold || body_rigid_body.linear_velocity.y > impact_threshold:
			body_particles.restart()
			body_particles.set_emitting(true)
			emit_signal("ragdoll_high_impact")
	pass # Replace with function body.
