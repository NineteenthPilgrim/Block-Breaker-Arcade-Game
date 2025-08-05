extends Node2D

@onready var brick_one = preload("res://scenes/bricks/brick.tscn")
@onready var brick_two = preload("res://scenes/bricks/brick_two.tscn")
@onready var bonus_platfrom = preload("res://scenes/platform/bonus_platform.tscn")
@onready var platform: CharacterBody2D = %Platform

@export var bonus_ball_scene: PackedScene
@export var bonus_platform_scene: PackedScene
@export var spawn_positions := [Vector2(56, 150), Vector2(200, 150)]

var bonus_platform_instance: Node = null

var pause_menu_scene = preload("res://scenes/ui/pause_menu.tscn")

var columns = 8
var rows = 12
var margin = 64


func spawn_random_card():
	# Выбираем случайную позицию из массива
	var pos = spawn_positions[randi() % spawn_positions.size()]
	# Выбираем случайную карту
	var card_scene = bonus_ball_scene if (randi() % 2 == 0)\
	else bonus_platform_scene
	# Создаём инстанс карты
	var card_instance = card_scene.instantiate()
	add_child(card_instance)
	card_instance.global_position = pos


func swap_to_bonus_platform():
	# Спрятать обычную платформу
	platform.set_deferred("visible", false)
	#platform.visible = false
	platform.set_physics_process(false)
	platform.collision_layer &= ~(1 << 3)
	# Создать большую платформу на том же месте
	bonus_platform_instance = bonus_platfrom.instantiate()
	bonus_platform_instance.global_position = platform.global_position
	add_child(bonus_platform_instance)
	
	# Вернуть обычную через 10 секунд
	await get_tree().create_timer(10).timeout
	
	if bonus_platform_instance and bonus_platform_instance.is_inside_tree():
		bonus_platform_instance.call_deferred("queue_free")
	platform.set_deferred("visible", true)
	#platform.visible = true
	platform.set_physics_process(true)
	platform.collision_layer |= (1 << 3)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level()
	randomize()  # обязательно вызвать для рандома
	# Запустить таймер
	var timer = Timer.new()
	timer.wait_time = 30
	timer.one_shot = false
	timer.autostart = true
	add_child(timer)
	timer.connect("timeout", Callable(self, "spawn_random_card"))


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		add_child(pause_menu_scene.instantiate())


func level():
	for i in rows:
		for j in columns:
			var random_bricks = randi_range(0,3)
			if random_bricks >= 0:
				if (i in [2,3] and j in [3,4]) or (i in [8,9] and j in [3,4]):
					continue
				if (i <= 0 or j <=0) or i == rows - 1 or j == columns - 1:
					var new_brick = brick_one.instantiate()
					add_child(new_brick)
					new_brick.position = Vector2(margin + (16 * j),\
					margin - 16 + (8 * i))
				else:
					var new_bricks = brick_two.instantiate()
					add_child(new_bricks)
					new_bricks.position = Vector2(margin + (16 * j),\
					margin - 16 + (8 * i))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
