extends Node2D

onready var slots = $Slots
onready var cards = $Cards

onready var deck = get_node("../Deck")

func _ready():
	for i in range(0, cards.get_child_count()):
			cards.get_children()[i].position = slots.get_children()[i].position
		
func _physics_process(_delta):
	pass
	
func draw_card():
	if deck.cards.get_child_count() > 0 and self.cards.get_child_count() < 5:
		var card = deck.cards.get_child(0)
		deck.cards.remove_child(card)
		self.cards.add_child(card)
		card.set_owner(self.cards)
		
		card.input_pickable = true
		card.z_index = 1
		
		for i in range(0, cards.get_child_count()):
			cards.get_children()[i].position = slots.get_children()[i].position
