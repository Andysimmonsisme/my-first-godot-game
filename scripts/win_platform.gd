extends AnimatableBody2D

signal level_won
@onready var player = get_node("../Player")
@onready var timer = $Timer
@onready var youWinLabel = get_node("../You Win Label")

func _on_area_2d_body_entered(body):
	if self.visible:
		youWinLabel.visible = true
		player.set_physics_process(false) # stop movement
		timer.start()

func _on_timer_timeout():
	youWinLabel.visible = false
	level_won.emit()
