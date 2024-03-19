extends Sprite

func _on_ColorRect_mouse_entered():
	if get_parent().anim:
		get_parent().get_node("Arrow").bbcode_text = "[color=purple][wave][center]<"
	else:
		get_parent().get_node("Arrow").bbcode_text = "[color=purple][wave][center]>"
	pass # Replace with function body.


func _on_ColorRect_mouse_exited():
	if get_parent().anim:	
		get_parent().get_node("Arrow").bbcode_text = "[color=black][wave][center]<"
	else:
		get_parent().get_node("Arrow").bbcode_text = "[color=black][wave][center]>"	
	pass # Replace with function body.


func _on_abl2_mouse_entered():
	$abl2.bbcode_text = "[color=purple][center]Izdzēst vienu"
	pass # Replace with function body.


func _on_abl1_mouse_entered():
	$abl1.bbcode_text = "[color=purple][center]Izdzēst pusi"
	pass # Replace with function body.


func _on_abl2_mouse_exited():
	$abl2.bbcode_text = "[color=black][center]Izdzēst vienu"
	pass # Replace with function body.


func _on_abl4_mouse_entered():
	$abl4.bbcode_text = "[color=purple][center]Izvēlet atbildi nejauši"
	pass # Replace with function body.


func _on_abl4_mouse_exited():
	$abl4.bbcode_text = "[color=black][center]Izvēlet atbildi nejauši"
	pass # Replace with function body.


func _on_abl3_mouse_exited():
	$abl3.bbcode_text = "[color=black][center]x2 punkti"
	pass # Replace with function body.


func _on_abl3_mouse_entered():
	$abl3.bbcode_text = "[color=purple][center]x2 punkti"
	pass # Replace with function body.


func _on_abl1_mouse_exited():
	$abl1.bbcode_text = "[color=black][center]Izdzēst pusi"
	pass # Replace with function body.


func _on_abl8_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			var nodesToDelete : Array = []
			$abl8.queue_free()
			$abl1.bbcode_text = "[color=red][center][tornado]Izdzēst pusi"
			for i in range(2):
				var r = randi() %4+1
				while str(r)==str(int(get_parent().correctOption)+1) or get_parent().get_node("b"+str(r)).is_visible()==false or str(r) in nodesToDelete:
					r=randi()%4+1
				nodesToDelete.append(str(r))
			print(nodesToDelete)
			SoundManager.play_se("explode")	
			get_parent().get_node("b1").disabled = true
			get_parent().get_node("b2").disabled = true
			get_parent().get_node("b3").disabled = true
			get_parent().get_node("b4").disabled = true
			get_parent().get_node("b"+nodesToDelete[0]+"/ViewportContainer").show()
			get_parent().get_node("b"+nodesToDelete[1]+"/ViewportContainer").show()	
			get_parent().get_node("b"+nodesToDelete[0]+"/ViewportContainer/Viewport/Spatial/Explosion1").emitting = true		
			yield(get_tree().create_timer(0.8), "timeout")
			get_parent().get_node("b"+nodesToDelete[0]+"/ViewportContainer").hide()
			get_parent().get_node("b"+nodesToDelete[1]+"/ViewportContainer").hide()	
			get_parent().get_node("b"+nodesToDelete[0]).hide()
			get_parent().get_node("b"+nodesToDelete[1]).hide()	
			get_parent().get_node("b1").disabled = false
			get_parent().get_node("b2").disabled = false
			get_parent().get_node("b3").disabled = false
			get_parent().get_node("b4").disabled = false
	pass # Replace with function body.


func _on_abl7_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			$abl7.queue_free()
			$abl2.bbcode_text = "[color=red][center][tornado]Izdzēst vienu"
			var r = randi() %4+1
			while str(r)==str(int(get_parent().correctOption)+1) or get_parent().get_node("b"+str(r)).is_visible()==false:
				r=randi()%4+1
			SoundManager.play_se("explode")		
			get_parent().get_node("b1").disabled = true
			get_parent().get_node("b2").disabled = true
			get_parent().get_node("b3").disabled = true
			get_parent().get_node("b4").disabled = true
			get_parent().get_node("b"+str(r)+"/ViewportContainer").show()
			get_parent().get_node("b"+str(r)+"/ViewportContainer/Viewport/Spatial/Explosion1").emitting = true	
			yield(get_tree().create_timer(0.8), "timeout")
			get_parent().get_node("b"+str(r)+"/ViewportContainer").hide()
			get_parent().get_node("b"+str(r)).hide()
			get_parent().get_node("b1").disabled = false
			get_parent().get_node("b2").disabled = false
			get_parent().get_node("b3").disabled = false
			get_parent().get_node("b4").disabled = false
	pass # Replace with function body.


func _on_abl6_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			$abl6.queue_free()
			$abl3.bbcode_text = "[color=red][center][tornado]x2 punkti"
			get_parent().doubleOrNothing=true
	pass # Replace with function body.


func _on_abl5_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if get_parent().questionNum <= 9:
				get_parent().check_answer(randi()%4)
	pass # Replace with function body.
