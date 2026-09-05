class_name HurtBox extends Area2D

signal damaged( hit_data : HitData )


func take_damage( hit_data : HitData ) -> void:
	print("TakeDamage: ", hit_data.damage )
	damaged.emit( hit_data )
