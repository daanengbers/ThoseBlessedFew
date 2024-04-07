extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$ButtonAnim.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("spell1"):
		gotoscene()
	if Input.is_action_just_pressed("spell2"):
		gotoscene()
	if Input.is_action_just_pressed("spell3"):
		gotoscene()
	if Input.is_action_just_pressed("spell4"):
		gotoscene()
	

func gotoscene():
	Globalsettings.resetrun()
	get_tree().change_scene_to_file("res://Scenes/mainscene.tscn")
