extends Node2D

func _ready():
	SoundManager.play_bgm("heartbreak")
	
func _process(delta):
	Global.time += delta
