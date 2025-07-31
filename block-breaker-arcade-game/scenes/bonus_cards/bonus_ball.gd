extends Area2D

@export var ball_scene: PackedScene


func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	var timer = get_tree().create_timer(10)
	await timer.timeout
	queue_free()  


func _process(delta):
	position.y += 40 * delta  


func _on_body_entered(body):
	if body.name == "Platform" or body.name == "BonusPlatform":
		if not ball_scene:
			return
		var ball = ball_scene.instantiate()
		get_tree().current_scene.add_child(ball)
		ball.global_position = body.global_position + Vector2(0, -8)
		ball.is_active = true
		queue_free()
