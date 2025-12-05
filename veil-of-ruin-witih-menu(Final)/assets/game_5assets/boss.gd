extends CharacterBody2D

@export var speed: float = 100.0
@export var attack_range: float = 50.0
@export var gravity: float = 1000.0
@export var animation_node_path: NodePath = "AnimatedSprite2D"

var player: CharacterBody2D
var animated_sprite: AnimatedSprite2D

func _ready():
	# Find player in group
	player = get_tree().get_first_node_in_group("player")
	if not player:
		push_error("Player not found in group 'player'")
		return

	animated_sprite = get_node(animation_node_path)

	# Boss damage detection: listen for body_entered on our collision
	$CollisionShape2D.connect("input_event", Callable(self, "_on_boss_collision_event"))

	# If you prefer automatic detection without clicking:
	connect("body_entered", Callable(self, "_on_boss_body_entered"))

func _physics_process(delta):
	if not player:
		return

	velocity.y += gravity * delta

	var distance = global_position.distance_to(player.global_position)

	if distance > attack_range:
		_follow_player()
	else:
		_attack_player()

	_face_player()
	move_and_slide()

# ------------------------------
#  FOLLOW
# ------------------------------
func _follow_player():
	var dir = (player.global_position - global_position).normalized()
	velocity.x = dir.x * speed
	animated_sprite.play("follow")

# ------------------------------
#  ATTACK
# ------------------------------
func _attack_player():
	velocity.x = 0
	animated_sprite.play("attack")

# ------------------------------
#  FLIP SPRITE
# ------------------------------
func _face_player():
	if player.global_position.x < global_position.x:
		animated_sprite.flip_h = false  # face left
	else:
		animated_sprite.flip_h = true   # face right

# ------------------------------------
#  PLAYER TOUCHES BOSS → RESET LEVEL
# ------------------------------------
func _on_boss_body_entered(body):
	if body.is_in_group("player"):
		$Timer.start()

func _on_Timer_timeout():
	get_tree().reload_current_scene()
