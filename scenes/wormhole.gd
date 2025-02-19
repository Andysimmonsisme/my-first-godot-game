extends Area2D
@onready var killzone = get_node("../Killzone")
@onready var player = get_node("../Player")
@onready var win_platform = get_node("../Win Platform")
@onready var wormhole_label = get_node("../Wormhole Label")

func _ready():
	killzone.player_died.connect(player_died_func)

func _on_body_entered(body):
	player.visible = false
	
	if body.is_in_group("player"):  # Ensure it's the player
		player.set_physics_process(false) # stop movement
		# show/enable win platform
		win_platform.visible = true
		win_platform.set_collision_layer(1)
		wormhole_label.global_position.x = player.global_position.x - 100 # center based on player position
		wormhole_label.visible = true
		await get_tree().create_timer(3).timeout
		player.set_physics_process(true)
		player.global_position = Vector2(7, -1)  # Reset position
		player.visible = true
		wormhole_label.visible = false
		
func player_died_func():
	win_platform.visible = false
	win_platform.set_collision_layer(2)
