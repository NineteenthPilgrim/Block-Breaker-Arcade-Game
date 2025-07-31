extends CharacterBody2D

const speed = 500
const level_width = 256
const platform_width = 32
const platform_position_y: float = 240.0 


func _physics_process(delta: float) -> void:
	global_position.y = platform_position_y
	var mouse_x = get_global_mouse_position().x
	mouse_x = clamp(mouse_x, level_width / 16 + (platform_width / 2),\
	 level_width - 32 - (platform_width / 2))
	global_position.x = mouse_x
	global_position.y = platform_position_y
	move_and_slide()
