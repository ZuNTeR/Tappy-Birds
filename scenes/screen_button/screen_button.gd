extends TouchScreenButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	SignalsManager.on_plane_switch_pickup.connect(_on_plane_switch_pickup)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameManager.MODO_VOO == 0 or GameManager.MODO_VOO == 1:
		hide()

func _on_plane_switch_pickup() -> void:
	show()
	var plane_switch_pickup = get_tree().create_timer(10.0)
	await plane_switch_pickup.timeout
	hide()
