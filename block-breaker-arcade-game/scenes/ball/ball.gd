extends CharacterBody2D

var speed = 200
var direction = Vector2.DOWN
var is_active = true


func _ready() -> void:
	speed = speed + (10 * GameManager.level)
	velocity = Vector2(speed * -1, speed)
	

func _physics_process(delta: float) -> void:
	if is_active:
		var collision = move_and_collide(velocity * delta)
		
		if collision:
			var current_speed = velocity.length()
			velocity = velocity.bounce(collision.get_normal()).normalized() * current_speed
			var len = velocity.length()
			
			if len > speed * 1.02 or len < speed * 0.98:
				velocity = velocity.normalized() * speed
				
			if abs(velocity.x) < 3:
				velocity.x = sign(randf() * 2.0 - 1.0) * 100
			if abs(velocity.y) < 3:
				velocity.y = -sign(randf() * 2.0 - 1.0) * 100
			
			if collision.get_collider().has_method("hit"):
				collision.get_collider().hit()
			print("Normal = ", collision.get_normal(), " | Speed = ", velocity.length())



func game_over():
	GameManager.score = 0
	GameManager.level = 1
	get_tree().reload_current_scene()
	

func _on_danger_zone_body_entered(body: Node2D) -> void:
	await get_tree().create_timer(.1).timeout
	game_over()
