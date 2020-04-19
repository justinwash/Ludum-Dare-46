extends ColorRect

onready var slots = $Slots
onready var board = get_node('../../')

func _physics_process(_delta):
	var status_good = false
	for slot in slots.get_children():
		if slot.status_good == true:
			status_good = true
	if !status_good:
		board.emit_signal("lane_lost")
		queue_free()
		
