extends AudioStreamPlayer

@export var start_time: float = 3.0  # Start song 3 seconds in
@export var fade_duration: float = 1  # Fade-in duration (in seconds)
@export var loop_length: float = 65  # Total length of the looping section

func _ready():
	volume_db = -80  # Start silent
	play()
	seek(start_time)  # Start at 3 seconds in
	fade_in()  # Fade in at the start
	start_loop_timer()  # Start handling manual looping

func start_loop_timer():
	var timer = get_tree().create_timer(loop_length - start_time, false)  # Wait until the song should loop
	timer.timeout.connect(_on_loop)

func _on_loop():
	volume_db = -80  # Start silent
	play()  # Restart song
	seek(start_time)  # Start from 3 seconds in
	fade_in()  # Fade in again
	start_loop_timer()  # Restart the loop timer

func fade_in():
	var tween = create_tween()
	tween.tween_property(self, "volume_db", 19, fade_duration).set_trans(Tween.TRANS_SINE)
