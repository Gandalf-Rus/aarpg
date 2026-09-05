class_name HitData extends RefCounted

var damage: int
var source_position: Vector2

func _init(_damage: int, _source_pos: Vector2 = Vector2.ZERO):
	damage = _damage
	source_position = _source_pos
