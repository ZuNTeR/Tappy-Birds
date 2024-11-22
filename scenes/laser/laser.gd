extends Area2D
class_name Laser
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	SignalsManager.on_plane_died.connect(_on_plane_died)

func _on_plane_died() -> void:
	animation_player.pause()
