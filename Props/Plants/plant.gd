class_name Plant extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Hitbox.damaged.connect( TakeDamage )
	pass # Replace with function body.
	
	
func TakeDamage( hit_data : HitData ) -> void:
	queue_free()
	pass
