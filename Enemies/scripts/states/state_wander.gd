class_name EnemyStateWander extends State

@export var anim_name : String = "walk"
@export var walk_speed : float = 20.0

@export_category("AI")
@export var state_animation_duration : float = 0.5
@export var state_cycles_min : int = 1
@export var state_cycles_max : int = 3
@export var next_state : State

var _timer : float = 0.0
var _direction : Vector2

## what happens when the enemy enter this state? 
func enter() -> void:
	_timer = randi_range( state_cycles_min , state_cycles_max ) * state_animation_duration
	var rand_direction = randi_range( 0, 3 )
	_direction = character.DIR_4[ rand_direction ]
	character.velocity = _direction * walk_speed
	character.set_cardinal_direction( _direction )
	character.update_animation( anim_name )
	pass

## what happens during the _process update in this state?
func  process(_delta: float) -> State:
	_timer -= _delta
	if _timer <= 0:
		return next_state
	return null
	
## what happens during the _physics_process update in this state?
func physics(_delta: float) -> State:
	return null
