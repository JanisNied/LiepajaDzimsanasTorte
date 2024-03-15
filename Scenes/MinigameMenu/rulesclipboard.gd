extends ColorRect


var selected = preload("res://Assets/selectedclipboard.png")
var normal = preload("res://Assets/clipboard.png")



func _on_Button_mouse_entered():
	$RichTextLabel.bbcode_text = "[center][center][color=purple]<- Noteikumi"
	$Clipboard.texture = selected
	pass # Replace with function body.


func _on_Button_mouse_exited():
	$RichTextLabel.bbcode_text = "[center][center]<- Noteikumi"
	$Clipboard.texture = normal
	pass # Replace with function body.


func _on_Button_button_up():
	get_parent().get_node("Rules/AnimationPlayer").play("GoIn")
	pass # Replace with function body.
