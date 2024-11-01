extends Node2D
@onready var spawn_u: Marker2D = $SpawnU
@onready var spawn_l: Marker2D = $SpawnL
@onready var spawn_timer: Timer = $SpawnTimer
@onready var pipes_holder: Node = $PipesHolder
const PIPES: PackedScene = preload("res://scenes/pipes/pipes.tscn")
const BASE_SPAWN_WAIT_TIME: float = 3.5

func _ready() -> void:
	SignalsManager.on_timer_velocity_timeout.connect(_on_timer_velocity_timeout)
	ScoreManager.set_score(0)
	SignalsManager.on_plane_died.connect(_on_plane_died)
	spawn_pipes()

func _process(delta: float) -> void:
	pass

func spawn_pipes() -> void:
	var new_pipes: Pipes = PIPES.instantiate()
	var yp: float = randf_range(spawn_u.position.y, spawn_l.position.y)
	new_pipes.position = Vector2(spawn_l.position.x, yp)
	pipes_holder.add_child(new_pipes)
	
#func stop_pipes() -> void:
	#for pipe in pipes_holder.get_children():
		#pipe.set_process(false)

#func _on_spawn_timer_timeout() -> void:
	#spawn_pipes()

func _on_plane_died() -> void:
	spawn_timer.stop()

func _on_timer_velocity_timeout() -> void:
	spawn_timer.wait_time = clamp(BASE_SPAWN_WAIT_TIME - (GameManager.VELOCIDADE * 0.035), 0.5, BASE_SPAWN_WAIT_TIME)


func _on_spawn_location_area_entered(area: Area2D) -> void:
	spawn_pipes()
