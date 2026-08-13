class_name StateIdle extends State

@onready var walk: State = $"../Walk"
@onready var attack: State = $"../Attack"

## what happens when the player enter this StateOld? 
func enter() -> void:
	character.update_animation("idle")
	pass

## what happens during the _process update in this state?
func  process(_delta: float) -> State:
	if character.direction != Vector2.ZERO:
		return walk
		
	character.velocity = Vector2.ZERO
	return null
	
## what happens with _input events in this StateOld?
func handle_input(_event: InputEvent) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	return null
