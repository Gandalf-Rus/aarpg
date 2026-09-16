class_name StateStun extends StateStunCommon

@export var damaged_effect_name : String = "damaged"


## what happens when the player enter this state? 
func enter() -> void:
	character.effect_animation_player.play( damaged_effect_name )
	super()
