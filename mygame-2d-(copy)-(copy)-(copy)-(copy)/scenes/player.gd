extends CharacterBody2D

const SPEED = 200
const NORMAL_JUMP = -390.0
const BOOSTED_JUMP = -500.0

@onready var animated_sprite = $AnimatedSprite2D

var boosted = false
var is_attacking = false

func _ready():
	# FORCE disable loop for attack animation
	var frames = animated_sprite.sprite_frames
	if frames and frames.has_animation("attack"):
		frames.set_animation_loop("attack", false)

func _physics_process(delta):
	var direction = Input.get_axis("move_left", "move_right")

	# ---------------- ATTACK ----------------
	if Input.is_action_just_pressed("attack") and not is_attacking:
		start_attack()
		return

	# If attacking, freeze movement but apply gravity
	if is_attacking:
		velocity.y += 20
		move_and_slide()
		return

	# ---------------- MOVEMENT ----------------
	if direction != 0:
		velocity.x = direction * SPEED
		animated_sprite.flip_h = direction < 0
		animated_sprite.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite.play("idle")

	# ---------------- JUMP ----------------
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = BOOSTED_JUMP if boosted else NORMAL_JUMP

	# ---------------- GRAVITY ----------------
	if not is_on_floor():
		velocity.y += 20

	move_and_slide()

# ========== ATTACK ==========
func start_attack():
	is_attacking = true
	animated_sprite.play("attack")

	if not animated_sprite.is_connected("animation_finished", Callable(self, "_on_attack_finished")):
		animated_sprite.connect("animation_finished", Callable(self, "_on_attack_finished"))

func _on_attack_finished():
	if animated_sprite.animation == "attack":
		is_attacking = false
		animated_sprite.play("idle")

# ========== BOOST ==========
func apply_jump_boost():
	if boosted:
		return

	boosted = true
	await get_tree().create_timer(6).timeout
	boosted = false
