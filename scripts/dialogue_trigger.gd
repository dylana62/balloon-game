extends Area2D

var resource = load("res://dialogue/main.dialogue")

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	
func _on_body_entered(body: Node):
	if body.is_in_group("Player"):
		print("dialogue trigger entered")
		body.pause_movement()
		DialogueManager.show_dialogue_balloon(resource, "start")

func _on_dialogue_ended(resource):
	var player = get_tree().get_first_node_in_group("Player")
	player.unpause_movement()
	process_mode = Node.PROCESS_MODE_DISABLED
