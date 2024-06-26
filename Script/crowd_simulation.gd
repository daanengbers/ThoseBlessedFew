extends CharacterBody2D

const SPEED = 80

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var spell1ability = 0
var spell2ability = 0
var spell3ability = 0
var spell4ability = 0

var spell1cooldown = 0
var spell2cooldown = 0
var spell3cooldown = 0
var spell4cooldown = 0

var cooldownspeed = .2

var xp = Globalsettings.global_xp
var level = 1
var xpuntilnextlvl = 5

var secconds = 0

var crowdm

var gameover = false

func _ready():
	$Mainarrow/Anim.play("default")
	$UI/SelectLevelupscreen/Blackrect/buttonstopress.play("default")

func _physics_process(delta):
	
	crowdm = get_tree().get_nodes_in_group("crowd_m")
	if crowdm.size() <= 1:
		if gameover == false:
			$MenuTimer.start()
		gameover = true
		velocity.x = 0
		velocity.y = 0
		$UI/Deathscreen.visible = true
	
	# controls
	
	if gameover == false:
		if Input.is_action_pressed("left"):
			velocity.x = -SPEED - Globalsettings.currentrun_extraspeed
		elif Input.is_action_pressed("right"):
			velocity.x = SPEED + Globalsettings.currentrun_extraspeed
		else:
			velocity.x = 0
		
		if Input.is_action_pressed("up"):# && position.y > 20:
			velocity.y = -SPEED - Globalsettings.currentrun_extraspeed
		elif Input.is_action_pressed("down"):# && position.y < 160:
			velocity.y = SPEED + Globalsettings.currentrun_extraspeed
		else:
			velocity.y = 0
	
	# EXP system
	
	$UI/LVLbar.value = Globalsettings.global_xp
	$UI/LVLtext.set_text("Level: " + str(level))
	if Globalsettings.global_xp >= xpuntilnextlvl:
		level_up()
	
	# Spell cooldown system
	if spell1cooldown > 0:
		spell1cooldown -= cooldownspeed
	if spell2cooldown > 0:
		spell2cooldown -= cooldownspeed
	if spell3cooldown > 0:
		spell3cooldown -= cooldownspeed
	if spell4cooldown > 0:
		spell4cooldown -= cooldownspeed
	$UI/Box01/CDB.value = spell1cooldown
	$UI/Box02/CDB.value = spell2cooldown
	$UI/Box03/CDB.value = spell3cooldown
	$UI/Box04/CDB.value = spell4cooldown
	
	
	# Stat showcase system
	$UI/Text_ATKlvl.set_text(str(1 + Globalsettings.currentrun_extraattack))
	$UI/Text_SPDlvl.set_text(str(30 + Globalsettings.currentrun_extraspeed))
	$UI/Text_CDNlvl.set_text(str(-0 + Globalsettings.currentrun_minuscooldown))
	$UI/Text_AMTlvl.set_text(str(1 + Globalsettings.currentrun_extrabullets))
	$UI/Text_HPlvl.set_text(str(10 + Globalsettings.currentrun_extrahealth))
	
	
	#$UI/Spellicon_01/Cooldown.value = spell1cooldown
	
	#velocity.x = SPEED
	
	move_and_slide()

func displayupgrades():
	if Globalsettings.g_spell1 != 0:
		$UI/Box01/UpgradeIcons.frame = Globalsettings.g_spell1 + 4
	if Globalsettings.g_spell2 != 0:
		$UI/Box02/UpgradeIcons.frame = Globalsettings.g_spell2 + 4
	if Globalsettings.g_spell3 != 0:
		$UI/Box03/UpgradeIcons.frame = Globalsettings.g_spell3 + 4
	if Globalsettings.g_spell4 != 0:
		$UI/Box04/UpgradeIcons.frame = Globalsettings.g_spell4 + 4

func level_up():
	level += 1
	Globalsettings.global_xp -= xpuntilnextlvl
	
	$LVLup.play()
	
	xpuntilnextlvl += 2
	$UI/LVLbar.max_value = xpuntilnextlvl
	$UI/LVLbar.value = Globalsettings.global_xp
	$UI/LVLtext.set_text("Level: " + str(level))
	
	$UI/SelectLevelupscreen.spawncards(90)
	$UI/SelectLevelupscreen.spawncards(160)
	$UI/SelectLevelupscreen.spawncards(230)
	
	$UI/SelectLevelupscreen.visible = true
	$UI/SelectLevelupscreen.inmenu = true
	$UI/SelectLevelupscreen.pressed = false
	get_tree().paused = true
	
func _on_game_timer_timeout():
	secconds += 1
	$UI/GameTimerUI.set_text(str(secconds))



func _on_menu_timer_timeout():
	get_tree().change_scene_to_file("res://Scenes/titlescreen.tscn")
