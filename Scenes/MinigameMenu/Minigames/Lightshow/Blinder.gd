extends TextureRect

var playertolookoutfor
var flash = true

func _process(delta):
	if playertolookoutfor.hp < 100 and flash:
		visible = true
	else: 
		visible = false
		

# Called when the node enters the scene tree for the first time.
func _ready():
	playertolookoutfor = get_parent().find_node("Player")
	pass


func _on_Inferface_gameover():
	flash = false
	visible = false
