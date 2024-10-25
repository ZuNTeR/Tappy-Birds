extends Area2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalsManager.on_plane_died.connect(_on_plane_died)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_plane_died() -> void:
	animation_player.pause()
