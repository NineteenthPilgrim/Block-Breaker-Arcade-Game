extends CanvasLayer


@onready var window_button: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/WindowMode/WindowButton
@onready var back_button: Button = %BackButton
@onready var sfx_slider: HSlider = %SFXSlider


func _ready() -> void:
	update_options()
	sfx_slider.value = get_volume_percent(1)

func update_options():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		window_button.text = "Fullscreen"
	else:
		window_button.text = "Windowed"


func _on_window_button_pressed() -> void:
	var mode = DisplayServer.window_get_mode()
	if mode != DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	update_options()

	
	
func get_volume_percent(bus_index: int):
	var volume_db = AudioServer.get_bus_volume_db(bus_index)
	return db_to_linear(volume_db)


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")


func _on_sfx_slider_value_changed(value: float) -> void:
	var volume_db = linear_to_db(value)
	AudioServer.set_bus_volume_db(1,volume_db)
