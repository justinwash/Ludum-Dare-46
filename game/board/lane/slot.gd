extends Sprite

onready var player_node = get_node("../../../../../Player")

var player
var incoming_card

var good_color = Color(0,255,0)
var bad_color = Color(255,0,0)
var status_good = true

onready var card = $Card
onready var lane = int(owner.get_name().substr(4))
onready var slot = int(get_name().substr(4))
onready var board = owner.get_owner()

func _ready():
	var _player_turn_end = player_node.connect("end_turn", self, "_player_turn_end")
	
func _player_turn_end():
	incoming_card = null
	
func _on_Area2D_mouse_entered():
	if player.held_card:
		player.held_card.set_scale(Vector2(0.3, 0.3))
		incoming_card = player.held_card
		incoming_card.process_drop = false

func _on_Area2D_mouse_exited():
	if player.held_card:
		player.held_card.set_scale(Vector2(0.435, 0.435))
		if incoming_card:
			incoming_card.process_drop = true
		incoming_card = null
		
func _process(_delta):
	if incoming_card and !Input.is_mouse_button_pressed(BUTTON_LEFT):
		if card.get_child_count() < 1:
			accept_card(incoming_card)
		else:
			incoming_card = null

func accept_card(card):
	var card_to_add = card
	card = null
	if card_to_add.owner:
		card_to_add.owner.remove_child(card_to_add)
	self.card.add_child(card_to_add)
	card_to_add.set_owner(self.card)
	card_to_add.input_pickable = false
	card_to_add.set_scale(Vector2(1, 1))
	card_to_add.position = Vector2(0, 0)
	if card_to_add.side == "player":
		set_status_good(true)
		player.held_card = null
		player.played_cards += 1
	else:
		set_status_good(false)
	
	do_effects(card_to_add)
		
func set_status_good(status):
	if status:
		status_good = true
		$Indicator.color = good_color
	else:
		status_good = false
		$Indicator.color = bad_color
		
func do_effects(card):
	if card.effects.left:
		var slot_should_remove = get_node("../../../Lane"+str(lane-1)+"/Slots/Slot"+str(slot))
		if slot_should_remove:
			if slot_should_remove.card.get_child_count() > 0:
				var card_to_remove = slot_should_remove.card.get_child(0)
				if card_to_remove.side != card.side:
					slot_should_remove.card.remove_child(slot_should_remove.card.get_child(0))
			
	if card.effects.up:
		var slot_should_remove = get_node("../../../Lane"+str(lane)+"/Slots/Slot"+str(slot+1))
		if slot_should_remove:
			if slot_should_remove.card.get_child_count() > 0:
				var card_to_remove = slot_should_remove.card.get_child(0)
				if card_to_remove.side != card.side:
					slot_should_remove.card.remove_child(slot_should_remove.card.get_child(0))
		
	if card.effects.right:
		var slot_should_remove = get_node("../../../Lane"+str(lane+1)+"/Slots/Slot"+str(slot))
		if slot_should_remove:
			if slot_should_remove.card.get_child_count() > 0:
				var card_to_remove = slot_should_remove.card.get_child(0)
				if card_to_remove.side != card.side:
					slot_should_remove.card.remove_child(slot_should_remove.card.get_child(0))
			
	if card.effects.down:
		var slot_should_remove = get_node("../../../Lane"+str(lane)+"/Slots/Slot"+str(slot-1))
		if slot_should_remove:
			if slot_should_remove.card.get_child_count() > 0:
				var card_to_remove = slot_should_remove.card.get_child(0)
				if card_to_remove.side != card.side:
					slot_should_remove.card.remove_child(slot_should_remove.card.get_child(0))
					
func get_open_slots():
	var open_slots = []
	for slot in board.slots:
		if str(slot) != "[Deleted Object]":
			if slot.get_node("./Card").get_child_count() == 0:
				open_slots.append(slot)
	return open_slots
