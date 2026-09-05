class_name Enemy extends Character

signal enemy_destroyed( hit_data : HitData ) 

var player : Player


func _ready() -> void:
	player = PlayerManager.player
	hit_box.damaged.connect( _take_damage )
	super()
	pass
	

func _take_damage( hit_data : HitData ) -> void:
	if invulnerable == true:
		return
	hp -= hit_data.damage
	if hp > 0:
		character_damaged.emit( hit_data )
	else:
		enemy_destroyed.emit( hit_data )
	
	pass
