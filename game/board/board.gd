extends Node

onready var player = get_node("../Player")
onready var opponent = get_node("../Opponent")

onready var slots = [$Lanes/Lane1/Slots/Slot1,
					$Lanes/Lane1/Slots/Slot2,
					$Lanes/Lane1/Slots/Slot3,
					$Lanes/Lane1/Slots/Slot4,

					$Lanes/Lane2/Slots/Slot1,
					$Lanes/Lane2/Slots/Slot2,
					$Lanes/Lane2/Slots/Slot3,
					$Lanes/Lane2/Slots/Slot4,

					$Lanes/Lane3/Slots/Slot1,
					$Lanes/Lane3/Slots/Slot2,
					$Lanes/Lane3/Slots/Slot3,
					$Lanes/Lane3/Slots/Slot4,

					$Lanes/Lane4/Slots/Slot1,
					$Lanes/Lane4/Slots/Slot2,
					$Lanes/Lane4/Slots/Slot3,
					$Lanes/Lane4/Slots/Slot4,
					
					$Lanes/Lane5/Slots/Slot1,
					$Lanes/Lane5/Slots/Slot2,
					$Lanes/Lane5/Slots/Slot3,
					$Lanes/Lane5/Slots/Slot4,
					]
					
signal lane_lost
signal board_loaded
signal full_board

func _ready():
	for lane in $Lanes.get_children():
		for slot in lane.get_node("Slots").get_children():
			slot.player = player
	
	emit_signal("board_loaded")
	
