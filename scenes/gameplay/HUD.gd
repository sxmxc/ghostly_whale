extends CanvasLayer

onready var player_score_value = $Margin/VBox/HBox/Label2
onready var bonus_score_value = $Margin/VBox/HBox2/Label2
onready var multiplier_value = $Margin/VBox/HBox3/Label2
onready var hud_message = $HudMessage


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _show_message(message, time):
	hud_message._display_message(message, time)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	player_score_value.set_text(str(Game.player_score))
	bonus_score_value.set_text(str(Game.bonus_score))
	multiplier_value.set_text(str(Game.score_multiplier))
	pass
