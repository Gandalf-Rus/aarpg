class_name StateIdle extends StateOld

@onready var walk: StateOld = $"../Walk"
@onready var attack: StateOld = $"../Attack"

## what happens when the player enter this StateOld? 
func Enter() -> void:
	player.UpdateAnimation("idle")
	pass

## what happens when the player exit this StateOld? 
func Exit() -> void:
	pass

## what happens during the _process update in this StateOld?
func  Process(_delta: float) -> StateOld:
	if player.direction != Vector2.ZERO:
		return walk
		
	player.velocity = Vector2.ZERO
	return null
	
## what happens during the _physics_process update in this StateOld?
func Physics(_delta: float) -> StateOld:
	return null
	
## what happens with _input events in this StateOld?
func HandleInput(_event: InputEvent) -> StateOld:
	if _event.is_action_pressed("attack"):
		return attack
	return null
