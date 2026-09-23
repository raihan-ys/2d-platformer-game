extends Node
@onready var points_label: Label = %PointsLabel
@onready var main_character = $"../SceneObjects/MainCharacter"
@export var hearts : Array[Node]

var points = 0
var lives = 3

func decrease_health():
	lives -= 1
	
	# Decrease heart images
	for h in 3:
		if (h < lives):
				hearts[h].show()
		else:
			hearts[h].hide()
	if (lives == 0):
		main_character.die()
		# get_tree().reload_current_scene()

func add_point():
	points += 1
	points_label.text = "Points: " + str(points)
