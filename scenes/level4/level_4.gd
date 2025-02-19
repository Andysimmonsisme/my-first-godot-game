extends Node2D

@onready var killzone = get_node("Killzone")

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Win Platform").level_won.connect(level_won_func)
	killzone.player_died.connect(player_died_func)
	killzone.player_resurrected.connect(player_resurrected_func)
	
func level_won_func():
	get_tree().change_scene_to_file("res://scenes/level5/level5.tscn")

func player_died_func():
	get_node("Leap of Faith Left").visible = false
	get_node("Leap of Faith Right").visible = false
	get_node("Not Like the Other Left").visible = false
	get_node("Not Like the Other Right").visible = false

func player_resurrected_func():
	get_node("Leap of Faith Left").visible = true
	get_node("Leap of Faith Right").visible = true
	get_node("Not Like the Other Left").visible = true
	get_node("Not Like the Other Right").visible = true
