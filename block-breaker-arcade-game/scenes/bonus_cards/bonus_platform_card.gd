extends Area2D

@onready var platform_card: AudioStreamPlayer2D = $PlatformCard
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _ready():
	# Карта исчезает через 10 секунд, если не поймана
	await get_tree().create_timer(10).timeout
	call_deferred("queue_free") 


func _process(delta):
	position.y += 40 * delta


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Platform" and body is CharacterBody2D:
		if platform_card:
			platform_card.play()
		visible = false
		collision_shape_2d.disabled = true
		var scene = get_tree().current_scene
		if scene.has_method("swap_to_bonus_platform"):
			scene.call_deferred("swap_to_bonus_platform")
		await platform_card.finished
		call_deferred("queue_free")
