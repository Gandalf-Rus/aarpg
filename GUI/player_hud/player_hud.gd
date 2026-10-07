extends CanvasLayer

var hearts : Array[ HeartGUI ] = []


func _ready() -> void:
	for child in $Control/HFlowContainer.get_children():
		if child is HeartGUI:
			hearts.append( child )
			child.visible = false

	PlayerManager.player_spawned.connect(_on_player_spawned)
	if PlayerManager.player:
		_on_player_spawned(PlayerManager.player)
	pass
	
	
func _on_player_spawned(new_player: Player) -> void:
	if not new_player.hp_changed.is_connected(update_hp):
		new_player.hp_changed.connect(update_hp)

	update_hp(new_player.hp, new_player.max_hp)


func update_hp( _hp: int, _max_hp: int ) -> void:
	update_max_hp( _max_hp )
	var heart_count: int = ceili(_max_hp / 2.0)
	for i in heart_count:
		update_heart( i, _hp )
	pass


func update_heart( _index : int, _hp : int ) -> void:
	var _value : int = clampi( _hp - _index * 2, 0, 2 )
	hearts[ _index ].value = _value 
	pass


func update_max_hp( _max_hp : int ) -> void:
	var _heart_count : int = ceili( _max_hp / 2.0 )
	for i in hearts.size():
		if i < _heart_count:
			hearts[i].visible = true
		else:
			hearts[i].visible = false
	pass
