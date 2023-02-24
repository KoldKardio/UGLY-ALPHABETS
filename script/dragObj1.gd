extends Node2D

var selected = false
var drag_speed = 25
onready var nde = $Sprite/Panel/Label

func _on_Area2D_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("click"):
		selected = true

func _physics_process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), drag_speed * delta)
		xtr.selectData = nde.text
#		print(xtr.selectData)
	

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			selected = false
