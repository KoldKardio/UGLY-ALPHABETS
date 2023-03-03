extends Node

onready var area = get_tree().get_nodes_in_group("area")
onready var pan = get_tree().get_nodes_in_group("pan")
onready var node = get_tree().get_nodes_in_group("letter")
onready var init_pos = get_tree().get_nodes_in_group("init_pos")

onready var uwin = $WIN
onready var drag = $dragable
onready var failed = $failed
onready var success = $success
onready var grid = $GridContainer
onready var points = $scoreboard/points
onready var textFont = load("res://font.tres")
onready var confetti = $success/confetti
onready var sadEmo = $failed/errorAnim

#var newScore
var rng = RandomNumberGenerator.new()
var current
var lnum = Array() 
const loc = Array()
var oldData = Array()
var boxLeft = 5
var score = Array()
const resetScr = Array()

var alphabets = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
var colors = [Color.red, Color.green, Color.salmon, Color.violet, Color.aqua, Color.orange]
var dragItem = Array()
var gridItem = Array()
var lostItem = Array()
var winData = Array()
var textColor

func _ready():
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	
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
	
#	areaBoxCheck()
	randomColors()
	changeColors()
	nodeKoPos()
	
	winData = dragItem
	pass

func randomColors() -> void:
	randomize()
	var num = randi() % colors.size()
	textColor = colors[num]
	pass

func changeColors() -> void:
	randomColors()
	
	for i in alphabets.size():
		gridItem[i].get_child(0).set("custom_colors/font_color", textColor)
		gridItem[i].get_child(0).set("custom_fonts/font", textFont)
		randomColors()
		pass
	for i in node.size():
		randomColors()
		node[i].get_child(0).set("custom_colors/font_color", textColor)
	
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
		drags[i].get_child(0).text = lostItem[i]
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
				area[items].get_child(0).disabled = false
				pan[items].visible = true
		pass
	pass

func nodeKoPos():
#	print(init_pos[0].position)
	for pos in init_pos.size():
		loc.append(init_pos[pos].transform)
#	print(loc)
	pass

func defPos():
	yield(get_tree().create_timer(.8), "timeout")
	#print (loc[0])
	sadEmo.frame = 0
	sadEmo.playing = true
	failed.visible = true
	yield(get_tree().create_timer(1.5), "timeout")
	sadEmo.playing = false
	failed.visible = false
	
	for i in 5:
		init_pos[i].transform = loc[i]
	pass

func popSuccess():
	yield(get_tree().create_timer(.8), "timeout")
	confetti.frame = 0
	success.visible = true
	confetti.playing = true
	
	if success.visible:
		yield(get_tree().create_timer(1), "timeout")
		confetti.playing = false
		success.visible = false
		
		for items in dragItem.size():
#			print(dragItem[items].get_child(0).get_child(0).text)
			if current == dragItem[items].get_child(0).get_child(0).text:
				dragItem[items].visible = false 
		
		for abc in gridItem.size():
#			print(gridItem[0].get_child(0).text)
			if current == gridItem[abc].get_child(0).text:
				gridItem[abc].get_child(0).visible = true
				gridItem[abc].get_child(1).get_child(0).disabled = true
				
			pass
	
	if !winData[0].visible and !winData[1].visible and !winData[2].visible and !winData[3].visible and !winData[4].visible:
			yield(get_tree().create_timer(1), "timeout")
			uwin.visible = true
	
	
#	yield(get_tree().create_timer(1.8), "timeout")

func win():
	print("all box filled")

func _on_Button_pressed():
#	get_tree().reload_current_scene()
	for i in 5:
		init_pos[i].transform = loc[i]
	pass # Replace with function body.


## --- Caution --- ##
# common signal for all alphabets # just repeatition #
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

func _on_Button2_pressed():
	get_tree().reload_current_scene()
	pass # Replace with function body.
