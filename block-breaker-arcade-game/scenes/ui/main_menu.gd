extends CanvasLayer



func _on_play_button_pressed() -> void:
	GameManager.level = 1
	get_tree().change_scene_to_file("res://scenes/levels/level_one.tscn")


func _on_option_button_pressed() -> void:
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().quit()
