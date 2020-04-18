extends Node

var count = 0
onready var cards = $Cards

func _ready():
	for card in cards.get_children():
		card.input_pickable = false
		
func _physics_process(_delta):
	$Count.text = str(cards.get_child_count())
