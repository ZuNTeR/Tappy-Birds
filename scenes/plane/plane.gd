extends CharacterBody2D
class_name Tappy
@onready var sound: AudioStreamPlayer2D = $Sound
const GRAVITY: float = 1000.0
const POWER: float = -250.0
@onready var anim_sprite: AnimatedSprite2D = $AnimSprite
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var velocity_timer: Timer = $VelocityTimer
var SPEED: int = 500
@onready var animation_player_invencible: AnimationPlayer = $AnimationPlayerInvencible


#func _ready() -> void:
	#if GameManager.MODO_VOO == 2:
		#velocity.y = 0

func _physics_process(delta: float) -> void:
	if GameManager.MODO_VOO == 0:
		fly(delta)
	elif GameManager.MODO_VOO == 1:
		avanco()
	elif GameManager.MODO_VOO == 2:
		switch()
		handle_animation("up", "up")
		handle_animation("down", "down_animation")
	
	power_up_call()
	move_and_slide()
	if is_on_floor() == true:
		die()
	
	
	#if ScoreManager.get_score() == GameManager.score_atual and GameManager.MODO_VOO == 1:
		#animation_player_invencible.play("invencible")
		#var timer_invencible = get_tree().create_timer(3.0)
		#await timer_invencible.timeout
		#animation_player_invencible.stop()
		#GameManager.avanco_end = 0

func power_up_call() -> void:
	if Input.is_action_just_pressed("p") == true:
		SignalsManager.on_plane_switch_pickup.emit()
	if Input.is_action_just_pressed("avanco") == true:
		print("avanco")
		SignalsManager.on_avanco_pickup.emit()

func fly(delta) -> void:
	velocity.y += GRAVITY * delta
	if Input.is_action_just_pressed("espace") == true or Input.is_action_just_pressed("touch") == true:
		velocity.y = POWER
		anim_player.stop()
		anim_player.play("power")
		
func avanco() -> void:
	velocity.y = 0
	await SignalsManager.on_score_atual_plus
	animation_player_invencible.play("invencible")
	var timer_invencible = get_tree().create_timer(3.0)
	await timer_invencible.timeout
	animation_player_invencible.stop()

func switch() -> void:
	velocity.y = SPEED * Input.get_axis("up", "down")

func handle_animation(action: String, animation: String) -> void:
	if Input.is_action_just_pressed(action):
		anim_player.play(animation)
	elif Input.is_action_just_released(action):
		anim_player.play_backwards(animation)


func die() -> void:
	set_physics_process(false)
	anim_sprite.stop()
	SignalsManager.on_plane_died.emit()
	sound.stop()
	velocity_timer.stop()


func _on_velocity_timer_timeout() -> void:
	SignalsManager.on_timer_velocity_timeout.emit()
	
