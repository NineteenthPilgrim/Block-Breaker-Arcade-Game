extends Area2D

@export var ball_scene: PackedScene

@onready var ball_card: AudioStreamPlayer2D = $BallCard
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _ready():
	#remove the card 10 seconds after it appears
	connect("body_entered", Callable(self, "_on_body_entered"))
	var timer = get_tree().create_timer(10)
	await timer.timeout
	call_deferred("queue_free")  


func _process(delta):
	position.y += 40 * delta  


func _on_body_entered(body):
	#spawn an extra ball above the platform and activate it
	if body.name == "Platform" or body.name == "BonusPlatform":
		if ball_card:
			ball_card.play()
		
		set_deferred("visible", false)
		collision_shape_2d.disabled = true
		
		if not ball_scene:
			return
		
		var ball = ball_scene.instantiate()
		get_tree().current_scene.add_child(ball)
		ball.global_position = body.global_position + Vector2(0, -8)
		ball.is_active = true
		await ball_card.finished
		call_deferred("queue_free")
