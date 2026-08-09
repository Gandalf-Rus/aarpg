class_name StateOld extends Node

## stores a reference to the player that this state belongs 
static var player: Player

## what happens when we initialize this state? 
func Init() -> void:
	pass

## what happens when the player enter this state? 
func Enter() -> void:
	pass

## what happens when the player exit this state? 
func Exit() -> void:
	pass

## what happens during the _process update in this state?
func  Process(delta: float) -> StateOld:
	return null
	
## what happens during the _physics_process update in this state?
func Physics(delta: float) -> StateOld:
	return null
	
## what happens with _input events in this state?
func HandleInput(_event: InputEvent) -> StateOld:
	return null
