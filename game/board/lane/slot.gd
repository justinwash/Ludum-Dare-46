extends Sprite

var player
var incoming_card
onready var card = $Card

func _on_Area2D_mouse_entered():
	if player.held_card:
		player.held_card.set_scale(Vector2(0.3, 0.3))
		incoming_card = player.held_card
		incoming_card.process_drop = false

func _on_Area2D_mouse_exited():
	if player.held_card:
		player.held_card.set_scale(Vector2(0.435, 0.435))
		incoming_card.process_drop = true
		incoming_card = null
		
func _physics_process(_delta):
	if incoming_card and !Input.is_mouse_button_pressed(BUTTON_LEFT):
		if card.get_child_count() < 1:
			accept_card(incoming_card)

func accept_card(card):
	var card_to_add = card
	card = null
	card_to_add.owner.remove_child(card_to_add)
	self.card.add_child(card_to_add)
	card_to_add.set_owner(self.card)
	card_to_add.input_pickable = false
	card_to_add.set_scale(Vector2(1, 1))
	card_to_add.position = Vector2(0, 0)
	player.held_card = null
	player.played_cards += 1
