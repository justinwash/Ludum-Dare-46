extends Node2D

export(NodePath) var opponent_node
onready var opponent = get_node(opponent_node)

var held_card

var is_turn = false
var played_cards = 0

signal end_turn

onready var hand = $Hand

func _ready():
	for card in $Deck.cards.get_children():
		var _holding_card = card.connect("holding_card", self, "_holding_card")
		var _dropped_card = card.connect("dropped_card", self, "_dropped_card")
		
	end_turn()
		
func _process(_delta):
	if played_cards > 2:
		played_cards = 0
		end_turn()
	
func _holding_card(card):
	if !held_card:
		held_card = card
		
func _dropped_card(card):
	held_card = null

func _on_Opponent_end_turn():
	hand.draw_to_five()
	
func end_turn():
	emit_signal("end_turn")
