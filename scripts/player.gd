extends CharacterBody2D

@onready var air_meter: ProgressBar = Hud.get_node("Air Meter")
@onready var timer: Timer = $Timer
@onready var sfx: AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var SPEED: float = 300.0
@export var ACCEL: float = 2.0
@export var AIR_LOSS: float = 2.0
@export var BOUNCINESS: float = 1.0

# Input vars
var input: Vector2
var is_dashing: bool = false

# Air vars
const MAX_AIR = 100.0
var air = MAX_AIR

var wind_push: Vector2 = Vector2.ZERO

var respawn_started: bool = false

func get_input():
	input.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	return input.normalized()

func _process(delta: float) -> void:
	air_meter.value = air
	
	if is_dashing:
		air -= delta * AIR_LOSS * 5
	else:
		air -= delta * AIR_LOSS
	
	# Respawn if player runs out of air
	if air <= 0 and !respawn_started:
		respawn_started = true
		get_node("AnimatedSprite2D").play("explode")
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		get_tree().reload_current_scene()
		
	# Handle pause/unpause
	if Input.is_action_just_pressed("pause"):
		PauseMenu.pause()
		

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var player_input = get_input()
	
	# Handle dash.
	if Input.is_action_pressed("dash") and player_input != Vector2(0, 0):
		is_dashing = true
	else:
		is_dashing = false
	
	if is_dashing:
		velocity = lerp(velocity + wind_push, player_input * SPEED * 2, delta * ACCEL * 2)
	else:
		velocity = lerp(velocity + wind_push, player_input * SPEED, delta * ACCEL)
	
	# Handle movement
	# If dashing, use move_and_collide() to handle bouncing off walls
	# Else, need to use move_and_slide()
	if is_dashing:
		var collision = move_and_collide(velocity * delta)
		if collision:
			print(collision.get_normal())
			velocity = velocity.bounce(collision.get_normal()) * BOUNCINESS
	else:
		move_and_slide()

func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()

func _on_wind_zone_body_entered(_body, path):
	var wind_speed = get_node(path).wind_speed
	wind_push = Vector2(wind_speed, 0.0)
	
	match get_node(path).wind_direction:
		"Up":
			wind_push = Vector2(0.0, -wind_speed)
		"Down":
			wind_push = Vector2(0.0, wind_speed)
		"Left":
			wind_push = Vector2(-wind_speed, 0.0)
		"Right":
			wind_push = Vector2(wind_speed, 0.0)


func _on_wind_zone_body_exited(_body):
	wind_push = Vector2.ZERO
