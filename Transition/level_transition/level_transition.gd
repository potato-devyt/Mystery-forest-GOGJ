extends Node3D

@export var current_level : int = 1;
@onready var debug_label = $CanvasLayer/Label
@onready var anim = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	debug_label.text = str(current_level)

func _input(event):
	pass
	#if event.is_action_pressed("ui_accept"):
		#change_level()

func change_level():
	transition()
	current_level+=1
	debug_label.text = str(current_level)
	

func transition():
	if(current_level%2 == 0):
		anim.queue("fade_in")
	if(current_level%2 == 1):
		anim.queue("fade_out")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
