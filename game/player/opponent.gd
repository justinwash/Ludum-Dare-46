extends Node2D

var process = false
var t = 1

export(NodePath) var player_node
onready var player = get_node(player_node)

export(NodePath) var board_node
onready var board = get_node(board_node)

var played_cards = 0

onready var hand = $Hand
onready var game = get_parent()
onready var timer = $Timer

signal end_turn
signal end_game

func _physics_process(_delta):
	if (t % (1*60) == 0) and !process:
		process = true
		print("starting game after waiting")
		_on_Player_end_turn()
	t += 1

func play_turn(num_cards, open_slots):
	for i in range(0, num_cards):
		timer.connect("timeout", self, "play_one", [open_slots, num_cards])
		timer.set_wait_time(0.5)
		timer.start()
	 
func play_one(open_slots, num_cards):
	var chosen_slot = null
	while !chosen_slot:
		var slot = get_random_slot(open_slots)
		if slot && str(slot) != "[Deleted Object]" && slot.card.get_child_count() == 0:
			chosen_slot = slot
			chosen_slot.accept_card(hand.cards.get_child(0))
			played_cards += 1
			if played_cards >= num_cards:
				timer.disconnect("timeout", self, "play_one")
				end_turn()
			break
		print("slot taken")
	
func _on_Player_end_turn():
	if process:
		if game.turn_count >= 14:
			return
		hand.draw_to_five()
		var open_slots = get_open_slots()
	
		if len(open_slots) >= 3:
			play_turn(3, open_slots)
		elif len(open_slots) == 0:
			end_turn()
			return
		else:
			play_turn(1, open_slots)
		
func get_open_slots():
	var open_slots = []
	for slot in board.slots:
		if str(slot) != "[Deleted Object]":
			if slot.get_node("./Card").get_child_count() == 0:
				open_slots.append(slot)
	return open_slots
			

func get_random_slot(open_slots):
	randomize()
	var rand = int(rand_range(0, len(open_slots)))
	return open_slots[rand]
	
func end_turn():
	hand.draw_to_five()
	emit_signal("end_turn")
	played_cards = 0

func _on_Game_game_loaded():
	if game.turn_count >= 14:
		return
	hand.draw_to_five()
	var open_slots = get_open_slots()
	
	if len(open_slots) >= 3:
		play_turn(3, open_slots)
	else:
		play_turn(1, open_slots)
	end_turn()
