extends Panel

onready var node = get_tree().get_nodes_in_group("letter")
onready var area = get_tree().get_nodes_in_group("area")

var grid
var inbox 
var current
var info = "data is inside"

func _ready():
	for i in area.size():
		area[i].get_child(0).disabled = true

func _physics_process(_delta):
	current = xtr.selectData
	inbox = xtr.inboxData
	grid = xtr.gridBox

func _on_areaA_area_entered(_area):
	if node:
		
		
		
		pass
	pass # Replace with function body.




#
### signal for body entered
#func _on_Area2D_area_entered(area):
#	if node:
#		print("something is inside")
##		checkCondition()
#	pass # Replace with function body.
#
#
#func _on_Area2D_area_exited(area):
#	if node:
#		print("something went outside")
#	pass # Replace with function body.
#
###
#
#func checkCondition():
#
#	#print(gridItem[1].get_child(0).text)
#	for item in gridItem.size():
#		for letter in dragItem.size():
#			if gridItem[item].get_child(0).text == dragItem[letter].get_child(1).text:
#				print("success")
#
#	pass
