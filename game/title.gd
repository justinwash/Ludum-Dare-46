extends Node2D

func _on_Button_button_up():
	get_tree().change_scene("res://game.tscn")
	
func _ready():
	$Music.play()
