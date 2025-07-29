extends Node2D

@onready var brick_one = preload("res://scenes/bricks/brick.tscn")
@onready var brick_two = preload("res://scenes/bricks/brick_two.tscn")

var columns = 9
var rows = 1
var margin = 24
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level()


func level():
	rows = 4 + GameManager.level
	if rows > 9:
		rows = 9
	for i in rows:
		for j in columns:
			var random_level = randi_range(0,3)
			if random_level >= 0:
				if i <= 2:
					var new_brick = brick_one.instantiate()
					add_child(new_brick)
					new_brick.position = Vector2(margin + (24 * j), margin + (16 * i))
				else:
					var new_bricks = brick_two.instantiate()
					add_child(new_bricks)
					new_bricks.position = Vector2(margin + (24 * j), margin + (16 * i))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
