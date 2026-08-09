class_name StateWalk extends StateOld

@export var move_speed : float = 100.0

@onready var idle: StateOld = $"../Idle"
@onready var attack: StateOld = $"../Attack"


## what happens when the player enter this StateOld? 
func Enter() -> void:
	player.UpdateAnimation("walk")
	pass

## what happens when the player exit this StateOld? 
func Exit() -> void:
	pass

## what happens during the _process update in this StateOld?
func  Process(_delta: float) -> StateOld:
	if player.direction == Vector2.ZERO:
		return idle
	
	player.velocity = player.direction * move_speed
	
	if player.SetCardinalDirection():
		player.UpdateAnimation("walk")
	
	return null
	
## what happens during the _physics_process update in this StateOld?
func Physics(_delta: float) -> StateOld:
	return null
	
## what happens with _input events in this StateOld?
func HandleInput(_event: InputEvent) -> StateOld:
	if _event.is_action_pressed("attack"):
		return attack
	return null
