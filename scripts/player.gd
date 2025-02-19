extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var jump_velocity = -300 
@onready var killzone = get_node("../Killzone")
@onready var player = get_node("../Player")
@onready var youDiedLabel = get_node("../You Died Label")
const SPEED = 130.0
var can_move = true

func _ready():
	killzone.player_died.connect(player_died_func)
	killzone.player_resurrected.connect(player_resurrected_func)
	match get_parent().name:
		"Level3":
			jump_velocity = -400
		"Level4":
			jump_velocity = -200

func _physics_process(delta):
	if can_move:
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = jump_velocity

		# Get the input direction -1 is left 1 is right
		var direction = Input.get_axis("move_left", "move_right")
		
		# Flip the sprite
		if direction > 0:
			animated_sprite.flip_h = false
		elif direction < 0:
			animated_sprite.flip_h = true
			
		# Play animation
		if is_on_floor():
			if direction == 0:
				animated_sprite.play("idle")
			else: 
				animated_sprite.play("run")
		else:
			animated_sprite.play("jump")
		
		if direction:
			velocity.x = direction * SPEED
			if(youDiedLabel):
				youDiedLabel.global_position.x = player.global_position.x - 40
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		move_and_slide()
	get_jump_velocity()
	
func get_jump_velocity():
	if get_parent().name == "Level4":
		if self.global_position.x > 438:
			jump_velocity = -300
		elif self.global_position.x < -424:
			jump_velocity = -300
		elif self.global_position.y < -111:
			jump_velocity = -300
		else:
			jump_velocity = -200
	elif get_parent().name == "Level5":
		var x = self.global_position.x
		
		jump_velocity = -300
		if x > 90 and x < 270:
			jump_velocity = -600
		elif x > 270 and x < 320:
			jump_velocity = -300
		elif x > 320 and x < 400:
			jump_velocity = -700
		elif x > 400:
			jump_velocity = -1200
	
func player_died_func():
	can_move = false
	
func player_resurrected_func(): 
	can_move = true
