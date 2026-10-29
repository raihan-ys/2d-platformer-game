extends Node


@onready var points_label: Label = %PointsLabel
var points = 0

func add_point():
	points += 1
	print("Points +1")
	#points_label.text = "Points: " + str(points)
