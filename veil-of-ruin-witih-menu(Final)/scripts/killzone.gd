extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	# Only affect the player
	if body.is_in_group("player"):
		# Check if the player is attacking
		if body.has_method("is_attacking_state") and body.is_attacking_state():
			# Player is attacking -> immune, do nothing
			return
		# Otherwise, trigger kill
		timer.start()

func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
