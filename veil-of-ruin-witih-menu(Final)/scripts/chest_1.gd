extends Area2D

@onready var animated_sprite = $AnimatedSprite2D
var is_open = false

func _ready():
	# Make sure this node detects mouse clicks
	input_pickable = true

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT and not is_open:
			open_chest()

func open_chest():
	is_open = true
	animated_sprite.play("open")  # make sure you have an "open" animation
	print("Chest opened!")
