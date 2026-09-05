class_name StateStun extends State

@export var anim_name : String = "stun"
@export var damaged_effect_name : String = "damaged"
@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0
@export var invulnerable_duration : float = 1.0

@onready var idle: State = $"../Idle"

var _direction : Vector2
var _damage_possition : Vector2
var next_state : State = null

func init() -> void:
	character.character_damaged.connect( _on_damaged )

## what happens when the player enter this state? 
func enter() -> void:
	character.make_invulnerable( invulnerable_duration )
	character.effect_animation_player.play( damaged_effect_name )
	
	_direction = character.global_position.direction_to( _damage_possition )
	character.velocity = _direction * -knockback_speed
	character.set_cardinal_direction( _direction )
	
	character.update_animation( anim_name )
	character.animation_player.animation_finished.connect( _on_animation_finished )
	pass

## what happens during the _process update in this state?
func  process(_delta: float) -> State:
	return next_state
	
	
func  physics(_delta: float) -> State:
	character.velocity -= character.velocity * decelerate_speed * _delta
	return null
	
	
	
func exit() -> void:
	next_state = null
	character.animation_player.animation_finished.disconnect( _on_animation_finished )
	
func _on_damaged( hit_data : HitData ) -> void:
	_damage_possition = hit_data.source_position
	state_machine.change_state( self )
	pass

	
func _on_animation_finished( _a : String ) -> void:
	next_state = idle
	pass
