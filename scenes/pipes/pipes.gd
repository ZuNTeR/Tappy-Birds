extends Node2D
class_name Pipes
const OFF_SCREEN: float = -500.0
@onready var score_sound: AudioStreamPlayer2D = $ScoreSound
@onready var von: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var laser: Area2D = $Laser


func _ready() -> void:
	SignalsManager.on_plane_died.connect(_on_plane_died)

func _process(delta: float) -> void:
	position.x -= delta * GameManager.SCROLL_SPEED
	check_off_screen()

func check_off_screen() -> void:
	if von.global_position.x < get_viewport_rect().position.x:
		queue_free()

func on_screen_exited() -> void:
	#queue_free()
	pass

func _on_plane_died() -> void:
	set_process(false)
	

func _on_pipe_body_entered(body: Node2D) -> void:
	if body is Tappy:
		if GameManager.avanco_end == 0 and GameManager.MODO_VOO == 0 or GameManager.MODO_VOO == 2:
			body.die()
	else:
		pass
	#if body.is_in_group(GameManager.GROUP_PLANE) == true:
		#if body.has_method("die") == true:
			#body.die()

func _on_laser_body_entered(body: Node2D) -> void:
	score_sound.play()
	#if body is Tappy:
		#score_sound.play()
	ScoreManager.increment_score()


	
	
