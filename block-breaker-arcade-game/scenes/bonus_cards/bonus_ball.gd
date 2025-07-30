extends Area2D

@export var ball_scene: PackedScene


func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	var timer = get_tree().create_timer(10)
	await timer.timeout
	queue_free()  


func _process(delta):
	position.y += 50 * delta  


func _on_body_entered(body):
	if body.name == "Platform":
		spawn_extra_ball()
		queue_free()


func spawn_extra_ball():
	if not ball_scene:
		return
	var ball = ball_scene.instantiate()
	get_tree().current_scene.add_child(ball)
	ball.global_position = global_position 
	ball.is_active = true
