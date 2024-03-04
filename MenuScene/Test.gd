extends Control

signal mouse_entered_signal
signal mouse_exited_signal

func _ready():
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")
	
func _on_mouse_entered():
	print("Mouse entered!")
	emit_signal("mouse_entered_signal")

func _on_mouse_exited():
	print("Mouse exited!")
	emit_signal("mouse_exited_signal")
