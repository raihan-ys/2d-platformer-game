extends Area2D


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var game_manager: Node = %GameManager
@onready var player: Node = $"../../SceneObjects/Player"

const SPEED = 100.0 # Pig's speed
var direction = -1.0 # Pig's starting direction

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += direction * SPEED * delta
