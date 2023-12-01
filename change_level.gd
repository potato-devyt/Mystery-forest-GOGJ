extends Node3D

var is_near = false
@export var level_name : String = ""
@export var music : Node3D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("e"):
		if is_near == true:
			if Size.size_var == 1:
				#get_tree().change_scene_to_file(level_name)
				$root.anim.queue("fade_out")
				music.stop_music()
				$AudioStreamPlayer.play()
			


func _on_area_3d_body_entered(body):
	if body.has_method("player"):
		is_near = true
		


func _on_area_3d_body_exited(body):
	if body.has_method("player"):
		is_near = false


func _on_animation_player_animation_finished(fade_out):
	get_tree().change_scene_to_file(level_name)
