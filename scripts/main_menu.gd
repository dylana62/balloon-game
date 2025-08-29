extends Control

@onready var audio_player = $AudioStreamPlayer2D

func _ready():
	$MarginContainer/VBoxContainer/Play.grab_focus()

func _on_play_pressed() -> void:
	audio_player.play()
	await audio_player.finished
	get_tree().change_scene_to_file("res://scenes/file_select.tscn")

func _on_settings_pressed() -> void:
	pass # Replace with function body.

func _on_quit_pressed() -> void:
	get_tree().quit()
