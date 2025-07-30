extends Node2D

@onready var brick_one = preload("res://scenes/bricks/brick.tscn")
@onready var brick_two = preload("res://scenes/bricks/brick_two.tscn")

@export var bonus_ball: PackedScene
@export var spawn_positions := [Vector2(56, 182), Vector2(200, 182)]

var columns = 10
var rows = 1
var margin = 48


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level()
	start_bonus_ball_timer()


func start_bonus_ball_timer():
	var timer = get_tree().create_timer(30.0)
	await timer.timeout
	spawn_card()
	start_bonus_ball_timer()  # Рекурсивно перезапускаем


func spawn_card():
	var bonus_ball_card = bonus_ball.instantiate()
	var index = randi() % spawn_positions.size()
	bonus_ball_card.position = spawn_positions[index]
	add_child(bonus_ball_card)


func level():
	rows = 6
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
