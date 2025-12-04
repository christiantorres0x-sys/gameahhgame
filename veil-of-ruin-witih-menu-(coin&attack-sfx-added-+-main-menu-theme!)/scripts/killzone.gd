extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	# Check if the body that entered is in the "player" group.
	# IMPORTANT: Ensure your Player node is added to the "player" group 
	# in the Godot Editor (Node tab > Groups).
	if body.is_in_group("player"):
		timer.start()


func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
