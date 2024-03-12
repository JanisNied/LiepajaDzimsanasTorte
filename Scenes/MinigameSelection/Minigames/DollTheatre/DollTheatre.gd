extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	SoundManager.stop("sunMenuMusic")
	$Orchestra.start_play(4, $Beatmap.getbpm())
	#SoundManager.play_bgm("dollBeatmapSong")
	#$Orchestra.begin_orchestra(4, 120)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
