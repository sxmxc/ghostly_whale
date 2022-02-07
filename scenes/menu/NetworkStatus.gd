extends VBoxContainer

onready var status_label = $HBoxContainer/NetworkStatusLabel
onready var status_icon = $HBoxContainer/TextureRect

onready var current_user_label = $HBoxContainer2/Label2

var connected_icon = preload("res://assets/bolt-icon-button-green.png")
var disconnected_icon = preload("res://assets/bolt-icon-button-red.png")
var connected = false


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	connected = Game.network_connected
	if connected:
		status_icon.texture_normal = connected_icon
		current_user_label.text = Game.main.network_client.current_user
	else:
		status_icon.texture_normal = disconnected_icon
		current_user_label.text = Game.main.network_client.current_user
	pass


func _on_TextureRect_pressed():
	if connected:
		Game.main.network_client._disconnect()
	else:
		Game.main.network_client._connect()
