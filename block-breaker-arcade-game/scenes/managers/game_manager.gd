extends Node

@onready var score_label: Label = $CanvasLayer/ScoreLabel
@onready var lavel_label: Label = $CanvasLayer/LavelLabel

var score = 0
var level = 1

func points(points):
	score += points
	

func _process(delta: float) -> void:
	score_label.text = str(score)
	lavel_label.text = "Level: " + str(level)
