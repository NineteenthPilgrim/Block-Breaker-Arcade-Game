extends CanvasLayer


func _ready() -> void:
	#hide UI
	GameManager.score_label.set_deferred("visible", false)
	GameManager.level_label.set_deferred("visible", false)


func _on_quit_button_pressed() -> void:
	get_tree().quit()
