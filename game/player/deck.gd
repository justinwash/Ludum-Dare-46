extends Node

var count = 0
onready var cards = $Cards

export var AI = false

func _ready():
	for i in range(0, 60):
		if !AI:
			var card = load("res://card/card.tscn").instance()
			cards.add_child(card)
		else:
			var card = load("res://card/opp_card.tscn").instance()
			cards.add_child(card)
	
	for card in cards.get_children():
		card.input_pickable = false
		
func _physics_process(_delta):
	$Count.text = str(cards.get_child_count())
