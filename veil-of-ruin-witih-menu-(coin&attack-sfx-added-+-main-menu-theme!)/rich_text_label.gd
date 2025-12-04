# Animated dungeon-style title "Veil of Ruin"

extends Node2D

@export var font_size := 64  # Big font size for title
@export var font_path := "res://fonts/MorkDungeon.ttf"  # Replace with your dungeon font

func _ready():
	var rich = $RichTextLabel
	rich.bbcode_enabled = true
	rich.percent_visible = 0
	# Set custom dungeon font
	var dfont = DynamicFont.new()
	dfont.font_data = load(font_path)
	dfont.size = font_size
	rich.add_theme_font_override("font", dfont)
	
	# Set dungeon-style colored text with BBCode
	rich.bbcode_text = "[center]" +
		"[color=#FFAA33][b]Veil[/b][/color] " +
		"[color=#FF5555][i]of[/i][/color] " +
		"[color=#AA33FF][u]Ruin[/u][/color]" +
        "[/center]"
	
	# Animate letters appearing
	animate_letters(rich, 0)

func animate_letters(rich: RichTextLabel, index: int) -> void:
	if index > rich.bbcode_text.length():
		return
	rich.percent_visible = int(index * 100 / rich.bbcode_text.length())
	yield(get_tree().create_timer(0.05), "timeout")
	animate_letters(rich, index + 1)
