extends Node3D

#0 is small 
#1 is normal 
#3 is big
@export var size_for_collectable = 0
var got = false


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("col")
	print(get_groups())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func col ():
	pass

func _on_area_3d_body_entered(body):
	if body.has_method("player"):
		if got == false:
			$AudioStreamPlayer.play()
			got = true
			print('test')
			if size_for_collectable == 0:
				CollectableSize.small_col +=1
				#print(CollectableSize.small_col)
				$Timer.start()
			if size_for_collectable == 1:
				CollectableSize.normal_col +=1
				$Timer.start()
				#print(CollectableSize.normal_col)
			if size_for_collectable == 2:
				CollectableSize.big_col +=1
				$Timer.start()
				#print(CollectableSize.big_col)
			
		
	


func _on_timer_timeout():
	queue_free()
