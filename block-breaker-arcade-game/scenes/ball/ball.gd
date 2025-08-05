extends CharacterBody2D

var speed = 190
var direction = Vector2.DOWN
var is_active = true

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var hit_sound: AudioStreamPlayer2D = $HitSound
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	randomize()
	speed = speed + (10 * GameManager.level)
	velocity = Vector2(speed * -1, speed)
	

func _physics_process(delta: float) -> void:
	#ball behavior in the game
	if is_active:
		var collision = move_and_collide(velocity * delta)
		
		if collision:
			var current_speed = velocity.length()
			velocity = velocity.bounce(collision.get_normal()).normalized()\
			* current_speed * delta
			
			if hit_sound:
				hit_sound.pitch_scale = randf_range(0.9,1.1)
				hit_sound.play()
			
			var len = velocity.length()
			
			if len > speed * 1.02 or len < speed * 0.98:
				velocity = velocity.normalized() * speed
				
			if abs(velocity.x) < 3:
				velocity.x = sign(randf() * 2.0 - 1.0) * 100
			if abs(velocity.y) < 3:
				velocity.y = -sign(randf() * 2.0 - 1.0) * 100
			
			if collision.get_collider().has_method("hit"):
				collision.get_collider().hit()


func game_over():
	get_tree().change_scene_to_file("res://scenes/ui/end_screen.tscn")


func _on_danger_zone_body_entered(body: Node2D) -> void:
	#ball enters the death zone
	get_tree().paused = true
	GameManager.play_lose_sound()
	get_tree().paused = false
	game_over()
