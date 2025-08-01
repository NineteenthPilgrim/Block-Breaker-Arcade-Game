extends CanvasLayer

@onready var panel_container: PanelContainer = $MarginContainer/PanelContainer

var is_closing = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true 

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if is_closing:
			return
		is_closing = true
		await get_tree().create_timer(.01).timeout
		get_tree().paused = false
		queue_free()

func _on_resume_button_pressed() -> void:
	if is_closing:
		return
	is_closing = true
	get_tree().paused = false
	queue_free()

func _on_option_button_pressed() -> void:
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
