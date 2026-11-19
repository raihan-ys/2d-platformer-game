extends Area2D


@onready var player = $"../../SceneObjects/Player"

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" :
		var x_delta = body.position.x - position.x
		player.decrease_health()
		if (x_delta < 0):
			body.jump_side(500)
		else:
			body.jump_side(-500)
