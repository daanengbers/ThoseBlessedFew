extends Node2D
signal secconds( seccondspassed )

var SKULL = preload("res://Scenes/enemy_member.tscn")
var EYEBALL = preload("res://Scenes/enemy_Eyeball.tscn")

var cycles = 0
var seccondspassed = 0
var biome = 1

var randomenemyspawn = 1
var highesttypeenemy = 2
var highestlevelenemy = 1

var randomspawnlocx = 0
var randomspawnlocy = 0



func _ready():
	randomize()

func spawnskullenemy():
	var sk = SKULL.instantiate()
	get_parent().get_parent().add_child.call_deferred(sk)
	var randomtoporside = randi()%4 + 1
	if randomtoporside == 1:
		sk.position.x = global_position.x + randomspawnlocx
		sk.position.y = global_position.y - 40
	if randomtoporside == 2:
		sk.position.x = global_position.x + randomspawnlocx
		sk.position.y = global_position.y + 220
	if randomtoporside == 3:
		sk.position.x = global_position.x - 40
		sk.position.y = global_position.y + randomspawnlocy
	if randomtoporside == 4:
		sk.position.x = global_position.x + 360
		sk.position.y = global_position.y + randomspawnlocy
	#$Label.set_text(str(randomtoporside))

func spawneyeenemy():
	var sk = EYEBALL.instantiate()
	get_parent().get_parent().add_child.call_deferred(sk)
	var randomtoporside = randi()%4 + 1
	if randomtoporside == 1:
		sk.position.x = global_position.x + randomspawnlocx
		sk.position.y = global_position.y - 40
	if randomtoporside == 2:
		sk.position.x = global_position.x + randomspawnlocx
		sk.position.y = global_position.y + 220
	if randomtoporside == 3:
		sk.position.x = global_position.x - 40
		sk.position.y = global_position.y + randomspawnlocy
	if randomtoporside == 4:
		sk.position.x = global_position.x + 360
		sk.position.y = global_position.y + randomspawnlocy




func _process(delta):
	pass


func _on_spawn_timer_timeout():
	randomenemyspawn = randi()% highesttypeenemy + 1
	if randomenemyspawn ==1:
		spawnskullenemy()
	elif randomenemyspawn == 2:
		spawneyeenemy()
	randomspawnlocx = randi()% 320
	randomspawnlocy = randi()% 180
	$SpawnTimer.start()
	cycles += 1
	if seccondspassed == 10:
		$SpawnTimer.wait_time = 3
	if seccondspassed == 20:
		$SpawnTimer.wait_time = 2.8
	if seccondspassed == 30:
		$SpawnTimer.wait_time = 2.5
	if seccondspassed == 40:
		$SpawnTimer.wait_time = 2.2
	if seccondspassed == 60:
		$SpawnTimer.wait_time = 1.5
	if seccondspassed == 75:
		$SpawnTimer.wait_time = 1.6
	if seccondspassed == 90:
		$SpawnTimer.wait_time = 1.2
	if seccondspassed == 105:
		$SpawnTimer.wait_time = 0.9
	if seccondspassed == 120:
		$SpawnTimer.wait_time = 0.7
	if seccondspassed == 140:
		$SpawnTimer.wait_time = 0.5
	if seccondspassed == 200:
		$SpawnTimer.wait_time = 0.3
	if seccondspassed == 400:
		$SpawnTimer.wait_time = 0.2
	if seccondspassed == 600:
		$SpawnTimer.wait_time = 0.1
	if seccondspassed == 900:
		$SpawnTimer.wait_time = 0.01
	
	print(sqrt(cycles))
	

func _on_seccond_counter_timeout():
	emit_signal("secconds")
	seccondspassed += 1
