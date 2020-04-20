extends Node2D

var turn_count = 0
onready var turn_count_label = $Camera/UI/TurnsCount

var lane_count = 5
onready var lane_count_label = $Camera/UI/LanesCount

var cards_count = 2
onready var cards_label = $Camera/UI/CardsCount

onready var player = $Player
onready var opponent = $Opponent
onready var board = $Board

onready var win_lose = $Camera/UI/WinLose
onready var theme_music = $Music

func _ready():
	player.connect("end_turn", self, "_increment_turn_count")
	opponent.connect("end_game", self, "_end_game")
	board.connect("lane_lost", self, "_lane_lost")
	board.connect("full_board", self, "_full_board")
	
	get_tree().paused = false
	theme_music.play()
	
	
func _physics_process(delta):
	turn_count_label.text = str(turn_count + 1) + " / 15"
	if turn_count >= 14:
		_end_game("turn limit")
		
	lane_count_label.text = str(lane_count) + " / 5"
	if lane_count <= 3:
		_end_game("lanes lost")
	
func _increment_turn_count():
	turn_count += 1
	if turn_count > 9:
		_enter_danger_mode(turn_count_label)
	
func _enter_danger_mode(label):
	label.set("custom_colors/font_color",Color(255,0,0))
	
func _lane_lost():
	lane_count -= 1
	_enter_danger_mode(lane_count_label)
	
func _full_board():
	_end_game("full board")
	
func set_cards_label(count):
	cards_count = count
	cards_label.text = str(cards_count)
	if cards_count < 2:
		_enter_danger_mode(cards_label)
	else:
		cards_label.set("custom_colors/font_color",Color(0,255,0))
	
func _end_game(reason):
	if reason == "turn limit":
		print("game ended: turn limit - you win!")
		win_lose.get_node("Win").visible = true
		win_lose.get_node("Lose").visible = false
	elif reason == "full board":
		print("game ended: full board - you might win.")
		var player_slots = 0
		var opp_slots = 0
		for slot in board.slots:
			if str(slot) != "[Deleted Object]":
				if slot.status_good:
					player_slots += 1
				else:
					opp_slots += 1
		if player_slots >=  opp_slots:
			win_lose.get_node("Win").visible = true
			win_lose.get_node("Lose").visible = false
		else:
			win_lose.get_node("Lose").visible = true
			win_lose.get_node("Win").visible = false
	elif reason == "lanes lost":
		print("game ended: connection lost - you lose")
		win_lose.get_node("Lose").visible = true
		win_lose.get_node("Win").visible = false
	else:
		print("game ended: for no reason?")
	get_tree().paused = true

func _on_Quit_button_up():
	get_tree().quit()

func _on_Again_button_up():
	get_tree().paused = false
	get_tree().reload_current_scene()
