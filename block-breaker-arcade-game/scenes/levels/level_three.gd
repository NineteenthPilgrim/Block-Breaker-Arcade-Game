extends Node2D

@onready var brick_one = preload("res://scenes/bricks/brick.tscn")
@onready var brick_two = preload("res://scenes/bricks/brick_two.tscn")

var columns = 8
var rows = 1
var margin = 64
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level()


func level():
	rows = 12
	for i in rows:
		for j in columns:
			var random_bricks = randi_range(0,3)
			if random_bricks >= 0:
				if (i in [2,3] and j in [3,4]) or (i in [8,9] and j in [3,4]):
					continue
				if (i <= 0 or j <=0) or i == rows - 1 or j == columns - 1:
					var new_brick = brick_one.instantiate()
					add_child(new_brick)
					new_brick.position = Vector2(margin + (16 * j),  margin - 16 + (8 * i))
				else:
					var new_bricks = brick_two.instantiate()
					add_child(new_bricks)
					new_bricks.position = Vector2(margin + (16 * j), margin - 16 + (8 * i))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
