extends ColorRect

onready var slots = $Slots
onready var board = get_node('../../')
onready var timer = $Timer

var lost = false

func _physics_process(_delta):
	var status_good = false
	for slot in slots.get_children():
		if slot.status_good == true:
			status_good = true
	if !status_good and !lost:
		lost = true
		
		for slot in slots.get_children():
			slots.remove_child(slot)
			
		timer.connect("timeout", self, "_lane_lost")
		timer.set_wait_time(0.5)
		timer.start()
		
func _lane_lost():
	board.emit_signal("lane_lost")
	queue_free()
		
		
