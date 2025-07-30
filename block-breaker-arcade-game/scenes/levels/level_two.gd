extends Node2D

@onready var brick_one = preload("res://scenes/bricks/brick.tscn")
@onready var brick_two = preload("res://scenes/bricks/brick_two.tscn")

var columns = 10
var rows = 1
var margin = 48
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level()


func level():
	rows = 6
	if rows > 9:
		rows = 9
	for i in rows:
		for j in columns:
			var random_bricks = randi_range(0,3)
			if random_bricks >= 1:
				if i <= 2:
					var new_brick = brick_one.instantiate()
					add_child(new_brick)
					new_brick.position = Vector2(margin + (16 * j), margin / 2 + (16 * i))
				else:
					var new_bricks = brick_two.instantiate()
					add_child(new_bricks)
					new_bricks.position = Vector2(margin + (16 * j), margin  / 2  + (16 * i))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
