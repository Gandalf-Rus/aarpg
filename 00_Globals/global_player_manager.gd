extends Node

signal player_spawned(player: Player)

var player: Player:
	set(value):
		player = value
		if player:
			player_spawned.emit(player)
