extends Area2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var shield_card: AudioStreamPlayer2D = $ShieldCard


func _ready():
	# Карта исчезает через 10 секунд, если не поймана
	await get_tree().create_timer(10).timeout
	call_deferred("queue_free")

func _process(delta):
	position.y += 40 * delta


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Platform" or body.name == "BonusPlatform":
		if shield_card:
			shield_card.play()
		visible = false
		collision_shape_2d.disabled = true
		var scene = get_tree().current_scene
		if scene.has_method("spawn_bonus_shield"):
			scene.call_deferred("spawn_bonus_shield")  # вызываем безопасно
		await shield_card.finished
		call_deferred("queue_free")
