extends RigidBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_brick_one: CollisionShape2D = %CollisionShapeBrickOne

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func hit():
	GameManager.points(1)
	$CPUParticles2D.emitting = true
	sprite_2d.visible = false
	collision_shape_brick_one.disabled = true
	var brick_left = get_tree().get_nodes_in_group('Brick')
	if brick_left.size() == 1:
		#get_parent().get_node("Ball").is_active = false
		await get_tree().create_timer(1).timeout
		GameManager.level += 1 
		GameManager.load_current_level()
		#get_tree().reload_current_scene()
	else:
		await get_tree().create_timer(1).timeout
		queue_free()
	
