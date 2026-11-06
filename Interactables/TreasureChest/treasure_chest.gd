@tool
class_name TreasureChest extends Node2D

@export var item : ItemData : set = _set_item_data
@export var quantity : int : set = _set_quantity 

@onready var interact_area: Area2D = $Area2D
@onready var item_sprite: Sprite2D = $ItemSprite
@onready var label: Label = $ItemSprite/Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer


var is_open : bool = false

func _ready() -> void:
	_update_texture()
	_update_label()
	if Engine.is_editor_hint():
		return
	interact_area.area_entered.connect( _on_area_entered )
	interact_area.area_exited.connect( _on_area_exit )
	pass

func _on_area_entered( _a : Area2D ) -> void:
	#if b is Player:
	PlayerManager.interact_pressed.connect( player_interact )
	pass
	
func _on_area_exit( _a  : Area2D ) -> void:
	PlayerManager.interact_pressed.disconnect( player_interact )

func player_interact() -> void:
	if is_open:
		return
	is_open = true
	animation_player.play("open")
	if item and quantity > 0:
		PlayerManager.INVENTORY_DATA.add_data( item, quantity )
	else:
		printerr("No Items in chest!")
		push_error("No Items in chest! Name: ", name)
	pass

func _set_quantity( val : int ) -> void:
	quantity = val
	_update_label()
	pass

func _set_item_data( value : ItemData ) -> void:
	item = value
	_update_texture()

func _update_label() -> void:
	if label:
		if quantity <= 1:
			label.text = ""
		else:
			label.text = "x" + str(quantity)

func _update_texture() -> void:
	if item and item_sprite:
		item_sprite.texture = item.texture
