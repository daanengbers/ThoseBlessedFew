extends Node

var globalmusic = 1

var global_xp = 0
var highscore_xp = 0

var currentrun_extraattack = 0
var currentrun_extraspeed = 0
var currentrun_minuscooldown = 85
var currentrun_extrabullets = 0
var currentrun_extrahealth = 0

var g_spell1 = 0
var g_spell2 = 0
var g_spell3 = 0
var g_spell4 = 0

func _ready():
	pass

func _process(delta):
	
	
	
	if globalmusic == 1:
		if $Normalmusic.playing == false:
			$Normalmusic.play()
	if globalmusic == 2:
		if $Bossmusic.playing == false:
			$Bossmusic.play()

func setmusic():
	$Normalmusic.stop()
	$Bossmusic.stop()


func resetrun():
	global_xp = 0
	currentrun_extraattack = 0
	currentrun_extraspeed = 0
	currentrun_minuscooldown = 0
	currentrun_extrabullets = 0
	currentrun_extrahealth = 0
	g_spell1 = 0
	g_spell2 = 0
	g_spell3 = 0
	g_spell4 = 0
	
