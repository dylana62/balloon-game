extends CharacterBody2D

@onready var air_bar: ProgressBar = $AirBar
@onready var timer: Timer = $Timer
@onready var sfx: AudioStreamPlayer2D = $AudioStreamPlayer2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const MAX_AIR = 100.0

var dash = 1
var air = MAX_AIR

func _ready() -> void:
	set_air_label()
	
func set_air_label() -> void:
	pass
	#air_bar.text = "Air: %s" % air

func _process(delta: float) -> void:
	air_bar.value = air
	air -= delta * 6 * dash
	
	if air <= 0:
		get_node("AnimatedSprite2D").play("explode")
		get_tree().reload_current_scene()
		

func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
	#	velocity += get_gravity() * delta

	# Handle dash.
	if Input.is_action_pressed("ui_accept"):
		dash = 2
	else:
		dash = 1

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var horiz := Input.get_axis("ui_left", "ui_right")
	if horiz:
		velocity.x = horiz * SPEED * dash
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	var vert := Input.get_axis("ui_up", "ui_down")
	if vert:
		velocity.y = vert * SPEED * dash
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
