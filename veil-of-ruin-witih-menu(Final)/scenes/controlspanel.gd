extends Node2D




func _on_button_4_pressed() -> void:
	if not is_inside_tree(): return
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
