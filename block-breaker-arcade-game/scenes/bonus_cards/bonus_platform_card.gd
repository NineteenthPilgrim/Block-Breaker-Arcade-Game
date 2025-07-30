extends Area2D


func _ready():
	# Карта исчезает через 10 секунд, если не поймана
	await get_tree().create_timer(10).timeout
	queue_free()  


func _process(delta):
	position.y += 50 * delta


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Platform" and body is CharacterBody2D:
		# Замену сделает основной узел (например, Main.gd)
		var scene = get_tree().current_scene
		if scene.has_method("swap_to_big_platform"):
			scene.call_deferred("swap_to_big_platform")
		queue_free()
