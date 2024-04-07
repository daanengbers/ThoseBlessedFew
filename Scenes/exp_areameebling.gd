extends Area2D

@export var expamount = 20

func _ready():
	$Sprite/Anim.play("play")
	

func _process(delta):
	pass


func _on_timer_timeout():
	$box.set_deferred("disabled", false)
