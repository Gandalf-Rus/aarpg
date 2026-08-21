class_name Enemy extends Character

signal enemy_destroyed() 

@export var hp : int = 3
@export var hit_box : HitBox

var player : Player


func _ready() -> void:
	player = PlayerManager.player
	hit_box.damaged.connect( _take_damage )
	super()
	pass
	

func _take_damage( damage : int ) -> void:
	if invulnerable == true:
		return
	hp -= damage
	if hp > 0:
		character_damaged.emit()
	else:
		enemy_destroyed.emit()
	
	pass
