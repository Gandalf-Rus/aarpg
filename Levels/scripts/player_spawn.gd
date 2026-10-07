extends Node2D

func _ready() -> void:
	visible = false
	if PlayerManager.player_set == false:
		PlayerManager.set_player_possition(global_position)
	
	
	
