extends Node2D

export(NodePath) var opponent_node
onready var opponent = get_node(opponent_node)

export(NodePath) var board_node
onready var board = get_node(board_node)

onready var game = get_parent()

var held_card

var is_turn = false
var played_cards = 0

signal end_turn

onready var hand = $Hand
onready var pickup_sound = $Sounds/PickupSound

func _ready():
	for card in $Deck.cards.get_children():
		var _holding_card = card.connect("holding_card", self, "_holding_card")
		var _dropped_card = card.connect("dropped_card", self, "_dropped_card")
		
func _process(_delta):
	game.set_cards_label(2 - played_cards)
	if is_turn and played_cards > 1:
		played_cards = 0
		end_turn()
	
func _holding_card(card):
	if is_turn:
		if !held_card:
			pickup_sound.play()
			held_card = card
		
func _dropped_card(card):
	held_card = null

func _on_Opponent_end_turn():
	hand.draw_to_five()
	is_turn = true
	
func get_open_slots():
	var open_slots = []
	for slot in board.slots:
		if str(slot) != "[Deleted Object]":
			if slot.get_node("./Card").get_child_count() == 0:
				open_slots.append(slot)
	return open_slots
	
func end_turn():
	is_turn = false
	emit_signal("end_turn")


