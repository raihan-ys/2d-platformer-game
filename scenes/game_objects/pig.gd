extends Area2D


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var game_manager: Node = %GameManager
@onready var player: Node = $"../../SceneObjects/Player"

const SPEED = 100.0 # Pig's speed
var direction = -1.0 # Pig's starting direction

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += direction * SPEED * delta
	

# Flip moving direction
func _on_timer_timeout() -> void:
	direction *= -1
	animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h


# If colliding with player
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" :
		# Check if the player is above or at the side of the bird
		var y_delta = position.y - body.position.y
		var x_delta = body.position.x - position.x
		
		# If player's vertical position is not 0 and body is towards the enemy
		if (y_delta > 0 && body.velocity.y > 0):
			# Remove enemy and add point
			# ERROR: change to dying animation
			# animated_sprite_2d.animation = "dying"
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
