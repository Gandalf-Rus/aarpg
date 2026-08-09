class_name StateAttack extends StateOld

var attacking : bool = false

@export var attack_sound : AudioStream
@export_range(1, 20, 0.5) var decelerate_speed : float = 10.0

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var attack_effect_anim_player: AnimationPlayer = $"../../Sprite2D/AttackEffectSprite/AnimationPlayer"
@onready var audio: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"

@onready var walk: StateOld = $"../Walk"
@onready var idle: StateOld = $"../Idle"

@onready var hurt_box: HurtBox = %AttackHurtBox

## what happens when the player enter this StateOld? 
func Enter() -> void:
	player.UpdateAnimation("attack")
	attack_effect_anim_player.play("attack" + "_" + player.GetAnimationDirection())
	animation_player.animation_finished.connect( EndAttack )
	
	audio.stream = attack_sound
	audio.pitch_scale = randf_range(0.8, 1.1)
	audio.play()
	
	attacking = true
	
	await get_tree().create_timer( 0.08 ).timeout
	hurt_box.monitoring = true
	pass

## what happens when the player exit this StateOld? 
func Exit() -> void:
	animation_player.animation_finished.disconnect( EndAttack )
	attacking = false
	hurt_box.monitoring = false
	pass

## what happens during the _process update in this StateOld?
func  Process(_delta: float) -> StateOld:
	player.velocity -= player.velocity * decelerate_speed * _delta
	
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else: 
			return walk
	return null
	
## what happens during the _physics_process update in this StateOld?
func Physics(delta: float) -> StateOld:
	return null
	
## what happens with _input events in this StateOld?
func HandleInput(_event: InputEvent) -> StateOld:
	return null
	
func EndAttack( _newAnimName : String ) -> void:
	attacking = false
	pass
