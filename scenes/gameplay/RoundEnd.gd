extends CanvasLayer

onready var panel := $Panel
onready var base_score_label = $Panel/Margin/VBox/BaseScore/Value
onready var bonus_score_label = $Panel/Margin/VBox/BonusScore/Value
onready var multip_score_label = $Panel/Margin/VBox/MulitplierScore/Value
onready var total_score_label = $Panel/Margin/VBox/TotalScore/HBoxContainer/Value
onready var new_high_score_label = $Panel/Margin/VBox/Center2/HighScoreLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	panel.visible = false
	
	pass # Replace with function body.


func _end_round(base, bonus, mult):
	get_tree().paused = true
	base_score_label.text = str(base)
	bonus_score_label.text = str(bonus)
	multip_score_label.text = "x%d" % mult
	total_score_label.text = str((base + bonus) * mult)
	new_high_score_label.visible = Game.high_score_achieved
	panel.visible = true
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	new_high_score_label.visible = Game.high_score_achieved


func _on_Quit_pressed():
	get_tree().paused = false
	Game.change_scene("res://scenes/menu/menu.tscn", {
		'show_progress_bar': true,
		'fetch_data': false
	})



func _on_Continue_pressed():
	get_tree().paused = false
	var params = {
		show_progress_bar = true,
		fetch_data = false
	#		"a_number": 10,
	#		"a_string": "Ciao mamma!",
	#		"an_array": [1, 2, 3, 4],
	#		"a_dict": {
	#			"name": "test",
	#			"val": 15
	#		},
	}
	Game.current_level += 1
	if Game.current_level > Game.level_dictionary.size():
		Game.current_level = 1
		Game.change_scene("res://scenes/gameplay/levels/level-selection/levelSelection.tscn", {
		'show_progress_bar': true,
		'fetch_data': true
	})
	else:
		Game.change_scene(Game.level_dictionary[Game.current_level].scene, params)
