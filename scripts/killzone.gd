extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	print("you died")
	body.get_node("AnimatedSprite2D").play("explode")
	body.get_node("AudioStreamPlayer2D").play()
	timer.start()


func _on_timer_timeout() -> void:
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().reload_current_scene()
