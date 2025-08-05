extends RigidBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func clear_bonuses():
	for bonus in get_tree().get_nodes_in_group("Bonus"):
		bonus.call_deferred("queue_free")


func hit():
	#processes ball-brick collision: play effects, update score, and remove brick
	GameManager.points(1)
	$CPUParticles2D.emitting = true
	sprite_2d.set_deferred("visible", false)
	collision_shape_2d.disabled = true
	var brick_left = get_tree().get_nodes_in_group('Brick')
	
	if brick_left.size() == 1:
		var balls = get_tree().get_nodes_in_group("Ball")
		
		for ball in balls:
			if ball.has_method("stop"):
				ball.stop()
			else:
				ball.call_deferred("queue_free")
			
		get_tree().paused = true
		await GameManager.play_win_sound()
		get_tree().paused = false
		clear_bonuses()
		GameManager.level += 1 
		GameManager.load_current_level()
	else:
		await get_tree().create_timer(1).timeout
		call_deferred("queue_free")
	
