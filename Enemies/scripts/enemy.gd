class_name Enemy extends Character

#signal enemy_damaged(  )

@export var hp : int = 3

var player : Player


func _ready() -> void:
	super()
	player = PlayerManager.player
	pass
