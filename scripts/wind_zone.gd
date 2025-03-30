extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	print("you died")
	body.get_node("AnimatedSprite2D").play("explode")
	
