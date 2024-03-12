extends MeshInstance
		
const file_path : String = "user://leaderboard.json"
var leaderboard = {}

static func sort_desc(a, b):
	return	int(int(a[2]) - (int(a[1]) * 0.1)) > int(int(b[2]) - (int(b[1]) * 0.1))

func _ready():
	import_resources_data()
	leaderboard = sort_dict(leaderboard)
	for key in leaderboard.keys():
		if key <= 10:
			var node = str("Top",key);
			get_node(node).show()
			get_node(node+"/Name").text = str("#", str(key), " ", leaderboard[key][0])
			get_node(node+"/Laiks").text = "%02d:%02d:%02d" % [floor(int(leaderboard[key][1]) / 3600), floor((int(leaderboard[key][1]) % 3600) / 60), int(leaderboard[key][1]) % 60]
			get_node(node+"/Punkti").text = str(leaderboard[key][2])+"pt"
		else:
			break	
	pass 

func import_resources_data():
	var file = File.new()
	file.open("user://leaderboard.", file.READ)
	while !file.eof_reached(): 
		var data_set = Array(file.get_csv_line(";"))
		if data_set.size() == 3:
			leaderboard[leaderboard.size()] = data_set 
	file.close()
	
func write_resources_data(name, timeS, points):
	var file = File.new()
	file.open("user://example.txt", file.READ_WRITE)
	file.seek_end()
	file.store_string("Name;600;399\n")
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
