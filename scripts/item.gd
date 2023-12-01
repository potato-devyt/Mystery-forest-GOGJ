extends Node3D


var player_near = false
@export var size_change = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(Size.size_var)
	if Input.is_action_pressed("e") and player_near == true:
			Size.size_var = size_change
			if size_change == 0:
				$AudioStreamPlayer_small.play()
			if size_change == 1:
				$AudioStreamPlayer_small.play()
			if size_change == 2:
				$AudioStreamPlayer_big.play()
	
			

	
	



	


func _on_area_3d_body_entered(body):
	if body.has_method("player"):
		player_near = true
		


func _on_area_3d_body_exited(body):
	if body.has_method("player"):
		player_near = false
