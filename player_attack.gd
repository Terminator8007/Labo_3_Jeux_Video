extends BaseState
class_name PlayerAttack

@export var player : Player
var anim_player : AnimationPlayer


# Called when the node enters the scene tree for the first time.
func enter():
	anim_player = player.get_animation_player()
	
func update(delta: float) -> void:
	if not anim_player :
		anim_player = player.get_animation_player()

func physics_update(delta: float) -> void:
	if not anim_player : return
		
	anim_player.play("attack")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if (anim_name == "attack"):
		Transitioned.emit(self, "Walk")
