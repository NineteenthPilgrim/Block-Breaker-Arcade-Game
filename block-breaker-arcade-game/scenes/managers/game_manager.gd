extends Node

@onready var score_label: Label = $CanvasLayer/ScoreLabel
@onready var level_label: Label = $CanvasLayer/LevelLabel

@onready var win_audio: AudioStreamPlayer2D = $WinAudio
@onready var lose_audio: AudioStreamPlayer2D = $LoseAudio

var score = 0
var wave = 1
var level = 1
var levels : Array= [
	"res://scenes/levels/level_one.tscn",
	"res://scenes/levels/level_two.tscn",
	"res://scenes/levels/level_three.tscn",
	"res://scenes/levels/level_four.tscn",
	"res://scenes/levels/level_five.tscn",
]

func play_win_sound() -> void:
	win_audio.play()
	await win_audio.finished

func play_lose_sound() -> void:
	lose_audio.play()
	await lose_audio.finished

func load_current_level():
	#load the required level
	if level - 1 < levels.size():
		score = 0
		get_tree().change_scene_to_file(levels[level - 1])
	else:
		get_tree().change_scene_to_file("res://scenes/ui/final_menu.tscn")


func points(points):
	score += points
	

func _process(delta: float) -> void:
	score_label.text = str(score)
	level_label.text = "Level: " + str(level)
