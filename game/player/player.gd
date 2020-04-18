extends Node2D

var held_card

func _ready():
	for card in $Deck.cards.get_children():
		var _holding_card = card.connect("holding_card", self, "_holding_card")
		var _dropped_card = card.connect("dropped_card", self, "_dropped_card")
		
func _holding_card(card):
	if !held_card:
		held_card = card
		print("picked up card: ", held_card)
		
func _dropped_card(card):
	held_card = null
	print("dropped card: ", card)
