extends Node2D

@onready var brick_one = preload("res://scenes/bricks/brick.tscn")
@onready var brick_two = preload("res://scenes/bricks/brick_two.tscn")

@export var end_screen: PackedScene

var pause_menu_scene = preload("res://scenes/ui/pause_menu.tscn")

var columns = 9
var rows = 5
var margin = 24


func _ready() -> void:
	level()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		add_child(pause_menu_scene.instantiate())


func level():
	#algorithm for generating brick layout for the level
	for i in rows:
		for j in columns:
			if i <= 2:
				var new_brick = brick_one.instantiate()
				add_child(new_brick)
				new_brick.position = Vector2(margin + (24 * j), margin + (16 * i))
			else:
				var new_bricks = brick_two.instantiate()
				add_child(new_bricks)
				new_bricks.position = Vector2(margin + (24 * j), margin + (16 * i))
