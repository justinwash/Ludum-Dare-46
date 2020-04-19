extends Node2D

var turn_count = 0
onready var turn_count_label = $Camera/UI/TurnsCount

var lane_count = 5
onready var lane_count_label = $Camera/UI/LanesCount

onready var player = $Player
onready var opponent = $Opponent
onready var board = $Board

func _ready():
	player.connect("end_turn", self, "_increment_turn_count")
	opponent.connect("end_game", self, "_end_game")
	board.connect("lane_lost", self, "_lane_lost")
	board.connect("full_board", self, "_full_board")
	
	
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
	_end_game("full_board")
	
func _end_game(reason):
	if reason == "turn limit":
		print("game ended: turn limit - you win!")
	elif reason == "full board":
		print("game ended: full board - you might win.")
	elif reason == "lanes lost":
		print("game ended: connection lost - you lose")
	else:
		print("game ended: for no reason?")
	get_tree().paused = true
