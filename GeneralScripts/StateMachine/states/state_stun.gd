class_name StateStunCommon extends State

@export var anim_name : String = "stun"
@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0
@export var invulnerable_duration : float = 0.5

@export var next_state : State

var _direction : Vector2
var _damage_possition : Vector2

var switch_state : State = null

func init() -> void:
	character.character_damaged.connect( _on_damaged )
	super()


func enter() -> void:
	switch_state = null
	character.make_invulnerable( invulnerable_duration )
	
	_direction = character.global_position.direction_to( _damage_possition )
	
	character.set_cardinal_direction( _direction )
	character.velocity = _direction * -knockback_speed
	
	character.update_animation( anim_name )
	character.animation_player.animation_finished.connect( _on_animation_finished )
	pass


func process(_delta: float) -> State:
	return switch_state
	
	
func physics(_delta: float) -> State:
	character.velocity -= character.velocity * decelerate_speed * _delta
	return null


func exit() -> void:
	character.animation_player.animation_finished.disconnect( _on_animation_finished )


func _on_damaged( hit_data : HitData ) -> void:
	_damage_possition = hit_data.source_position
	state_machine.change_state( self )
	pass

	
func _on_animation_finished( _a : String ) -> void:
	switch_state = next_state
	pass
