extends KinematicBody2D

signal holding_card
signal dropped_card

var can_grab = false
var grabbed_offset = Vector2()
var drag_origin
var pressed = false
var process_drop = true

export var side = "player"

onready var effects = $Effects
onready var player = get_node("../../../")
	
func _input_event(viewport, event, shape_idx):
	if player.is_turn:
		if event is InputEventMouseButton:
			can_grab = event.pressed
			grabbed_offset = position - get_global_mouse_position()

func _process(delta):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_grab and owner.name == "Cards":
		pressed = true
		if !drag_origin:
			drag_origin = position
		position = get_global_mouse_position() + grabbed_offset
		emit_signal("holding_card", self)
	if process_drop:
		if !Input.is_mouse_button_pressed(BUTTON_LEFT) and pressed:
			pressed = false
			emit_signal("dropped_card", self)
			if drag_origin:
				set_scale(Vector2(0.435, 0.435))
				position = drag_origin
