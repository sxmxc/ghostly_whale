extends Area2D

onready var particles = $Particles2D
onready var explode_particles = $ExplodingParticles
onready var animation_player = $AnimationPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("blades_running")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_KillZone_body_entered(body):
	if body.get_parent() in get_tree().get_nodes_in_group("ragdoll"):
		if !body.get_parent().destroying:
			body.get_parent()._destroy()
			particles.restart()
			particles.set_emitting(true)
			explode_particles.restart()
			explode_particles.set_emitting(true)
	pass # Replace with function body.
