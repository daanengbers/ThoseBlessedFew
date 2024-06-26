extends CharacterBody2D

var BULLETINST = preload("res://Scenes/bullet_fromcrowd.tscn")
var FIREBALL = preload("res://Scenes/bullet_fromcrowd_fireball.tscn")
var THUNDERBOLT = preload("res://Scenes/bullet_fromcrowd_thunderbolt.tscn")

var DEADMEEBLY = preload("res://Scenes/exp_areameebling.tscn")

@onready var m_anim = $Meebling/Anim

const SPEED = 30


var extradamage = 1
var extraspeed = 0

var bulletamount = 1
var MAX_HP = 10 + Globalsettings.currentrun_extrahealth

var hp = 10
var alive = true

# THE NUMBER OF THE SPELL WHICH WILL RESET
var spellnumber = 0

var randomsprite = 0
var randomxplus = 0
var randomyplus = 0
var randomspeedextra = 0
var randomoffsetspace = 0

var max_cooldownframes = 100
var cooldownframes = 100

var crowdparent
var crowdp_pos = Vector2(0,0)
var dist_to_crowdp

# hit enemy variables
var dist_to_enemy
var enemy_members
var nearest_enemy
var withinreach = false
var currentextrabullets = 0

func _ready():
	randomize()
	randomspeedextra = randi()%60
	randomxplus = randi()%80 - 40
	randomyplus = randi()%60 - 30
	randomoffsetspace = randi()%8
	hp = MAX_HP
	m_anim.play("bounce")
	randomsprite = randi()%3
	$Meebling.frame = randomsprite

func _physics_process(delta):
	
	# find near enemies
	enemy_members = get_tree().get_nodes_in_group("enemy_m")
	if enemy_members.size() >= 1:
		nearest_enemy = enemy_members[0]
	for mem in enemy_members:
		if mem.global_position.distance_to(self.global_position) < nearest_enemy.global_position.distance_to(self.global_position):
			nearest_enemy = mem
	
	if enemy_members.size() >= 1:
		$Rot2.look_at(nearest_enemy.global_position)
	
	# find crowd parent
	crowdparent = get_tree().get_nodes_in_group("crowd_p")
	crowdp_pos.x = crowdparent[0].position.x + randomxplus
	crowdp_pos.y = crowdparent[0].position.y + randomyplus
	
	dist_to_crowdp = abs(global_position - crowdp_pos)#crowdparent[0].global_position)
	
	# Spell System -----
	
	# Basic spells
	
	if cooldownframes > 0:
		cooldownframes -= 1
	if cooldownframes == 0:
		currentextrabullets = Globalsettings.currentrun_extrabullets
		spawnbullet()
		cooldownframes = max_cooldownframes - Globalsettings.currentrun_minuscooldown
	
	if Input.is_action_just_pressed("spell1") && crowdparent[0].spell1cooldown <= 0:
		spellnumber = 1
		if Globalsettings.g_spell1 == 0:
			pass
		if Globalsettings.g_spell1 == 1:
			spawnfireball()
			$CooldownstartTimer.start()
		if Globalsettings.g_spell1 == 2:
			spawnthunder()
			$CooldownstartTimer.start()
	
	
	
	if Input.is_action_just_pressed("spell2") && crowdparent[0].spell2cooldown <= 0:
		spellnumber = 2
		if Globalsettings.g_spell2 == 0:
			pass
		if Globalsettings.g_spell2 == 1:
			spawnfireball()
			$CooldownstartTimer.start()
		if Globalsettings.g_spell2 == 2:
			spawnthunder()
			$CooldownstartTimer.start()
	
	
	
	if Input.is_action_just_pressed("spell3") && crowdparent[0].spell3cooldown <= 0:
		spellnumber = 3
		if Globalsettings.g_spell3 == 0:
			pass
		if Globalsettings.g_spell3 == 1:
			spawnfireball()
			$CooldownstartTimer.start()
		if Globalsettings.g_spell3 == 2:
			spawnthunder()
			$CooldownstartTimer.start()
	
	
	
	if Input.is_action_just_pressed("spell4") && crowdparent[0].spell4cooldown <= 0:
		spellnumber = 4
		if Globalsettings.g_spell4 == 0:
			pass
		if Globalsettings.g_spell4 == 1:
			spawnfireball()
			$CooldownstartTimer.start()
		if Globalsettings.g_spell4 == 2:
			spawnthunder()
			$CooldownstartTimer.start()
	
		#spawnbullet()
	
	# Large spells
	
	
	
	$Rot.look_at(crowdp_pos)
	$Healthbar.value = hp
	
	if alive == true:
		if dist_to_crowdp.x > 12 + randomoffsetspace or dist_to_crowdp.y > 12 + randomoffsetspace:
			velocity = Vector2(SPEED + randomspeedextra + Globalsettings.currentrun_extraspeed, 0).rotated($Rot.rotation)
		else:
			velocity.x = 0
			velocity.y = 0
	
	$TestLabel.set_text(str(nearest_enemy))
	
	move_and_slide()

# All Projectiles

func spawnbullet():
	$Shoot.play()
	var bu = BULLETINST.instantiate()
	get_parent().add_child.call_deferred(bu)
	bu.position = global_position
	bu.apply_impulse(Vector2(200, 0).rotated($Rot2.rotation))
	bu.rotation = $Rot2.rotation
	if currentextrabullets > 0:
		$DoubleBulletTimer.start()
		currentextrabullets -= 1

func spawnfireball():
	$Bigspell.play()
	var pr = FIREBALL.instantiate()
	get_parent().add_child.call_deferred(pr)
	pr.position = global_position
	pr.apply_impulse(Vector2(140, 0).rotated($Rot2.rotation))
	pr.rotation = $Rot2.rotation

func spawnthunder():
	$Bigspell.play()
	var pr = THUNDERBOLT.instantiate()
	get_parent().add_child.call_deferred(pr)
	pr.position = global_position
	pr.apply_impulse(Vector2(200, 0).rotated($Rot2.rotation))
	pr.rotation = $Rot2.rotation




func update_hp():
	MAX_HP = MAX_HP + Globalsettings.currentrun_extrahealth
	hp = MAX_HP

func hurt():
	$Hit.play()

func kill():
	spawndeadbody()
	alive = false
	$Break.play()
	queue_free()

func drown():
	velocity.x = 0
	velocity.y = 0
	m_anim.play("drown")
	alive = false
	$SplashTimer.start()
	$Arrowshadow.visible = false
	$Break.play()
	$QueueTimer.start()

func spawndeadbody():
	var dm = DEADMEEBLY.instantiate()
	get_parent().add_child.call_deferred(dm)
	dm.position = global_position

func _on_hur_tbox_crowd_area_entered(area):
	if area.is_in_group("EXPorb"):
		$EXPpickup.play()
		Globalsettings.global_xp += area.expamount
		area.queue_free()
	if area.is_in_group("Drownwater"):
		drown()


func _on_double_bullet_timer_timeout():
	spawnbullet()


func _on_cooldownstart_timer_timeout():
	if spellnumber == 1:
		crowdparent[0].spell1cooldown = 100
	if spellnumber == 2:
		crowdparent[0].spell2cooldown = 100
	if spellnumber == 3:
		crowdparent[0].spell3cooldown = 100
	if spellnumber == 4:
		crowdparent[0].spell4cooldown = 100



func _on_queue_timer_timeout():
	queue_free()


func _on_splash_timer_timeout():
	$Splash.play()
