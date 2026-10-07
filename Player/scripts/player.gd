class_name Player extends Character

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerManager.player = self
	hurt_box.damaged.connect( _take_damage )
	update_hp(99)
	super()
	pass 


func _process(delta: float) -> void:
	#direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	#direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	#direction = direction.normalized()
	
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized()	
	pass


func _take_damage( hit_data : HitData ) -> void:
	if invulnerable == true:
		return
	update_hp( -hit_data.damage )
	if hp > 0:
		character_damaged.emit( hit_data )
	else:
		character_damaged.emit( hit_data )
		update_hp(99)
	
	pass
