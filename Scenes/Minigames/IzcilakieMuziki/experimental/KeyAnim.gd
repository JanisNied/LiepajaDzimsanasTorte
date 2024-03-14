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
		$Border.color = ColorN("white")
		if $AnimationPlayer.is_playing():
			if $AnimationPlayer.current_animation_position > 0.85 and $AnimationPlayer.current_animation_position < 0.90:
				get_parent().combo += 1
				color = ColorN("orange")
			elif $AnimationPlayer.current_animation_position < 1.2 and $AnimationPlayer.current_animation_position > 1.1:
				get_parent().combo += 1
				color = ColorN("orange")
			elif open:
				get_parent().combo += 1
				color = ColorN("green")
			else:
				get_parent().combo = 0
				color = ColorN("red")		
			$AnimationPlayer.play("RESET")
		pass
	if event.is_action_released(button):
		$Border.color = ColorN("black")
		pass

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "New Anim":
		get_parent().combo = 0
		color = ColorN("red")
	pass # Replace with function body.
