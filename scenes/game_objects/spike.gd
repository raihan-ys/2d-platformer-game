extends Area2D


@onready var player = $"../../SceneObjects/Player"

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" :
		# Get player's position
		var x_delta = body.position.x - position.x
		
		# player.decrease_health()
		
		# Make player jump from spikes
		if (x_delta < 0):
			body.jump_side(500)
		else:
			body.jump_side(-500)
