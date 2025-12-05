extends Node2D

@export var bridge_piece_scene: PackedScene
@export var place_with_animation: bool = true
@export var animation_time: float = 0.25

@onready var slots = $Slots.get_children()
@onready var built_parent: Node2D = $BuiltPieces

func build_from_array(arr: Array) -> void:
	visible = true
	built_parent.visible = true

	var count = min(arr.size(), slots.size())
	for i in range(count):
		_place_piece_at_index(i)

func _place_piece_at_index(index: int) -> void:
	var slot_node = slots[index]
	var piece = bridge_piece_scene.instantiate()
	built_parent.add_child(piece)
	piece.global_position = slot_node.global_position
	piece.visible = true
	piece.z_index = 1

	#if place_with_animation:
		#_animate_piece_entry(piece, slot_node.global_position)

func _animate_piece_entry(piece: Node, target_pos: Vector2) -> void:
	var tween = create_tween()
	piece.scale = Vector2(0.2, 0.2)
	piece.global_position = target_pos + Vector2(0, -60)
	piece.visible = true
	tween.tween_property(piece, "global_position", target_pos, animation_time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(piece, "scale", Vector2(1,1), animation_time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
