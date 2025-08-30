extends Area2D

@onready var collision = $CollisionShape2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.collect_biscuit()
		visible = false
		remove_child(collision)
