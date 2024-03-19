extends Node2D


var img : Array = ["res://Assets/rozulaukums.jpg"]
var used : Array 

# Called when the node enters the scene tree for the first time.
func _ready():
	var path = img[randi() % img.size()]
	var image = Image.new()
	var err = image.load(path)
	if err != OK:
		print("[PUZZLE] image failed to load..")
		return
	var texture = ImageTexture.new()
	texture.create_from_image(image, 0)
	$Control/GameView/Board.update_background_texture(texture)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
