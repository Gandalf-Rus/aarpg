class_name PlayerStateMachine extends Node

var states : Array[ StateOld ]
var prev_state : StateOld
var cur_state : StateOld

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ChangeState( cur_state.Process( delta ) )
	pass

func _physics_process(delta: float) -> void:
	ChangeState( cur_state.Physics( delta ) )
	pass


func _input(event: InputEvent) -> void:
	ChangeState( cur_state.HandleInput( event ) )
	pass


func Initialize( _player : Player ) -> void:
	states = []
	
	for c in get_children():
		if c is StateOld:
			states.append(c)
			
	if states.size() > 0:
		states[0].player = _player
		ChangeState(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT 


func ChangeState( new_state : StateOld ) -> void:
	if new_state == null || new_state not in states || new_state == cur_state:
		return
	
	if cur_state != null:
		cur_state.Exit()
	
	prev_state = cur_state
	cur_state = new_state
	
	cur_state.Enter()
