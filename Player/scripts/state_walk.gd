class_name StateWalk extends State

@export var move_speed : float = 100.0

@onready var idle: State = $"../Idle"
@onready var attack: State = $"../Attack"


## what happens when the player enter this state? 
func enter() -> void:
	character.update_animation("walk")
	pass

## what happens during the _process update in this state?
func  process(_delta: float) -> State:
	if character.direction == Vector2.ZERO:
		return idle
	
	character.velocity = character.direction * move_speed
	
	if character.set_cardinal_direction( character.direction ):
		character.update_animation("walk")
	
	return null

	
## what happens with _input events in this state?
func handle_input(_event: InputEvent) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	return null
