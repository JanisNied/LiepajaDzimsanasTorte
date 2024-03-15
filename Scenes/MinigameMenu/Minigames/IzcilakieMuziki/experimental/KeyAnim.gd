extends ColorRect

export(String, "Q", "W", "O", "P") var button

export var open = false

func _ready():
	$Label.text = button
	pass

func play():
	$AnimationPlayer.play("New Anim")
	pass

func _input(event):
	if event.is_action_pressed(button):
		$Border.color = ColorN("gray")
		if $AnimationPlayer.is_playing():
			if $AnimationPlayer.current_animation_position > 0.85 and $AnimationPlayer.current_animation_position < 0.88:
				get_parent().combo += 1
				get_parent().process_note_result("early")
				color = Color(1.65, 0.63, 0.09, 0.82)
			elif $AnimationPlayer.current_animation_position < 1.2 and $AnimationPlayer.current_animation_position > 1.1:
				get_parent().combo += 1
				get_parent().process_note_result("early")
				color = Color(1.65, 0.63, 0.09, 0.82)
			elif open:
				get_parent().combo += 1
				get_parent().process_note_result("correct")
				color = Color(0.51, 2.16, 0.38, 0.61)
			else:
				get_parent().combo = 0
				get_parent().process_note_result("missed")
				color = Color(2.02, 0.31, 0.31, 0.61)	
			$AnimationPlayer.play("RESET")
		pass
	if event.is_action_released(button):
		$Border.color = ColorN("black")
		pass

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "New Anim":
		get_parent().combo = 0
		color = Color(2.02, 0.31, 0.31, 0.61)
	pass # Replace with function body.
