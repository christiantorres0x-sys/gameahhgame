extends Area2D

@export var bridge_node_path: NodePath   # drag Bridge node or its path here

var player_near: bool = false
@onready var bridge: Node = null

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))
	if bridge_node_path != null:
		bridge = get_node(bridge_node_path)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player_near = true
		_show_prompt(true)

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_near = false
		_show_prompt(false)

func _input(event):
	if player_near and event.is_action_pressed("interact"):
		_try_build()

func _try_build() -> void:
	var collected = Gamestate.collected_planks.size()
	if collected >= Gamestate.total_planks:
		if bridge:
			# call Bridge.build_from_array(GameState.collected_planks)
			bridge.call("build_from_array", Gamestate.collected_planks)
			# optional: clear collected list or mark as used
			# GameState.reset()
			print("Bridge built")
		else:
			push_error("Sign: Bridge node not set.")
	else:
		var missing = Gamestate.total_planks - collected
		print("You still need %d plank(s)." % missing)

func _show_prompt(visible: bool) -> void:
	# implement UI prompt enabling/disabling if you have one; placeholder:
	pass
