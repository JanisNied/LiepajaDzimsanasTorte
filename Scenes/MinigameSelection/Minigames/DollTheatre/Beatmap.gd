extends Node

var Beatmap = """120
1000
0110
0011
1111
0001""".split("\n")

signal eof()

var length
var currline = 1
var dolls = [0, 0, 0, 0]

func _ready():
	length = Beatmap.size()
	pass

func getbpm():
	return Beatmap[0]

func nextLine():
	if currline < length:
		for i in 4:
			dolls[i] = int(Beatmap[currline][i])
		currline += 1
	else:
		emit_signal("eof")