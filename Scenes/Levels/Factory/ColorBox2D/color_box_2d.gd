extends Node2D


@export var background_color : Color = Color.BLUE

func _ready() -> void:
	update()

func _process(_x) -> void:
	update()

func _draw():
	draw_rect(Rect2(Vector2(0, 0), Vector2(250, 250)), background_color)

func update():
	queue_redraw()
	