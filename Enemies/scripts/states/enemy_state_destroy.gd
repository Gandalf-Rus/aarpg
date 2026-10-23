class_name EnemyStateDestroy extends EnemyState

const PICKUP = preload("res://Items/item_pickup/item_pickup.tscn")
const TILE_SIZE : int = 32

@export var anim_name : String = "destroy"
@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0

@export_category("Item Drops")
@export var drops : Array[DropData]

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
	drop_items()
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


func drop_items() -> void:
	if drops.size() == 0:
		return
	
	for i in drops.size():
		if drops[i] == null or drops[i].item == null:
			continue
		var drop_count : int = drops[i].get_drop_count()
		for j in drop_count:
			var drop : ItemPickup = PICKUP.instantiate() as ItemPickup
			drop.item_data = drops[i].item
			enemy.get_parent().call_deferred("add_child", drop)
			drop.global_position = enemy.global_position
			drop.velocity = enemy.velocity.rotated(randf_range(-1.5, 1.5)) * randf_range(0.9, 1.5)
