extends Node2D

@onready var sound = $AudioStreamPlayer2D

func _on_body_entered(body):
	if body.name == "player":
		sound.play()
		body.apply_jump_boost()
		await sound.finished   # <-- wait until sound is done
		queue_free()
