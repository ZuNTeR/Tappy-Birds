extends CharacterBody2D
class_name Tappy
@onready var sound: AudioStreamPlayer2D = $Sound
const GRAVITY: float = 1000.0
const POWER: float = -250.0
@onready var anim_sprite: AnimatedSprite2D = $AnimSprite
@onready var anim_player: AnimationPlayer = $AnimationPlayer

func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	fly()
	move_and_slide()
	if is_on_floor() == true:
		die()

func fly() -> void:
	if Input.is_action_just_pressed("espace") == true:
		velocity.y = POWER
		anim_player.play("power")

func die() -> void:
	set_physics_process(false)
	anim_sprite.stop()
	SignalsManager.on_plane_died.emit()
	sound.stop()
