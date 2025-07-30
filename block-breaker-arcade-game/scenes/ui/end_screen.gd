extends CanvasLayer
class_name EndScreen


func _ready() -> void:
	get_tree().paused = true
	GameManager.score_label.visible = false
	GameManager.level_label.visible = false

func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	GameManager.score_label.visible = true
	GameManager.level_label.visible = true
	GameManager.load_current_level()
	#get_tree().change_scene_to_file(GameManager.load_current_level())
	#get_tree().change_scene_to_file("res://scenes/levels/level_one.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
