extends Node2D

export(NodePath) var player_node
onready var player = get_node(player_node)

export(NodePath) var board_node
onready var board = get_node(board_node)

var played_cards = 0

onready var hand = $Hand

signal end_turn

func play_turn(num_cards, open_slots):
	for i in range(0, num_cards):
		play_one(open_slots)
	 
func play_one(open_slots):
	var chosen_slot = null
	while !chosen_slot:
		var slot = get_random_slot(open_slots)
		if slot && slot.card.get_child_count() == 0:
			chosen_slot = slot
			chosen_slot.accept_card(hand.cards.get_child(0))
			played_cards += 1
			break
		print("slot taken")
	
func _on_Player_end_turn():
	hand.draw_to_five()
	var open_slots = get_open_slots()
	
	if len(open_slots) >= 3:
		play_turn(3, open_slots)
	else:
		play_one(open_slots)
	end_turn()
	
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
