extends Node

var actor = null

func ready(_actor):
	pass
	
func enter(_actor):
	actor = _actor
	print(actor.name, " entering state init")

func update(_actor):
	return
	
func exit():
	return
