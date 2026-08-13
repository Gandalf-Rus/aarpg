class_name State extends Node

var character : Character

## what happens when we initialize this state? 
func init() -> void:
	pass

## what happens when owner enter this state? 
func enter() -> void:
	pass

## what happens when owner exit this state? 
func exit() -> void:
	pass


## what happens during the _process update in this state?
func  process(_delta: float) -> State:
	return null

	
## what happens during the _physics_process update in this state?
func physics(_delta: float) -> State:
	return null

	
## what happens with _input events in this state?
func handle_input(_event: InputEvent) -> State:
	return null
