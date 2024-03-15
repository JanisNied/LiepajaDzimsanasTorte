extends Line2D

var pos = []
var lastPlayerPosition

func _ready():
	show()

func _process(delta):
	var player_node = get_parent()
	var player_sprite = player_node.get_node("playerSprite")
	var player_position = player_node.global_position
	if player_position != lastPlayerPosition:
		pos.append(player_position)
		lastPlayerPosition = player_position
		update_line(player_sprite)
		
func update_line(player_sprite):
	clear_points()
	for position in pos:
		var texture_size = player_sprite.texture.get_size()
		var adjusted_position = position - texture_size / 2
		add_point(position)
	
