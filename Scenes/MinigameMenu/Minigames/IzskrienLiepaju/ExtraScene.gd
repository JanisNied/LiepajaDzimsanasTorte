extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.izskrienUzvara:
		$Win.show()
		SoundManager.play_se("victorySound")
		$Confetti.show()
		$Latvliep.show()
	else:
		SoundManager.play_se("loss")
		$Lose.show()
	$Punkti.bbcode_text = "[center][center][wave][wave amp = 1]Saņemti Punkti: "+str(Global.izskrienPunkti)+"pt[/wave]"	
	$Punkti.show()	
	yield(get_tree().create_timer(5), "timeout")
	Global.transition("MinigameMenu")
	pass # Replace with function body.


