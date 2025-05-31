extends Control

#func _on_new_game_pressed() -> void:
	#TransitionScreen.transition()
	#await TransitionScreen.on_transition_finished
	#get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/file_select.tscn")

func _on_settings_pressed() -> void:
	pass # Replace with function body.

func _on_quit_pressed() -> void:
	get_tree().quit()
