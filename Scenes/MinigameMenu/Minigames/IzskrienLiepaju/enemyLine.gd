extends Line2D

var pos = []
var lastPlayerPosition=-10

func _ready():
	show()

func _process(delta):
	
	var player_node = get_parent().get_node("Route/hardFollow/enemyHard")
	var player_sprite = player_node.get_node("playerSprite")
	var player_position = player_node.get_parent().offset
	if player_position != lastPlayerPosition and player_position>=lastPlayerPosition+5.0 and player_node.get_parent().moving==true:
		pos.append(player_node.global_position)
		lastPlayerPosition = player_position
		update_line(player_sprite)
		
func update_line(player_sprite):
	clear_points()
	for position in pos:
		add_point(position)
	
