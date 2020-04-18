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
			incoming_card.owner.remove_child(incoming_card)
			self.card.add_child(incoming_card)
			incoming_card.set_owner(self.card)
			incoming_card.input_pickable = false
			incoming_card.set_scale(Vector2(1, 1))
			incoming_card.position = Vector2(0, 0)
			player.held_card = null
