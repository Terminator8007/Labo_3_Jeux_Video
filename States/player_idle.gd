extends BaseState
class_name PlayerIdle

@export var player : Player
var anim_player : AnimationPlayer

func manage_input() -> void:	
	var dir : Vector2 = Vector2(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"), 0).normalized()
	
	if (dir.length() > 0):
		Transitioned.emit(self, "Walk")
	
	if Input.is_action_just_pressed("attack"):
		Transitioned.emit(self, "Attack")

func enter():
	anim_player = player.get_animation_player()
	
func update(delta: float) -> void:
	if not anim_player :
		anim_player = player.get_animation_player()
	manage_input()
	
func physics_update(delta: float) -> void:
	if not anim_player : return
		
	anim_player.play("idle")
