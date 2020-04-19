extends ColorRect

onready var slots = $Slots

func _physics_process(_delta):
	var status_good = false
	for slot in slots.get_children():
		if slot.status_good == true:
			status_good = true
	if !status_good:
		queue_free()
		
