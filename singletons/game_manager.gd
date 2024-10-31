extends Node
const GAME: PackedScene = preload("res://scenes/game/game.tscn")
const MAIN: PackedScene = preload("res://scenes/main/main.tscn")
const SIMPLE_TRANSITION: PackedScene = preload("res://scenes/simple_transition/simple_transition.tscn")
const COMPLEX_TRANSITION = preload("res://scenes/complex_transition/complex_transition.tscn")
var SCROLL_SPEED: float = 100.0
const GROUP_PLANE: String = "Plane"
var VELOCIDADE: int = 0
var next_scene: PackedScene


func _ready():
	SignalsManager.on_timer_velocity_timeout.connect(_on_timer_velocity_timeout)
	

func load_next_scene(ns: PackedScene) -> void:
	next_scene = ns
	#get_tree().change_scene_to_packed(SIMPLE_TRANSITION)
	var cxt = COMPLEX_TRANSITION.instantiate()
	add_child(cxt)

func load_game_scene() -> void:
	load_next_scene(GAME)
	#get_tree().change_scene_to_packed(GAME)

func load_main_scene() -> void:
	load_next_scene(MAIN)
	SCROLL_SPEED = 100.0
	VELOCIDADE = 0
	#get_tree().change_scene_to_packed(MAIN)

func _on_timer_velocity_timeout() -> void:
	VELOCIDADE += 2
	SCROLL_SPEED = 100.0 + (VELOCIDADE * 2.0)
