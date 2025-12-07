extends Area2D

# EXISTING: Path to next level
@export var target_scene_path = "res://scenes/game_2.tscn"

# NEW: Checkbox to make this an "Entry" door
@export var is_entry_door = false 

@onready var animated_sprite = $AnimatedSprite2D

var player_in_range = false

func _ready():
	if is_entry_door:
		# --- ENTRY MODE ---
		# 1. Start with door open
		animated_sprite.play("open")
		
		# 2. Wait 1 second, then close the door behind the player
		await get_tree().create_timer(1.0).timeout
		animated_sprite.play("idle")
		
		# 3. Turn off entry mode so it acts like a normal door afterwards
		is_entry_door = false 
		
	else:
		# --- EXIT MODE (Standard) ---
		# Start closed
		animated_sprite.play("idle")

func _process(delta):
	# Only allow entering if it's NOT currently acting as an entry door
	if not is_entry_door and player_in_range and Input.is_action_just_pressed("interact"):
		enter_door()

func enter_door():
	print("Opening Door...")
	animated_sprite.play("open")
	await animated_sprite.animation_finished
	print("Changing scene...")
	get_tree().change_scene_to_file(target_scene_path)

func _on_body_entered(body):
	if body.name == "player" or body is CharacterBody2D:
		player_in_range = true

func _on_body_exited(body):
	if body.name == "player" or body is CharacterBody2D:
		player_in_range = false


func _on_attack_area_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
