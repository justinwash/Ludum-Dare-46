extends Node2D

export(NodePath) var player_node
onready var player = get_node(player_node)

var played_cards = 0

onready var hand = $Hand

signal end_turn

func play_three():
	for _i in range(0, 3):
		var slot #get_random_slot
		#while full
			#get another slot
		#slot.incoming_card = get_top_card
		#slot.
	 
func _on_Player_end_turn():
	hand.draw_to_five()
	play_three()
	emit_signal("end_turn")
	
func get_random_slot():
	#get rando lane, then rando slot
	pass
