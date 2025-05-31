extends Node

# Player's current level
var floor: int = 1
var level: int = 1

# Player stats, maybe add more
var deaths: int = 0

# Save/load variables
var file_num = 0

# TODO: refactor when more levels/floors are added
func next_level():
	if level < 3:
		level += 1
	save_game()
	
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://scenes/game" + str(level) + ".tscn")
	
func handle_death():
	deaths += 1
	save_game()
	
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().reload_current_scene()
	
func save_game():
	var save_data: SaveData = SaveData.new()
	
	save_data.floor = floor
	save_data.level = level
	save_data.deaths = deaths
	
	ResourceSaver.save(save_data, "user://save" + str(file_num) + ".tres")

func load_game(save_id):
	var save_data: SaveData = load("user://save" + str(save_id) + ".tres") as SaveData
	file_num = save_id
	
	if save_data != null:
		floor = save_data.floor
		level = save_data.level
		deaths = save_data.deaths
	else:
		floor = 1
		level = 1
		deaths = 0
		
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://scenes/game" + str(level) + ".tscn")
	
func delete_game(save_id):
	DirAccess.remove_absolute("user://save" + str(save_id) + ".tres")
	
	
