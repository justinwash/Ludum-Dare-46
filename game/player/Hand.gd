extends Node2D

var slots
var cards

onready var deck = get_node("../Deck")

func _ready():
	slots = $Slots.get_children()
	cards = $Cards.get_children()
	
	for i in range(0, len(cards)):
			cards[i].position = slots[i].position
		
func _physics_process(_delta):
	pass
	
func _add_card():
	pass
