extends Node2D

@export var MOVING: bool = false
@export var MOVE_SPEED = 5
@export var MOVE_DISTANCE: Vector2 = Vector2(0.0, 3.0)

var start_position: Vector2
var is_coming_back: bool
var t: float = 0.0

func _ready() -> void:
	start_position = position
	is_coming_back = false

func _process(delta):
	if !MOVING:
		return
	
	# MOVEMENT
	if !is_coming_back:
		position = lerp(position, start_position + MOVE_DISTANCE, MOVE_SPEED * delta)
	else:
		position = lerp(position, start_position, MOVE_SPEED * delta)
	
	# TIME
	t = lerp(t, 1.0, MOVE_SPEED * delta)
	
	if t > 0.99:
		t = 0.0
		
		if !is_coming_back:
			is_coming_back = true
		else:
			is_coming_back = false
	
