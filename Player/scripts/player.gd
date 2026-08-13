class_name Player extends Character

signal DirectionChanged( new_direction : Vector2 )


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	PlayerManager.player = self
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
