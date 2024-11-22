extends Node
const GAME: PackedScene = preload("res://scenes/game/game.tscn")
const MAIN: PackedScene = preload("res://scenes/main/main.tscn")
const SIMPLE_TRANSITION: PackedScene = preload("res://scenes/simple_transition/simple_transition.tscn")
const COMPLEX_TRANSITION = preload("res://scenes/complex_transition/complex_transition.tscn")
var SCROLL_SPEED: float = 100.0
const GROUP_PLANE: String = "Plane"
var VELOCIDADE: int = 0
var next_scene: PackedScene
var MODO_VOO: int = 0
var score_atual = 1000
var vel_atual = 0
var avanco_end: int = 0
var powerup_ativo: bool = false
var power_up_failed: bool = true
var power_up_pickup = 0
var plane_position: float = 0.0

func _ready():
	SignalsManager.on_timer_velocity_timeout.connect(_on_timer_velocity_timeout)
	SignalsManager.on_avanco_pickup.connect(_on_avanco_pickup)
	SignalsManager.on_plane_switch_pickup.connect(_on_plane_switch_pickup)
	SignalsManager.on_score_atual_plus.connect(_on_score_atual_plus)
	#SignalsManager.on_plane_died.connect(_on_plane_died)

func _process(_delta: float) -> void:
	pass
	#update_pipe_positions(delta, SCROLL_SPEED)
	

#func update_pipe_positions(delta: float, SCROLL_SPEED: float) -> void:
	#for new_pipes in get_tree().get_nodes_in_group("Pipes_Laser"):
		#new_pipes.position.x -= SCROLL_SPEED * delta

func load_next_scene(ns: PackedScene) -> void:
	next_scene = ns
	#get_tree().change_scene_to_packed(SIMPLE_TRANSITION)
	var cxt = COMPLEX_TRANSITION.instantiate()
	add_child(cxt)

func load_game_scene() -> void:
	load_next_scene(GAME)
	MODO_VOO = 0
	power_up_pickup = 0
	SCROLL_SPEED = 100.0
	VELOCIDADE = 0
	#get_tree().change_scene_to_packed(GAME)

func load_main_scene() -> void:
	load_next_scene(MAIN)
	#get_tree().change_scene_to_packed(MAIN)

func _on_timer_velocity_timeout() -> void:
	VELOCIDADE += 1
	SCROLL_SPEED = 100.0 + (VELOCIDADE * 2.0)

func _on_avanco_pickup() -> void:
	MODO_VOO = 1
	score_atual = ScoreManager.get_score() + 10
	vel_atual = VELOCIDADE + 3
	VELOCIDADE = 1000

func _on_plane_switch_pickup() -> void:
	MODO_VOO = 2
	if MODO_VOO == 2:
		VELOCIDADE = vel_atual
		SCROLL_SPEED = 100.0 + (VELOCIDADE * 2.0)
		var plane_switch_pickup = get_tree().create_timer(10.0)
		if MODO_VOO == 2:
			await plane_switch_pickup.timeout
			MODO_VOO = 0

func _on_score_atual_plus() -> void:
	if MODO_VOO == 1:
		VELOCIDADE = vel_atual
		SCROLL_SPEED = 100.0 + (VELOCIDADE * 2.0)
		if MODO_VOO == 1:
			MODO_VOO = 0
	
	
	
	
	
	
	
