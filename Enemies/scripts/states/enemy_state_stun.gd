class_name EnemyStateStun extends EnemyState

@export var anim_name : String = "stun"
@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0

@export_category("AI")
@export var next_state : State

var _direction : Vector2
var _animation_finished : bool = false

func init() -> void:
	character.character_damaged.connect( _on_enemy_damaged )
	super()

## what happens when the enemy enter this state? 
func enter() -> void:
	character.invulnerable = true
	_animation_finished = false

	_direction = character.global_position.direction_to( enemy.player.global_position )
	
	character.set_cardinal_direction( _direction )
	character.velocity = _direction * -knockback_speed
	
	character.update_animation( anim_name )
	character.animation_player.animation_finished.connect( _on_animation_finished )
	pass

## what happens during the _process update in this state?
func process(_delta: float) -> State:
	if _animation_finished == true:
		return next_state
	return null

func  physics(_delta: float) -> State:
	character.velocity -= character.velocity * decelerate_speed * _delta
	return null
	
func exit() -> void:
	character.invulnerable = false
	character.animation_player.animation_finished.disconnect( _on_animation_finished )
	pass

func _on_enemy_damaged() -> void:
	state_machine.change_state( self )
	pass
	

func _on_animation_finished( _a : String ) -> void:
	_animation_finished = true
	pass
