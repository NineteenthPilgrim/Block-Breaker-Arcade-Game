extends CanvasLayer


func _ready() -> void:
	GameManager.score_label.visible = true
	GameManager.level_label.visible = true


func _on_quit_button_pressed() -> void:
	get_tree().quit()
