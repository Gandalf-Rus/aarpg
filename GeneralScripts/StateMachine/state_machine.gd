class_name StateMachine extends Node

@export var handles_input: bool = false

var states : Array[ State ]
var prev_state : State
var cur_state : State


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	set_process_input(handles_input)
	pass


func _process(delta: float) -> void:
	change_state( cur_state.process( delta ) )
	pass


func _physics_process(delta: float) -> void:
	change_state( cur_state.physics( delta ) )
	pass
	
func _input(event: InputEvent) -> void:
	change_state( cur_state.handle_input( event ) )
	pass


func initialize( _character : Character ) -> void:
	states = []
	
	for c in get_children():
		if c is State:
			states.append(c)
	
	for s in states:
		s.character = _character
		s.state_machine = self
		s.init()
		
	if states.size() > 0:
		change_state( states[0] )
		process_mode = Node.PROCESS_MODE_INHERIT 
	
	pass


func change_state( new_state : State ) -> void:
	if new_state == null || new_state not in states || new_state == cur_state:
		return
	
	if cur_state:
		cur_state.exit()
	
	prev_state = cur_state
	cur_state = new_state
	cur_state.enter()
