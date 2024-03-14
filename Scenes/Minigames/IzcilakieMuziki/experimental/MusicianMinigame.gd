extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var allKeys = [$KeyAnim,$KeyAnim2,$KeyAnim3,$KeyAnim4]
var currentKeys = []
var combo = 0

var busy = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$MidiPlayer.play()
	yield(get_tree().create_timer(1.249), "timeout")
	$AudioStreamPlayer.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func play_random():
	var newKeys = []
	var keyCount = randi()%2 + 1 # one or two keys
	var freeKeys = allKeys.duplicate() 
	for a in currentKeys:
		freeKeys.erase(a) #remove current keys from the list
	while keyCount > 0:
		keyCount -= 1
		newKeys.push_back(freeKeys[randi()%freeKeys.size()])
	currentKeys = newKeys
	for k in newKeys:
		k.play()
	pass

func _on_Timer_timeout():
	$AudioStreamPlayer.play()
	pass # Replace with function body.


func _on_MidiPlayer_midi_event(channel, event):
	if event.type == 128 : #key down
		if busy:
			return
		busy = true
		for N in channel.note_on:
			match N:
				71:
					$KeyAnim.play()
				95:
					$KeyAnim3.play()
				83:
					$KeyAnim2.play()
				59:
					$KeyAnim4.play()
		yield(get_tree().create_timer(0.3),"timeout")
		busy = false
		
		
	print(combo)
	pass # Replace with function body.
