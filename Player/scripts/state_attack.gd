class_name StateAttack extends State

var attacking : bool = false

@export var attack_sound : AudioStream
@export_range(1, 20, 0.5) var decelerate_speed : float = 10.0

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var attack_effect_anim_player: AnimationPlayer = $"../../Sprite2D/AttackEffectSprite/AnimationPlayer"
@onready var audio: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"

@onready var walk: State = $"../Walk"
@onready var idle: State = $"../Idle"

@onready var hit_box: HitBox = %AttackHitBox

## what happens when the player enter this state? 
func enter() -> void:
	character.update_animation("attack")
	attack_effect_anim_player.play("attack" + "_" + character.get_animation_direction())
	animation_player.animation_finished.connect( end_attack )
	
	audio.stream = attack_sound
	audio.pitch_scale = randf_range(0.8, 1.1)
	audio.play()
	
	attacking = true
	
	await get_tree().create_timer( 0.08 ).timeout
	hit_box.monitoring = true
	pass

## what happens when the player exit this state? 
func exit() -> void:
	animation_player.animation_finished.disconnect( end_attack )
	hit_box.monitoring = false
	attacking = false
	
	pass

## what happens during the _process update in this state?
func  process(_delta: float) -> State:
	character.velocity -= character.velocity * decelerate_speed * _delta
	
	if attacking == false:
		if character.direction == Vector2.ZERO:
			return idle
		else: 
			return walk
	return null

	
func end_attack( _newAnimName : String ) -> void:
	attacking = false
	pass
