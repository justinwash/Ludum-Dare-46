extends Node2D

var left = false
var up = false
var right = false
var down = false

export var difficulty = 5

onready var label = $Label

func _ready():
	randomize()
	left = true if int(rand_range(0,10)) > difficulty else false
	randomize()
	up = true if int(rand_range(0,10)) > difficulty else false
	randomize()
	right = true if int(rand_range(0,10)) > difficulty else false
	randomize()
	down = true if int(rand_range(0,10)) > difficulty else false
	
	label.text = ""
	
	if left:
		label.text = label.text + "< "
	if up:
		label.text = label.text + "^ "
	if right:
		label.text = label.text + "> "
	if down:
		label.text = label.text + "v "
	
	
