class_name EnemyStateDestroy extends EnemyState

@export var anim_name : String = "destroy"
@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0
@onready var hit_box: HitBox = $"../../HitBox"


var _direction : Vector2
var _damage_possition : Vector2

func init() -> void:
	super()
	enemy.enemy_destroyed.connect( _on_enemy_destroyed )

## what happens when the enemy enter this state? 
func enter() -> void:
	character.invulnerable = true
	hit_box.monitoring = false

	_direction = character.global_position.direction_to( _damage_possition )
	
	character.set_cardinal_direction( _direction )
	character.velocity = _direction * -knockback_speed
	
	character.update_animation( anim_name )
	character.animation_player.animation_finished.connect( _on_animation_finished )
	pass


func  physics(_delta: float) -> State:
	character.velocity -= character.velocity * decelerate_speed * _delta
	return null
	

func _on_enemy_destroyed( hit_data : HitData ) -> void:
	_damage_possition = hit_data.source_position
	state_machine.change_state( self )
	pass
	

func _on_animation_finished( _a : String ) -> void:
	character.queue_free()
	pass
