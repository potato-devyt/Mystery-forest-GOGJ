extends Node3D

#0 = activate 1 = deactivte
@export var node_type = 0
@export var test : Node3D
@export var collision_ : Node3D
var is_near = false

var wait_sound = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if node_type == 0:
		if is_near == true:
			if Input.is_action_just_pressed("e"):
				test.visible = true
				collision_.disabled = false
				$Sprite3D.flip_h = true
				$AudioStreamPlayer3D.play()
				$Timer.start()
	if node_type == 1:
		if is_near == true:
			if Input.is_action_just_pressed("e"):
				test.visible = false
				collision_.disabled = true
				$Sprite3D.flip_h = true
				$AudioStreamPlayer3D.play()
				$Timer.start()
				
	


func _on_area_3d_body_entered(body):
	if body.has_method("player"):
		is_near = true


func _on_area_3d_body_exited(body):
	if body.has_method("player"):
		is_near = false


func _on_timer_timeout():
	$AudioStreamPlayer_wait.play()
	
