extends Node2D

@export var scroll_speed := 30.0   # pixels per second
@export var end_x := 276.0        # position where scrolling stops

func _process(delta):
	position.x += scroll_speed * delta

	# Stop when it reaches the end position
	if position.x >= end_x:
		scroll_speed = 0
