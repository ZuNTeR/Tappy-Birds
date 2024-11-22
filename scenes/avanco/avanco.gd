extends Area2D
class_name Avanco
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

func _ready() -> void:
	SignalsManager.on_plane_died.connect(_on_plane_died)

func _process(delta: float) -> void:
	position.x -= delta * GameManager.SCROLL_SPEED
	check_off_screen()

func _on_body_entered(body: Node2D) -> void:
	SignalsManager.on_avanco_pickup.emit()
	hide()
	set_process(false)
	queue_free()

func check_off_screen() -> void:
	if visible_on_screen_notifier_2d.global_position.x < get_viewport_rect().position.x:
		queue_free()
		GameManager.power_up_failed = true

func _on_plane_died() -> void:
	set_process(false)
