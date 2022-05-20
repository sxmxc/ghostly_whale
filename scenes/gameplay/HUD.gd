extends CanvasLayer

onready var player_score_value = $ScoreBox/VBox/HBox/Label2
onready var bonus_score_value = $ScoreBox/VBox/HBox2/Label2
onready var multiplier_value = $ScoreBox/VBox/HBox3/TextureRect/Label2
onready var hud_message = $HudMessage
onready var score_anchor = $ScoreBox/VBox/HBox/ScoreAddAnchor
onready var bonus_anchor = $ScoreBox/VBox/HBox2/BonusAddAnchor
onready var mult_anchor = $ScoreBox/VBox/HBox3/MultAddAnchor
onready var quality_value = $MarginContainer/VBoxContainer/CenterContainer/ProgressBar
onready var quality_anchor = $MarginContainer/VBoxContainer/CenterContainer/ProgressBar/QualityAnchor
onready var quality_label = $MarginContainer/VBoxContainer/CenterContainer/ProgressBar/Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _show_message(message, time, position := hud_message.anchor.position):
	hud_message._display_message(message, time, position)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	player_score_value.set_text(str(Game.player_score))
	bonus_score_value.set_text(str(Game.bonus_score))
	multiplier_value.set_text("x%s" % str(Game.score_multiplier))
	quality_value.set_value(Game.quality)
	quality_label.set_text("%s%%" % str(Game.quality))
	pass
