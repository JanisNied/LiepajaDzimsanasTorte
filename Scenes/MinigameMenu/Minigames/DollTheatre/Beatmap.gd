extends Node

var Beatmap = """112
0011
0011
1010
0101
1111
0011
0111
0101
1110
0001
0110
0111
0101
0101
1010
0101
1110
0111
0101
0011
0001""".split("\n")

signal eof()

var length
var currline = 1
var dolls = [0, 0, 0, 0]
var FullCombo = 0

func _ready():
	length = Beatmap.size()
	pass

func getbpm():
	return int(Beatmap[0])

func nextLine():
	if currline < length:
		for i in 4:
			self.dolls[i] = int(Beatmap[currline][i])
			if self.dolls[i] == 1:
				FullCombo += 1
		currline += 1
	else:
		emit_signal("eof")
