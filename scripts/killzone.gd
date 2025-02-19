extends Area2D

signal player_died
signal player_resurrected
@onready var player = get_node("../Player")
@onready var timer = $Timer
@onready var youDiedLabel = get_node("../You Died Label")

func _on_body_entered(body):
	youDiedLabel.visible = true
	await get_tree().create_timer(.01).timeout
	player_died.emit()
	timer.start()

func _on_timer_timeout():
	youDiedLabel.visible = false
	player_resurrected.emit()
	player.global_position.x = 7
	player.global_position.y = -1 
	#get_tree().reload_current_scene()
