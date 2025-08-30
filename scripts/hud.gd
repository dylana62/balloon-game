extends CanvasLayer

@onready var biscuit_label = $BiscuitLabel

func _process(_delta):
	var player = get_tree().get_first_node_in_group("Player")
	if player != null:
		biscuit_label.text = "Biscuits: " + str(player.biscuits) + "/" + str(Global.biscuits[Global.level-1])
