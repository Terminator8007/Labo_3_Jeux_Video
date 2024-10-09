extends BaseState
class_name PlayerWalk

@export var player : Player
var anim_player : AnimationPlayer

@export var move_speed := 350.0

func manage_input() -> Vector2:	
	if Input.is_action_just_pressed("attack"):
		Transitioned.emit(self, "Attack")
	
	var dir : Vector2 = Vector2(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"), 0).normalized()

	return dir
	

func update(delta : float) -> void:
	if not anim_player :
		anim_player = player.get_animation_player()

	var dir := manage_input()
	
	if dir.length() > 0 :
		player.velocity = dir * move_speed
	else :
		player.velocity = player.velocity.move_toward(Vector2.ZERO, 10)
	
	if (player.velocity.length() == 0) :
		Transitioned.emit(self, "idle")
	
	player.direction = dir

func physics_update(delta: float) -> void:
	
	if (player.velocity.length() > 0) :
		if (player.velocity.x > 0 or player.velocity.x < 0) :
			anim_player.play("walk_side")
			if (player.velocity.x > 0) :
				player.sprite.flip_h = false
			elif (player.velocity.x < 0) :
				player.sprite.flip_h = true
