extends Node

const PLAYER = preload("res://Player/player.tscn")

signal player_spawned(player: Player)

var player: Player:
	set(value):
		player = value
		if player:
			player_spawned.emit(player)
			
var player_set : bool  = false


func _ready() -> void:
	add_player_instance()


func add_player_instance() -> void:
	player = PLAYER.instantiate()
	add_child(player)
	pass
	
func set_player_possition( _new_pos : Vector2 ) -> void:
	if player:
		player.global_position = _new_pos
		player_set = true
	pass

func set_as_parent(_p : Node2D) -> void:
	if not player:
		return
	
	if player.get_parent():
		player.get_parent().remove_child(player)
	_p.add_child(player)
	
	pass

func unparent_player(_p : Node2D) -> void:
	if player:
		_p.remove_child(player)
