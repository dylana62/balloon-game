extends CanvasLayer

@onready var anim_player: AnimationPlayer = $Control/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	anim_player.play("RESET")

func resume():
	get_tree().paused = false
	anim_player.play_backwards("blur")
	hide()
	
func pause():
	show()
	get_tree().paused = true
	anim_player.play("blur")

func _on_resume_pressed() -> void:
	resume()

func _on_main_menu_pressed() -> void:
	resume()
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
