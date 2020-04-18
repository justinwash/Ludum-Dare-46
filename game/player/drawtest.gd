extends Button

onready var hand = get_node("../Hand")

func _on_Button_button_up():
	hand.draw_card()
