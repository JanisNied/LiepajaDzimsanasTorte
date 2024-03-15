extends Node2D


func _ready():
	var line = get_node("Line2D")
	
	var points = line.points
	var intersections = find_intersections(points)
	
	# Show intersections somehow
	for pos in intersections:
		var icon = Sprite.new()
		icon.position = pos
		icon.texture = preload("res://icon.png")
		icon.scale = Vector2(0.5, 0.5)
		line.add_child(icon)
	

func find_intersections(points):
	var intersections = []
	
	# Iterate all segments to see if they intersect another.
	# (Start at 1 because it's easier to iterate pairs of points)
	for i in range(1, len(points)):
		
		# Note: the +1 makes sure we don't get two results per segment pairs
		# (intersection of A into B and intersection of B into A, which are the same anyways)
		for j in range(1 + i, len(points)):
			
			if abs(j - i) < 2:
				# Ignore self and neighbors
				continue
			
			var begin0 = points[i - 1]
			var end0 = points[i]
			
			var begin1 = points[j - 1]
			var end1 = points[j]
			
			# Calculate intersection of the two segments
			var intersection = get_segment_intersection(begin0, end0, begin1, end1)
			if intersection != null:
				intersections.append(intersection)
	
	return intersections
		

static func get_segment_intersection(a, b, c, d):
	# http://paulbourke.net/geometry/pointlineplane/ <-- Good stuff
	var cd = d - c
	var ab = b - a
	var div = cd.y * ab.x - cd.x * ab.y

	if abs(div) > 0.001:
		var ua = (cd.x * (a.y - c.y) - cd.y * (a.x - c.x)) / div
		var ub = (ab.x * (a.y - c.y) - ab.y * (a.x - c.x)) / div
		var intersection = a + ua * ab
		if ua >= 0.0 and ua <= 1.0 and ub >= 0.0 and ub <= 1.0:
			return intersection
		return null

	# Segments are parallel!
	return null
