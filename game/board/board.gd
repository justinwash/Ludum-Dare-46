extends Node

onready var player = get_node("../Player")

func _ready():
	for lane in $Lanes.get_children():
		for slot in lane.get_node("Slots").get_children():
			slot.player = player
