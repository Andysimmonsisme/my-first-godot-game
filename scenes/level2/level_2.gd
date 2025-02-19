extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Win Platform").level_won.connect(level_won_func)
	
func level_won_func():
	get_tree().change_scene_to_file("res://scenes/level3/level3.tscn")
