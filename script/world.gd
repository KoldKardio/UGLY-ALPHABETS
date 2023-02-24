extends Node

onready var node = get_tree().get_nodes_in_group("letter")
onready var area = get_tree().get_nodes_in_group("area")
onready var init_pos = get_tree().get_nodes_in_group("init_pos")

onready var grid = $GridContainer
onready var drag = $dragable
onready var failed = $failed
onready var success = $success
onready var points = $scoreboard/points
onready var uwin = $WIN

#var newScore
var rng = RandomNumberGenerator.new()
var current
var lnum = Array() 
const loc = Array()
var score = Array()
var oldData = Array()
const resetScr = Array()
var boxLeft = 5

var alphabets = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
var dragItem = Array()
var gridItem = Array()
var lostItem = Array()

func _ready():
	# disable some grids
	for i in area.size():
		area[i].get_child(0).disabled = true
	
	# loop all gridItems in an array
	for items in grid.get_children():
		gridItem.append(items)
#	print(gridItem)
	
	# loop all dragItems in an array
	for items in drag.get_children():
		dragItem.append(items)
	
#	print(gridItem[1].get_child(0))
	
	# replace the letters in grid
	for letter in alphabets.size():
		gridItem[letter].get_child(0).text = alphabets[letter]
	
	getLostLetter()
	#print(lostItem)
	
	# replacing lostitems to drags
	replaceDrags(node)
	replaceGridItem()
	
	# print(oldData)
	# print(gridItem[3].get_child(0).text)
	
	areaBoxCheck()
	
	nodeKoPos()
	
	pass

func _physics_process(_delta):
	current = xtr.selectData
#	print (current)

func getLostLetter():
	rng.randomize()
	for i in 5:
		var n = rng.randi_range(0, 25)
		lnum.append(n)
	# repeatition is a bug which has been turned into feature
#	print (lnum)
	
	for num in lnum.size():
		match lnum[num]:
			0:
				lostItem.append(alphabets[0])
				#print(lostItem)
				#print("zero")
			1:
				#print("one")
				lostItem.append(alphabets[1])
				#print(lostItem)
			2:
				#print("two")
				lostItem.append(alphabets[2])
				#print(lostItem)
			3:
				#print("three")
				lostItem.append(alphabets[3])
				#print(lostItem)
			4:
				#print("four")
				lostItem.append(alphabets[4])
				#print(lostItem)
			5:
				#print("five")
				lostItem.append(alphabets[5])
				#print(lostItem)
			6:
				#print("six")
				lostItem.append(alphabets[6])
				#print(lostItem)
			7:
				#print("seven")
				lostItem.append(alphabets[7])
				#print(lostItem)
			8:
				lostItem.append(alphabets[8])
			9:
				lostItem.append(alphabets[9])
			10:
				lostItem.append(alphabets[10])
			11:
				lostItem.append(alphabets[11])
			12:
				lostItem.append(alphabets[12])
			13:
				lostItem.append(alphabets[13])
			14:
				lostItem.append(alphabets[14])
			15:
				lostItem.append(alphabets[15])
			16:
				lostItem.append(alphabets[16])
			17:
				lostItem.append(alphabets[17])
			18:
				lostItem.append(alphabets[18])
			19:
				lostItem.append(alphabets[19])
			20:
				lostItem.append(alphabets[20])
			21:
				lostItem.append(alphabets[21])
			22:
				lostItem.append(alphabets[22])
			23:
				lostItem.append(alphabets[23])
			24:
				lostItem.append(alphabets[24])
			25:
				lostItem.append(alphabets[25])

func replaceDrags(drags):
	#print (drag[0].get_child(0).get_child(0).text)
	
	for i in drags.size():
		drags[i].get_child(0).get_child(0).text = lostItem[i]
		dragItem[i].get_child(1).text = lostItem[i]
		pass
	pass

func replaceGridItem():
	# print (gridItem[5].get_child(0).text)
	
	for items in gridItem.size():
		for i in lostItem.size():
			if gridItem[items].get_child(0).text == lostItem[i]:
				# print("helo")
				oldData.append(gridItem[items].get_child(0).text)
				gridItem[items].get_child(0).visible = false
		pass
	pass

func areaBoxCheck():
	
	# open areabox
	for item in gridItem.size():
		var nue = item
		for xx in lostItem.size():
			if gridItem[item].get_child(0).text == lostItem[xx]:
				#print(lostItem[xx])
				area[nue].get_child(0).disabled = false
				score.append(area[nue])
				resetScr.append(area[nue])
				pass
			pass
		
#	print(resetScr)
	#check areabox
	
	pass

func nodeKoPos():
#	print(init_pos[0].position)
	for pos in init_pos.size():
		loc.append(init_pos[pos].transform)
#	print(loc)
	pass



func defPos():
	#print (loc[0])
	failed.visible = true
	boxLeft = 5
	if failed.visible:
		var scr = int(str(points.text))
		scr = 0
		points.text = str(scr)
	
	print(boxLeft)
	yield(get_tree().create_timer(1), "timeout")
	failed.visible = false
	for i in 5:
		init_pos[i].transform = loc[i]
	
	pass

func popSuccess():
	
	success.visible = true
	if success.visible:
		var scr = int(str(points.text))
		scr += 1
		points.text = str(scr)
		
		boxLeft -= 1
		if boxLeft == 0:
			uwin.visible = true
			$WIN/scoreLbl.text = str("Your score: ", scr) 
		
		
	yield(get_tree().create_timer(0.8), "timeout")
	success.visible = false

func win():
	print("all box filled")

func _on_Button_pressed():
	get_tree().reload_current_scene()
	pass # Replace with function body.


func _on_Area2D_area_entered_textA(area):
	if node and current == alphabets[0]:
		print ("hello, its A")
		popSuccess()
	else:
		defPos()
		print ("wrong one")
	pass # Replace with function body.

func _on_Area2D_area_entered_textB(area):
	if node and current == alphabets[1]:
		print ("hello, its B")
		popSuccess()
		
	else:
		defPos()
		print ("wrong one")
	pass # Replace with function body.

func _on_Area2D_area_entered_textC(area):
	if node and current == alphabets[2]:
		print ("hello, its C")
		popSuccess()
	else:
		defPos()
		print ("wrong one")
	pass # Replace with function body.


func _on_Area2D_area_entered_textD(area):
	if node and current == alphabets[3]:
		popSuccess()
		print ("hello, its D")
	else:
		defPos()
		print ("wrong one")
	pass # Replace with function body.

func _on_Area2D_area_entered_textE(area):
	if node and current == alphabets[4]:
		popSuccess()
		print ("hello, its E")
	else:
		defPos()
		print ("wrong one")
	pass # Replace with function body.

func _on_Area2D_area_entered_textF(area):
	if node and current == alphabets[5]:
		popSuccess()
		print ("hello, its F")
	else:
		defPos()
		print ("wrong one")
	pass # Replace with function body.

func _on_Area2D_area_entered_textG(area):
	if node and current == alphabets[6]:
		popSuccess()
		print ("hello, its G")
	else:
		defPos()
		print ("wrong one")
	pass # Replace with function body.

func _on_Area2D_area_entered_textH(area):
	if node and current == alphabets[7]:
		popSuccess()
		print ("hello, its H")
	else:
		defPos()
		print ("wrong one")
	pass # Replace with function body.

func _on_Area2D_area_entered_textI(area):
	if node and current == alphabets[8]:
		popSuccess()
		print ("hello, its I")
	else:
		defPos()
		print ("wrong one")
	pass # Replace with function body.


func _on_Area2D_area_entered_textJ(area):
	if node and current == alphabets[9]:
		popSuccess()
		print ("hello, its J")
	else:
		defPos()
		print ("wrong one")
	pass # Replace with function body.


func _on_Area2D_area_entered_textK(area):
	if node and current == alphabets[10]:
		popSuccess()
		print ("hello, its K")
	else:
		defPos()
		print ("wrong one")
	pass # Replace with function body.


func _on_Area2D_area_entered_textL(area):
	if node and current == alphabets[11]:
		popSuccess()
		print ("hello, its L")
	else:
		defPos()
		print ("wrong one")
	pass # Replace with function body.


func _on_Area2D_area_entered_textM(area):
	if node and current == alphabets[12]:
		popSuccess()
		print ("hello, its M")
	else:
		defPos()
		print ("wrong one")
	pass # Replace with function body.


func _on_Area2D_area_entered_textN(area):
	if node and current == alphabets[13]:
		popSuccess()
		print ("hello, its N")
	else:
		defPos()
		print ("wrong one")
	pass # Replace with function body.

func _on_Area2D_area_entered_textO(area):
	if node and current == alphabets[14]:
		popSuccess()
		print ("hello, its O")
	else:
		defPos()
		print ("wrong one")
	pass # Replace with function body.


func _on_Area2D_area_entered_textP(area):
	if node and current == alphabets[15]:
		popSuccess()
		print ("hello, its P")
	else:
		defPos()
		print ("wrong one")
	pass # Replace with function body.


func _on_Area2D_area_entered_textQ(area):
	if node and current == alphabets[16]:
		popSuccess()
		print ("hello, its Q")
	else:
		defPos()
		print ("wrong one")
	pass # Replace with function body.


func _on_Area2D_area_entered_textR(area):
	if node and current == alphabets[17]:
		popSuccess()
		print ("hello, its R")
	else:
		defPos()
		print ("wrong one")
	pass # Replace with function body.


func _on_Area2D_area_entered_textS(area):
	if node and current == alphabets[18]:
		popSuccess()
		print ("hello, its S")
	else:
		defPos()
		print ("wrong one")
	pass # Replace with function body.


func _on_Area2D_area_entered_textT(area):
	if node and current == alphabets[19]:
		popSuccess()
		print ("hello, its T")
	else:
		defPos()
		print ("wrong one")
	pass # Replace with function body.


func _on_Area2D_area_entered_textU(area):
	if node and current == alphabets[20]:
		popSuccess()
		print ("hello, its U")
	else:
		defPos()
		print ("wrong one")
	pass # Replace with function body.


func _on_Area2D_area_entered_textV(area):
	if node and current == alphabets[21]:
		popSuccess()
		print ("hello, its V")
	else:
		defPos()
		print ("wrong one")
	pass # Replace with function body.


func _on_Area2D_area_entered_textW(area):
	if node and current == alphabets[22]:
		popSuccess()
		print ("hello, its W")
	else:
		defPos()
		print ("wrong one")
	pass # Replace with function body.


func _on_Area2D_area_entered_textX(area):
	if node and current == alphabets[23]:
		popSuccess()
		print ("hello, its H")
	else:
		defPos()
		print ("wrong one")
	pass # Replace with function body.


func _on_Area2D_area_entered_textY(area):
	if node and current == alphabets[24]:
		popSuccess()
		print ("hello, its Y")
	else:
		defPos()
		print ("wrong one")
	pass # Replace with function body.


func _on_Area2D_area_entered_textZ(area):
	if node and current == alphabets[25]:
		popSuccess()
		print ("hello, its Z")
	else:
		defPos()
		print ("wrong one")
	pass # Replace with function body.


func _on_play_pressed():
	get_tree().reload_current_scene()
	pass # Replace with function body.
