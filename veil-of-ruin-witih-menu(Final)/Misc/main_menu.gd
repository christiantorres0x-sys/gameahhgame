extends Node2D

func _on_button_1_pressed() -> void:
	if not is_inside_tree(): return
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_button_2_pressed() -> void:
	if not is_inside_tree(): return
	get_tree().quit()

func _on_button_3_pressed() -> void:
	if not is_inside_tree(): return
	get_tree().change_scene_to_file("res://scenes/controlspanel.tscn")
