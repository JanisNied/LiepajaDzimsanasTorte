extends MeshInstance
		
const file_path : String = "user://leaderboard.data"
var leaderboard = {}
var secondhalf = false

static func sort_desc(a, b):
	return	int(int(a[2]) - (int(a[1]) * 0.1)) > int(int(b[2]) - (int(b[1]) * 0.1))

func _ready():
	var temp = File.new()
	if not temp.file_exists(file_path):
		print("[LEADERBOARD] A file has been created.")
		makeFile()
	import_resources_data()
	leaderboard = sort_dict(leaderboard)
	if not leaderboard.empty():
		$None.hide()
		importData()
	if leaderboard.size() >= 7:
		$Arrow.show()					
	pass
	 
func importData():
	for key in leaderboard.keys():
		if key <= 10:
			var node = str("Top",key);
			get_node(node).show()
			get_node(node+"/Name").text = str("#", str(key), " ", leaderboard[key][0])
			get_node(node+"/Laiks").text = "%02d:%02d:%02d" % [floor(int(leaderboard[key][1]) / 3600), floor((int(leaderboard[key][1]) % 3600) / 60), int(leaderboard[key][1]) % 60]
			get_node(node+"/Punkti").text = str(leaderboard[key][2])+"pt"
		else:
			break
			
func import_resources_data():
	var file = File.new()
	file.open(file_path, file.READ)
	while !file.eof_reached(): 
		var data_set = Array(file.get_csv_line(";"))
		if data_set.size() == 3:
			leaderboard[leaderboard.size()] = data_set 
	file.close()
	
func makeFile():
	var file = File.new()
	file.open(file_path, file.WRITE)
	file.seek_end()
	file.store_string("")
	file.close()

func sort_dict(dictionary):
	var items = []
	for key in dictionary.keys():
		items.append(dictionary[key])
	items.sort_custom(self, "sort_desc")
	var sorted_dictionary = {}
	var placements = 1
	for item in items:
		sorted_dictionary[placements] = item
		placements += 1
	return sorted_dictionary	


func _on_Area2_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if not secondhalf:
				secondhalf = true
				$AnimationPlayer.play("ToTop78910")
				$Arrow.text = "<"
			else:
				secondhalf = false
				$AnimationPlayer.seek(0.5, true)
				$AnimationPlayer.play_backwards("ToTop78910")
				$Arrow.text = ">"	
	pass # Replace with function body.


func _on_Area2_mouse_entered():
	$Arrow.modulate = Color(0.13, 1.0, 0.33)
	pass # Replace with function body.


func _on_Area2_mouse_exited():
	$Arrow.modulate = Color(0.99, 0.85, 0.41)
	pass # Replace with function body.


func _on_Area3_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			get_parent().get_node("Camera/CameraAnim").play("FromPDA")
	pass # Replace with function body.


func _on_Area3_mouse_entered():
	$Exit.modulate = Color(0.92, 0.12, 0.12)
	pass # Replace with function body.


func _on_Area3_mouse_exited():
	$Exit.modulate = Color(0,0,0)
	pass # Replace with function body.
