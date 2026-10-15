extends Area2D


@onready var game_manager: Node = %GameManager
@onready var player: Node = $"../../SceneObjects/Player"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		# Check if the player is above or at the side of the duck
		var y_delta = position.y - body.position.y
		var x_delta = body.position.x - position.x
		if (y_delta < -350 && y_delta > -410):
			# Remove enemy and add point
			animated_sprite_2d.animation = "dying"
			await get_tree().create_timer(0.3).timeout
			queue_free()
			game_manager.add_point()
		else:
			# Deacrease player's health
			player.decrease_health()
			if (x_delta < 0):
				body.jump_side(500)
			else:
				body.jump_side(-500)
