extends StaticBody2D

var MEEBLING = preload("res://Scenes/crowd_member.tscn")

var alive = true
var spawnedmeebling = false
@export var hp = 20
@export var meeblingscaught = 1

func _ready():
	$Healthbar.max_value = hp

func _process(delta):
	$Healthbar.value = hp

func hurt():
	pass

func spawnmeebling():
	var me = MEEBLING.instantiate()
	get_parent().add_child.call_deferred(me)
	me.position.x = global_position.x + randi()%20 -10
	me.position.y = global_position.y + randi()%20 -10

func kill():
	$Colbox.set_deferred("disabled", true)
	$HURTbox_Enemy/box.set_deferred("disabled", true)
	$Icon.visible = false
	$c2.visible = false
	$c3.visible = false
	if spawnedmeebling == false:
		spawnedmeebling = true
		spawnmeebling()
	remove_from_group("enemy_m")


