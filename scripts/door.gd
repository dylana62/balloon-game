extends Area2D


func _on_body_entered(_body: Node2D) -> void:
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://scenes/game.tscn")
