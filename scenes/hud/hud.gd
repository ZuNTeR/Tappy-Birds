extends Control
@onready var score_label: Label = $MarginContainer/ScoreLabel

func _ready() -> void:
	SignalsManager.on_score_updated.connect(on_score_updated)

func on_score_updated(score: int) -> void:
	score_label.text =  str(score)
