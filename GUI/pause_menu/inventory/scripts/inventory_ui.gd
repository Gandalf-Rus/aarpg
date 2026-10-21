class_name InventoryUI extends Control

const INVENTORY_SLOT = preload("res://GUI/pause_menu/inventory/inventory_slot.tscn")

@export var data : InventoryData
var focus_index : int = 0

func _ready() -> void:
	PauseMenu.shown.connect(update_inventory)
	PauseMenu.hidden.connect(clear_inventory)
	clear_inventory()
	data.changed.connect( on_inventory_changed )
	pass


func clear_inventory() -> void:
	for c in get_children():
		remove_child(c)
		c.queue_free()


func update_inventory( focus_indx : int = 0 ) -> void:
	for s in data.slots:
		var new_slot : InentorySlotUI = INVENTORY_SLOT.instantiate()
		add_child(new_slot)
		new_slot.slot_data = s
		new_slot.focus_entered.connect( item_focused )
	
	get_child( focus_indx ).grab_focus()


func item_focused() -> void:
	for i in get_child_count():
		if get_child(i).has_focus():
			focus_index = i
			return


func on_inventory_changed() -> void:
	var i = focus_index
	clear_inventory()
	update_inventory( i )
