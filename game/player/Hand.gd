extends Node2D

onready var slots = $Slots
onready var cards = $Cards

onready var deck = get_node("../Deck")

export var AI = false
		
func _start_turn():
	print("player turn started")
	
func draw_card():
	if deck.cards.get_child_count() > 0 and self.cards.get_child_count() < 5:
		var card = deck.cards.get_child(0)
		deck.cards.remove_child(card)
		self.cards.add_child(card)
		card.set_owner(self.cards)
		
		if !AI:
			card.input_pickable = true
		else:
			card.input_pickable = false
		card.z_index = 1
			
func draw_to_five():
	for i in (5 - cards.get_child_count()):
		draw_card()
		
	for i in range(0, cards.get_child_count()):
			cards.get_children()[i].position = slots.get_children()[i].position
