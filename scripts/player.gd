extends CharacterBody3D


var SPEED = 5.0
const JUMP_VELOCITY = 4.5
@onready var pivot = $cam_origin
@export var sensitivity = 0.5


var normal_size = Vector3(1,1,1)
var big_size = Vector3(2,2,2)
var small_size = Vector3 (0.5,0.5,0.5)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Size.size_var = 1
	CollectableSize.small_col = 0
	CollectableSize.normal_col = 0
	CollectableSize.big_col = 0
	
	
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * sensitivity))
		pivot.rotate_x(deg_to_rad(-event.relative.y * sensitivity))
		pivot.rotation.x = clamp(pivot.rotation.x, deg_to_rad(-90), deg_to_rad(45))


func _physics_process(delta):
	#print(Size.size_var)
	

		
	
	if Size.size_var == 0:
		SPEED = 10
	if Size.size_var == 1:
		SPEED = 6.5
	if Size.size_var == 2:
		SPEED = 4
	
	
	
	
	#collectable size checks
	if CollectableSize.normal_col >= 1:
		if Input.is_action_just_released("B"):
			if Size.size_var != 1:
				var tween = create_tween()
				tween.tween_property($".", "scale", normal_size,0.5)
				CollectableSize.normal_col -=1
				Size.size_var = 1
				$audio_small.play()
	if CollectableSize.big_col >= 1:
		if Input.is_action_just_released("1"):
			if Size.size_var != 2:
				var tween = create_tween()
				tween.tween_property($".", "scale", big_size,0.5)
				CollectableSize.big_col -=1
				Size.size_var = 2
				$audio_big.play()
	if CollectableSize.small_col >= 1:
		if Input.is_action_just_released("2"):
			if Size.size_var !=0:
				var tween = create_tween()
				tween.tween_property($".", "scale", small_size,0.5)
				CollectableSize.small_col -=1
				Size.size_var = 0
				$audio_small.play()
				#print_debug(CollectableSize.small_col)
	
	
	if Size.size_var == 1:
		var tween = create_tween()
		tween.tween_property($".", "scale", normal_size,0.5)
		
		
	elif Size.size_var == 2:
		var tween = create_tween()
		tween.tween_property($".", "scale", big_size,0.5)
		
		
	elif Size.size_var == 0:
		var tween = create_tween()
		tween.tween_property($".", "scale", small_size,0.5)
		
	
	
	print(CollectableSize.big_col)
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		
		if Size.size_var == 1:
			velocity.y = JUMP_VELOCITY
		if Size.size_var == 0:
			velocity.y = JUMP_VELOCITY/2
		if Size.size_var == 2:
			velocity.y = 15 
		$jump.play()
		
	
		
	if Input.is_action_just_pressed("ui_text_delete"):
		get_tree().quit()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		$AnimationPlayer.play("move")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		$AnimationPlayer.play("idle")
		
	if Input.is_action_just_pressed("left"):
		$Sprite3D.flip_h = true
		
	if Input.is_action_just_pressed("right"):
		$Sprite3D.flip_h = false
		

	move_and_slide()
	
func player():
	pass


func _on_area_3d_body_entered(body):
	if body.has_method("col"):
		$got.play()
