extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if body.biscuits == Global.biscuits[Global.level - 1]:
			Global.next_level()
