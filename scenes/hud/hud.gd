extends Control
@onready var score_label: Label = $MarginContainer/ScoreLabel
@onready var timer_switch: Label = $MarginContainer/TimerSwitch
@onready var plane_switch_pickup: Timer = $plane_switch_pickup



func _ready() -> void:
	timer_switch.hide()
	SignalsManager.on_score_updated.connect(on_score_updated)
	SignalsManager.on_plane_switch_pickup.connect(_on_plane_switch_pickup)
	
func _process(delta: float) -> void:
	if GameManager.MODO_VOO == 0 or GameManager.MODO_VOO == 1:
		timer_switch.hide()
	if GameManager.MODO_VOO == 2:
		var seconds_left = int(plane_switch_pickup.time_left)
		timer_switch.text = str(seconds_left + 1)

func on_score_updated(score: int) -> void:
	score_label.text = str(score)
	
func _on_plane_switch_pickup() -> void:
	timer_switch.show()
	plane_switch_pickup.start()

func _on_plane_switch_pickup_timeout() -> void:
	timer_switch.hide()
