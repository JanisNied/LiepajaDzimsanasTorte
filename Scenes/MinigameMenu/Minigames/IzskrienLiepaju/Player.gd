extends KinematicBody

onready var head = $Head
onready var head_x = $Head/HeadXRotation
onready var flashlight = $Flashlight
onready var flashlight_light = $Flashlight/FlashLightMesh/SpotLight
onready var flashlight_sound = $Flashlight/FlashLightMesh/FlashlightSound
onready var anim_tree = $Head/HeadXRotation/Camera/AnimationTree

onready var pda = $Flashlight2

var points : int = 0

var reporting = false
var trackpda = false
var start_time: int 
var pda1 = true
var maxAnomalies = 6
onready var timer : Timer= get_parent().get_node("Timer")
var selected : int = 1
var flashlightenabled = true
var sensitivity = -0.1
var anim_blend = 0
var movement = true
const SPEED = 0.7
const FLASHLIGHT_FOLLOW_SPEED = 15.0
const ANIM_SMOOTHING_SPEED = 8.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	flashlightenabled = false
	movement = false
	pda1 = false
	flashlight_light.visible = false
	pda.visible = false

func _input(event):
	if event is InputEventMouseMotion and movement:
		head.rotation_degrees.y += sensitivity * event.relative.x
		head_x.rotation_degrees.x += sensitivity * event.relative.y
		head_x.rotation_degrees.x = clamp(head_x.rotation_degrees.x, -89, 89)
		
	if event is InputEventKey:
		if event.scancode == KEY_F and event.pressed and flashlightenabled:
			flashlight_light.visible = !flashlight_light.visible
			flashlight_sound.play()
		if event.scancode == KEY_ESCAPE and event.pressed:
			endgame()
		if event.scancode == KEY_Q and event.pressed and pda1:
			trackpda = !trackpda
			if trackpda:
				pda.visible = true
			else:
				pda.visible = false
		if not reporting and trackpda:		
			if event.scancode == KEY_DOWN and event.pressed:
				get_node("Flashlight2/pda/Anomaly"+str(selected)).outline_modulate = Color(0.44, 1, 0.66, 0)
				selected += 1
				if selected > maxAnomalies:
					selected = 1
				get_node("Flashlight2/pda/Anomaly"+str(selected)).outline_modulate = Color(0.44, 1, 0.66, 0.16)
				SoundManager.play_se("godown")
			if event.scancode == KEY_UP and event.pressed:
				get_node("Flashlight2/pda/Anomaly"+str(selected)).outline_modulate = Color(0.44, 1, 0.66, 0)
				selected -= 1
				if selected < 1:
					selected = maxAnomalies
				get_node("Flashlight2/pda/Anomaly"+str(selected)).outline_modulate = Color(0.44, 1, 0.66, 0.16)	
				SoundManager.play_se("goup")
			if event.scancode == KEY_SPACE and event.pressed:
				reportingSequence()
				reporting = true
				SoundManager.play_se("clickclick")		
			
func _process(delta):
	if movement:
		make_flashlight_follow(delta)
		
		var head_basis = head.get_global_transform().basis
		if trackpda:
			pda.rotation.y = lerp(pda.rotation.y, head.rotation.y, delta * FLASHLIGHT_FOLLOW_SPEED)
			pda.rotation.x = lerp(pda.rotation.x, head_x.rotation.x, delta * FLASHLIGHT_FOLLOW_SPEED)
		
		var direction = Vector3.ZERO
		
		if Input.is_action_pressed("movefor"):
			direction -= head_basis.z
		elif Input.is_action_pressed("moveback"):
			direction += head_basis.z
		if Input.is_action_pressed("moveleft"):
			direction -= head_basis.x
		elif Input.is_action_pressed("moveright"):
			direction += head_basis.x
			
		direction = direction.normalized()
		move_and_slide(direction * SPEED * anim_blend)
		
		anim_blend = lerp(anim_blend, direction.length(), delta * ANIM_SMOOTHING_SPEED)
		anim_tree.set("parameters/blend_position", anim_blend)
		
func reportingSequence():
	for i in range(maxAnomalies):
		get_node("Flashlight2/pda/Anomaly"+str(i+1)).outline_modulate = Color(1, 0.44, 0.44, 0.38)	
	$Flashlight2/pda/AnomalyReporting.show()
	yield(get_tree().create_timer(5), "timeout")
	pickareport()
	
func make_flashlight_follow(delta):
	flashlight.rotation.y = lerp(flashlight.rotation.y, head.rotation.y, delta * FLASHLIGHT_FOLLOW_SPEED)
	flashlight.rotation.x = lerp(flashlight.rotation.x, head_x.rotation.x, delta * FLASHLIGHT_FOLLOW_SPEED)

func pickareport():
	$Flashlight2/pda/AnomalyReporting.hide()
	match selected:
		5:
			if get_parent().get_node("Events/Intruders").globalintruder == true:
				get_parent().get_node("Events/Intruders").globalintruder = false
				get_parent().get_node("Events/Intruders").hideallintruders()
				correct()
			else:
				incorrect()
		_:
			incorrect()		
	reseteverything()
					
func reseteverything():
	yield(get_tree().create_timer(5), "timeout")
	for i in range(maxAnomalies):
		get_node("Flashlight2/pda/Anomaly"+str(i+1)).outline_modulate = Color(0.44, 1, 0.66, 0)
	get_node("Flashlight2/pda/Anomaly"+str(selected)).outline_modulate = Color(0.44, 1, 0.66, 0.16)		
	$Flashlight2/pda/AnomalyReportingContain.hide()
	$Flashlight2/pda/AnomalyReportingContainFailed.hide()
	reporting = false
	$Flashlight2/pda/Points.text = str(points)+"pt."

func endgame():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	Global.score += points
	
	Global.earnedPoints[Global.discardedActivityNum[Global.discardedActivityNum.size()-1]-1] += points
	
	if points <= 0:
		if not Global.discardedActivityNum[Global.discardedActivityNum.size()-1] in Global.retryMinigameNums:
			Global.retryMinigameNums.append(Global.discardedActivityNum[Global.discardedActivityNum.size()-1])
			Global.allowedActivities.append(Global.discardedActivityNum[Global.discardedActivityNum.size()-1])		
			Global.chosenActivities.append(Global.discardedActivities[Global.discardedActivities.size()-1])
		
			Global.discardedActivityNum.erase(Global.discardedActivityNum[Global.discardedActivityNum.size()-1])
			Global.discardedActivities.erase(Global.discardedActivities[Global.discardedActivities.size()-1])
			Global.sortActivities()
			Global.slicesEaten -= 1
	Global.transition("MinigameMenu")		

func correct():
	$Flashlight2/pda/AnomalyReportingContain.show()
	print("anomaly caught")
	points += 2
	SoundManager.play_se("correctan")
	$Flashlight2/pda/Points.text = str(points)+"pt."

func incorrect():
	$Flashlight2/pda/AnomalyReportingContainFailed.show()
	print("sorry!")
	points -= 3	
	SoundManager.play_se("incorrectan")
	$Flashlight2/pda/Points.text = str(points)+"pt."
