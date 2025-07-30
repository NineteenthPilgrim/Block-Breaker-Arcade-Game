extends Node

@onready var score_label: Label = $CanvasLayer/ScoreLabel
@onready var level_label: Label = $CanvasLayer/LevelLabel

var score = 0
var level = 1
var levels : Array= [
	"res://scenes/levels/level_one.tscn",
	"res://scenes/levels/level_two.tscn",
	"res://scenes/levels/level_three.tscn",
	#"res://scenes/levels/level_four.tscn",
	#"res://scenes/levels/level_five.tscn",
]


func load_current_level():
	if level - 1 < levels.size():
		score = 0
		get_tree().change_scene_to_file(levels[level - 1])
	else:
		get_tree().change_scene_to_file("res://scenes/ui/end_screen.tscn")


func points(points):
	score += points
	

func _process(delta: float) -> void:
	score_label.text = str(score)
	level_label.text = "Level: " + str(level)
