extends Control

@onready var file1: Button = $"MarginContainer/VBoxContainer/File 1"
@onready var file2: Button = $"MarginContainer/VBoxContainer/File 2"
@onready var file3: Button = $"MarginContainer/VBoxContainer/File 3"

@onready var delete1: Button = $"MarginContainer/VBoxContainer/Delete 1"
@onready var delete2: Button = $"MarginContainer/VBoxContainer/Delete 2"
@onready var delete3: Button = $"MarginContainer/VBoxContainer/Delete 3"

@onready var save1: SaveData
@onready var save2: SaveData
@onready var save3: SaveData

func _ready():
	save1 = load("user://save1.tres") as SaveData
	save2 = load("user://save2.tres") as SaveData
	save3 = load("user://save3.tres") as SaveData
	
	refresh_buttons()
	
func refresh_buttons():
	# Refresh save 1
	if save1 != null:
		file1.text = "Level " + str(save1.level) + ", Deaths: " + str(save1.deaths)
		delete1.disabled = false
	else:
		file1.text = "File 1: NEW"
		delete1.disabled = true
	
	# Refresh save 2
	if save2 != null:
		file2.text = "Level " + str(save2.level) + ", Deaths: " + str(save2.deaths)
		delete2.disabled = false
	else:
		file2.text = "File 2: NEW"
		delete2.disabled = true
	
	# Refresh save 3
	if save3 != null:
		file3.text = "Level " + str(save3.level) + ", Deaths: " + str(save3.deaths)
		delete3.disabled = false
	else:
		file3.text = "File 3: NEW"
		delete3.disabled = true

func _on_file_1_pressed() -> void:
	Global.load_game(1)

func _on_file_2_pressed() -> void:
	Global.load_game(2)

func _on_file_3_pressed() -> void:
	Global.load_game(3)

func _on_delete_1_pressed() -> void:
	Global.delete_game(1)
	save1 = null
	refresh_buttons()

func _on_delete_2_pressed() -> void:
	Global.delete_game(2)
	save2 = null
	refresh_buttons()

func _on_delete_3_pressed() -> void:
	Global.delete_game(3)
	save3 = null
	refresh_buttons()

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
