extends Area2D


@export var swing_angle: float = 50.0 # Maximum swinging angle
@export var swing_speed: float = 3.0

@onready var player = $"../../SceneObjects/Player"
@onready var swing_pivot: Node2D = $".."

var time_passed: float = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_passed += delta
	swing_pivot.rotation = deg_to_rad(swing_angle) * sin( time_passed * swing_speed)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" :
		var x_delta = body.position.x - position.x
		player.decrease_health()
		if (x_delta < 0):
			body.jump_side(500)
		else:
			body.jump_side(-500)
