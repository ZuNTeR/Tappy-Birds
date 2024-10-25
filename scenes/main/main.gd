extends Control

@onready var score: Label = $MarginContainer/Score

func _ready() -> void:
	score.text = str (ScoreManager.get_high_score())

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("espace") == true:
		GameManager.load_game_scene()
