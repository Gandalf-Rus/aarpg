class_name EnemyStateMachine extends Node

var states : Array[ EnemyState ]
var prev_state : EnemyState
var cur_state : EnemyState


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	pass


func _process(delta: float) -> void:
	change_state( cur_state.process( delta ) )
	pass


func _physics_process(delta: float) -> void:
	change_state( cur_state.physics( delta ) )
	pass


func initialize( _enemy : Enemy ) -> void:
	states = []
	
	for c in get_children():
		if c is EnemyState:
			states.append(c)
	
	for s in states:
		s.enemy = _enemy
		s.state_machine = self
		s.init()
		
		
	if states.size() > 0:
		change_state( states[0] )
		process_mode = Node.PROCESS_MODE_INHERIT 
	
	pass


func change_state( new_state : EnemyState ) -> void:
	if new_state == null || new_state not in states || new_state == cur_state:
		return
	
	if cur_state:
		cur_state.exit()
	
	prev_state = cur_state
	cur_state = new_state
	cur_state.enter()
