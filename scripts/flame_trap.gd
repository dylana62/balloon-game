extends Node2D

@onready var collision = $Killzone/CollisionShape2D
@onready var anim_sprite = $AnimatedSprite2D

@export var CYCLE_TIME: float = 2
@export var ACTIVATED: bool = false

var t: float = 0.0

func _ready():
	if not ACTIVATED:
		anim_sprite.play("off")
		collision.disabled = true
	else:
		anim_sprite.play("on")
		collision.disabled = false
	#anim_sprite.animation_finished.connect(on_animated_sprite_2d_animation_finished)

func _process(delta: float) -> void:
	t += delta
	
	if t > CYCLE_TIME:
		t = 0.0
		if not ACTIVATED:
			anim_sprite.play("start")
			ACTIVATED = true
		else:
			anim_sprite.play("stop")
			collision.disabled = true
			ACTIVATED = false

func _on_animated_sprite_2d_animation_finished() -> void:
	if ACTIVATED:
		anim_sprite.play("on")
		collision.disabled = false
	else:
		anim_sprite.play("off")
