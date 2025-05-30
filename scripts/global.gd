extends Node

# Player's current level
var floor: int = 1
var level: int = 1

# Player's other stats, maybe add more
var deaths: int = 0

# TODO: refactor when more levels/floors are added
func next_level():
	level += 1
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://scenes/game" + str(level) + ".tscn")
	
func handle_death():
	deaths += 1
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().reload_current_scene()
