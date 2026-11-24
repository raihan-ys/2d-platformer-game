extends CharacterBody2D


@export var hearts: Array[Node]

# Variables for dash forward.
@export var dash_speed: float = 900.0
@export var dash_duration: float = 0.2
@export var double_tap_window: float = 0.3

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

const SPEED: float = 400.0
const JUMP_VELOCITY: int = -900.0
const MAX_JUMPS: int = 2

var jumps_left: int = MAX_JUMPS
var lives: int = 3
var alive: bool = true

# Variables for dash forward.
var is_dashing: bool = false
var dash_timer: float = 0.0
var dash_direction: float = 0.0
var last_tap_time: float = 0.0
var last_tap_action: String = ""

func decrease_health():
	lives -= 1
	
	# Decrease heart images
	for h in 3:
		if (h < lives):
			hearts[h].show()
		else:
			hearts[h].hide()
	if (lives == 0):
		alive = false

func _physics_process(delta: float) -> void:
	# Check if player alive
	if (!alive) :
		sprite_2d.animation = "dying"
		await get_tree().create_timer(2.0).timeout
		get_tree().reload_current_scene()
		
	# Animations
	if (velocity.x > 1 || velocity.x < -1) :
		sprite_2d.animation = "running"
	else :
		sprite_2d.animation = "default"
	
	# ERROR: HANDLE DASHING
	# Count down the double-tap window
	if last_tap_time > 0.0:
		last_tap_time -= delta
	else:
		last_tap_action = ""
	
	# Check for double-tap inputs
	
	
	# Add the gravity.
	if not is_on_floor():
		# Disable jumps if player just fell off a platform
		if jumps_left == MAX_JUMPS:
			jumps_left -= 2
		velocity += get_gravity() * delta
		sprite_2d.animation = "jumping"
	else:
		# Reset jumps when grounded
		jumps_left = MAX_JUMPS

	# Handle jump. 
	if Input.is_action_just_pressed("jump") and jumps_left > 0:
		velocity.y = JUMP_VELOCITY
		jumps_left -= 1

	# Double click to dash: Check whether a second press happens within a short window
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 12)

	move_and_slide()
	
	# Flip sprite if player is facing left.
	var isLeft = velocity.x < 0
	sprite_2d.flip_h = isLeft

# Jump to other direction
func jump_side(x):
	velocity.y = JUMP_VELOCITY
	velocity.x = x
