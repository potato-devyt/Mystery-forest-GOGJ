extends Node3D

var wait = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _wait_sound_play():
	if wait == true:
		$AudioStreamPlayer.play()


func _on_timer_timeout():
	pass # Replace with function body.
