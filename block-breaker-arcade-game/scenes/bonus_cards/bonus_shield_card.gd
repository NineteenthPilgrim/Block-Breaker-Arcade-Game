extends Area2D


func _ready():
	# Карта исчезает через 10 секунд, если не поймана
	await get_tree().create_timer(10).timeout
	queue_free()  


func _process(delta):
	position.y += 40 * delta


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Platform" or body.name == "BonusPlatform":
		var scene = get_tree().current_scene
		if scene.has_method("spawn_bonus_shield"):
			scene.call_deferred("spawn_bonus_shield")  # вызываем безопасно
		queue_free()
