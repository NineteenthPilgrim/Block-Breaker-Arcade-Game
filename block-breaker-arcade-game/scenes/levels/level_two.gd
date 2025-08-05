extends Node2D

@onready var brick_one = preload("res://scenes/bricks/brick.tscn")
@onready var brick_two = preload("res://scenes/bricks/brick_two.tscn")

@export var bonus_ball: PackedScene
@export var spawn_positions := [Vector2(56, 182), Vector2(200, 182)]

var pause_menu_scene = preload("res://scenes/ui/pause_menu.tscn")

var columns = 10
var rows = 1
var margin = 48


func _ready() -> void:
	level()
	start_bonus_ball_timer()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		add_child(pause_menu_scene.instantiate())


func start_bonus_ball_timer():
	var timer = get_tree().create_timer(30.0)
	await timer.timeout
	spawn_card()
	start_bonus_ball_timer() 


func spawn_card():
	var bonus_ball_card = bonus_ball.instantiate()
	var index = randi() % spawn_positions.size()
	bonus_ball_card.position = spawn_positions[index]
	add_child(bonus_ball_card)


func level():
	#algorithm for generating brick layout for the level
	rows = 6
	for i in rows:
		for j in columns:
			var random_bricks = randi_range(0,3)
			if random_bricks >= 1:
				if i <= 2:
					var new_brick = brick_one.instantiate()
					add_child(new_brick)
					new_brick.position = Vector2(margin + (16 * j),\
					margin / 2 + (16 * i))
				else:
					var new_bricks = brick_two.instantiate()
					add_child(new_bricks)
					new_bricks.position = Vector2(margin + (16 * j),\
					margin  / 2  + (16 * i))
