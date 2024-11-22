extends Node2D
@onready var spawn_u: Marker2D = $SpawnU
@onready var spawn_l: Marker2D = $SpawnL
@onready var spawn_timer: Timer = $SpawnTimer
@onready var pipes_holder: Node = $PipesHolder
const PIPES: PackedScene = preload("res://scenes/pipes/pipes.tscn")
const AVANCO: PackedScene = preload("res://scenes/avanco/avanco.tscn")
const SWITCH: PackedScene = preload("res://scenes/plane_switch/plane_switch.tscn")
const BASE_SPAWN_WAIT_TIME: float = 3.5
@onready var plane: Tappy = $Plane

#var chance: int = 1
var pipe_call: String = "a"
var chance: int = randi_range(0, 1)

func _ready() -> void:
	#SignalsManager.on_timer_velocity_timeout.connect(_on_timer_velocity_timeout)
	ScoreManager.set_score(0)
	#SignalsManager.on_plane_died.connect(_on_plane_died)
	SignalsManager.on_avanco_pickup.connect(_on_avanco_pickup)
	SignalsManager.on_plane_switch_pickup.connect(_on_plane_switch_pickup)
	spawn_pipes()

func  _process(delta: float) -> void:
	for new_pipes in get_tree().get_nodes_in_group("Pipes_Laser"):
		var pipe_call_new: String = str (new_pipes)
		if abs(new_pipes.global_position.x - 140) < 5 and pipe_call != pipe_call_new:
			pipe_call = str (new_pipes)
			spawn_pipes()
			spawn_power_up()
	
	
	#if _on_button_cima_pressed() == false or _on_button_baixo_pressed() == false:
		#plane.velocity.y = 0

func spawn_pipes() -> void:
	var new_pipes: Pipes = PIPES.instantiate()
	var yp: float = randf_range(spawn_u.position.y, spawn_l.position.y)
	new_pipes.position = Vector2(spawn_l.position.x, yp)
	new_pipes.add_to_group("Pipes_Laser")
	pipes_holder.add_child(new_pipes)
	
	
func spawn_power_up() -> void:
	var chance_spawn: int = randi_range(0, 20)
	if GameManager.power_up_pickup <= 1:
		if chance == 0:
			print("avanco")
			if chance_spawn == 10 and GameManager.power_up_failed == true:
				var new_avanco: Avanco = AVANCO.instantiate()
				var yp: float = randf_range(spawn_u.position.y + 50, spawn_l.position.y - 50)
				new_avanco.position = Vector2(spawn_l.position.x + 100, yp)
				pipes_holder.add_child(new_avanco)
				GameManager.power_up_failed = false
	
		if chance == 1:
			print("switch")
			if chance_spawn == 15 and GameManager.power_up_failed == true:
				var new_switch: Switch = SWITCH.instantiate()
				var yp: float = randf_range(spawn_u.position.y + 50, spawn_l.position.y - 50)
				new_switch.position = Vector2(spawn_l.position.x + 100, yp)
				pipes_holder.add_child(new_switch)
				GameManager.power_up_failed = false
	
	
	#call_deferred("_disable_area", new_pipes)
	#new_pipes.add_to_group("Pipes_Laser")
	
#func stop_pipes() -> void:
	#for pipe in pipes_holder.get_children():
		#pipe.set_process(false)

#func _on_spawn_timer_timeout() -> void:
	#spawn_pipes()
	
#func _disable_area(pipes: Node):
	#var area = pipes.get_node("PipesHolder/Pipes/Pipe/CollisionPolygon2D")
	#area.get_collision_shape().disabled = true

#func _on_plane_died() -> void:
	#spawn_timer.stop()

#func _on_timer_velocity_timeout() -> void:
	#spawn_timer.wait_time = clamp(BASE_SPAWN_WAIT_TIME - (GameManager.VELOCIDADE * 0.035), 0.5, BASE_SPAWN_WAIT_TIME)


#func _on_spawn_location_area_entered(area: Area2D) -> void:
	#spawn_pipes()
	#spawn_power_up()

func _on_plane_switch_pickup() -> void:
	chance = 0
	GameManager.power_up_pickup += 1
	var espera = get_tree().create_timer(10.0)
	await espera.timeout
	GameManager.power_up_failed = true

func _on_avanco_pickup() -> void:
	chance = 1
	GameManager.power_up_pickup += 1
	var espera = get_tree().create_timer(5.0)
	await espera.timeout
	GameManager.power_up_failed = true
