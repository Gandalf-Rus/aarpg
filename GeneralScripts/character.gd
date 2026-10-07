class_name Character extends CharacterBody2D

signal direction_changed( new_direction : Vector2 )
signal character_damaged( hit_data : HitData )
signal hp_changed( hp : int, max_hp : int )


const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP ]

@export var animation_player: AnimationPlayer
@export var effect_animation_player: AnimationPlayer
@export var sprite: Sprite2D
@export var state_machine: StateMachine

@export var hurt_box : HurtBox

@export var hp : int = 3
@export var max_hp : int = hp

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO

var invulnerable : bool = false

func _ready() -> void:
	if not sprite: sprite = get_node_or_null("Sprite2D")
	if not animation_player: animation_player = get_node_or_null("AnimationPlayer")
	if not state_machine: state_machine = get_node_or_null("StateMachine")
	
	if not sprite or not animation_player or not state_machine:
		error_string(ERR_FILE_MISSING_DEPENDENCIES)
	
	state_machine.initialize( self )
	pass


func _process(_delta: float) -> void:
	pass


func _physics_process(_delta: float) -> void:
	move_and_slide()


func set_cardinal_direction( _new_direction : Vector2 = Vector2.ZERO ) -> bool:
	direction = _new_direction
	if direction == Vector2.ZERO:
		return false
		
	var direction_id : int  = int( round( 
			( direction + cardinal_direction * 0.1 ).angle() / TAU * DIR_4.size() 
		) )
	var new_direction : Vector2 = DIR_4[ direction_id ]
	
	if new_direction == cardinal_direction:
		return false
		
	cardinal_direction = new_direction
	direction_changed.emit( new_direction )
	
	return true


func update_animation( state : String ) -> void:
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	
	animation_player.play(state + "_" + get_animation_direction())
	pass


func get_animation_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"


func make_invulnerable( _duration : float = 1.0 ) -> void:
	invulnerable = true
	hurt_box.set_deferred("monitorable", false)
	
	await get_tree().create_timer( _duration ).timeout
	
	invulnerable = false
	hurt_box.set_deferred("monitorable", true)
	pass


func update_hp( delta : int ) -> void:
	hp = clampi(hp + delta, 0, max_hp)
	hp_changed.emit( hp, max_hp )
	pass
