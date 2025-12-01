extends CharacterBody2D

@export var speed: float = 100.0
@export var move_distance: float = 50.0 # how far to move before turning back

var start_position: Vector2
var direction: int = 1  # 1 = right, -1 = left

func _ready():
	start_position = position

func _physics_process(delta):
	# Move enemy horizontally
	velocity.x = direction * speed
	move_and_slide()

	# Flip sprite depending on direction
	if $AnimatedSprite2D:
		$AnimatedSprite2D.flip_h = direction < 0

	# Reverse direction after reaching distance limit
	if abs(position.x - start_position.x) >= move_distance:
		direction *= -1
