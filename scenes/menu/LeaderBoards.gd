extends Control

onready var tab_container = $Margin/TabContainer

var board_panel = preload("res://scenes/menu/LeaderBoardPanel.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	_load_data()

func _load_data():
	for level in Game.level_dictionary:
		var panel = board_panel.instance()
		panel.name = Game.level_dictionary[level].leaderboard_id
		var weekly = Game.main.network_client.data_container.level_weekly_boards[level]
		for r in weekly.records:
			var center = CenterContainer.new()
			var label = Label.new()
			var record : NakamaAPI.ApiLeaderboardRecord = r
			label.text = "%s : %s" % [record.username, record.score]
			center.add_child(label)
			panel.get_node("Margin/Hbox/WeeklyContainer/values/").add_child(center)
		var monthly = Game.main.network_client.data_container.level_monthly_boards[level]
		for r in monthly.records:
			var center = CenterContainer.new()
			var label = Label.new()
			var record : NakamaAPI.ApiLeaderboardRecord = r
			label.text = "%s : %s" % [record.username, record.score]
			center.add_child(label)
			panel.get_node("Margin/Hbox/MonthlyContainer/values/").add_child(center)
		var daily = Game.main.network_client.data_container.level_daily_boards[level]
		for r in daily.records:
			var center = CenterContainer.new()
			var label = Label.new()
			var record : NakamaAPI.ApiLeaderboardRecord = r
			label.text = "%s : %s" % [record.username, record.score]
			center.add_child(label)
			panel.get_node("Margin/Hbox/DailyContainer/values/").add_child(center)
		var yearly = Game.main.network_client.data_container.level_yearly_boards[level]
		for r in yearly.records:
			var center = CenterContainer.new()
			var label = Label.new()
			var record : NakamaAPI.ApiLeaderboardRecord = r
			label.text = "%s : %s" % [record.username, record.score]
			center.add_child(label)
			panel.get_node("Margin/Hbox/YearlyContainer/values/").add_child(center)
		
		tab_container.add_child(panel)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	Game.change_scene("res://scenes/menu/menu.tscn", {
		'show_progress_bar': true,
		'fetch_data' : false
	})
