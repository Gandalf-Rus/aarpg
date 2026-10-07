class_name StateStun extends StateStunCommon

@export var damaged_effect_name : String = "damaged"


func enter() -> void:
	character.effect_animation_player.play( damaged_effect_name )
	super()
