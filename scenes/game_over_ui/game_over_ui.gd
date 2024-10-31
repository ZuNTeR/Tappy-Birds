extends Control
@onready var sound: AudioStreamPlayer = $Sound
@onready var game_over_label: Label = $GameOverLabel
@onready var space_label: Label = $SpaceLabel
@onready var timer: Timer = $Timer

func _ready() -> void:
	hide()
	SignalsManager.on_plane_died.connect(_on_plane_died)

func _process(delta: float) -> void:
	if space_label.visible == true:
		if Input.is_action_just_pressed("espace") or Input.is_action_just_pressed("touch"):
			GameManager.load_main_scene()

func _on_plane_died() -> void:
	sound.play()
	show()
	timer.start()
	ScoreManager.save_high_score_to_file()
	
func _on_timer_timeout() -> void:
	game_over_label.hide()
	space_label.show()
