extends Control

@onready var button1: Button = $"MarginContainer/VBoxContainer/File 1"
@onready var button2: Button = $"MarginContainer/VBoxContainer/File 2"
@onready var button3: Button = $"MarginContainer/VBoxContainer/File 3"

@onready var save1: SaveData
@onready var save2: SaveData
@onready var save3: SaveData

func _ready():
	save1 = load("user://save1.tres") as SaveData
	save2 = load("user://save2.tres") as SaveData
	save3 = load("user://save3.tres") as SaveData
	
	# Button 1 text
	if save1 != null:
		button1.text = "Level " + str(save1.level) + ", Deaths: " + str(save1.deaths)
	
	# Button 2 text
	if save2 != null:
		button2.text = "Level " + str(save2.level) + ", Deaths: " + str(save2.deaths)
	
	# Button 3 text
	if save3 != null:
		button3.text = "Level " + str(save3.level) + ", Deaths: " + str(save3.deaths)

func _on_file_1_pressed() -> void:
	Global.load_game(1)

func _on_file_2_pressed() -> void:
	Global.load_game(2)

func _on_file_3_pressed() -> void:
	Global.load_game(3)

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
