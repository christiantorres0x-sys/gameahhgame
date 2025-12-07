extends Area2D

@export var plank_id:int = -1   # set in inspector (0..3 or arbitrary)
@export var pickup_sound: AudioStream  # optional

func _on_body_entered(body: Node) -> void:
	print("works")
	if not body.is_in_group("player"):
		return
	# Prevent duplicates (in case of respawn or multiple collisions)
	if not Gamestate.collected_planks.has(plank_id):
		Gamestate.collected_planks.append(plank_id)
		if pickup_sound:
			var s = AudioStreamPlayer.new()
			add_child(s)
			s.stream = pickup_sound
			s.play()
		print_debug("Plank collected:", plank_id, " total:", Gamestate.collected_planks.size())
	queue_free()
