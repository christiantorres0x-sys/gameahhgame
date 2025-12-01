extends Node2D

func _on_body_entered(body):
	if body.name == "player":
		body.apply_jump_boost()
		queue_free() # remove the coin after pickup
