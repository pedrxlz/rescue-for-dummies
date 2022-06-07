extends MarginContainer

const first_scene = preload("res://Scenes/Levels/Hall.tscn")

onready var selector_one = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Selector
onready var selector_two = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Selector
onready var selector_three = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer3/HBoxContainer/Selector

var current_selection = 0

func _ready():
	SerialSocket.connect("Yaxis", self, "_on_Yaxis")
	set_current_selection(0)

func _on_Yaxis(value):
	if value == '1':
		$MenuSelection.play()
		current_selection -= 1
		set_current_selection(current_selection)
				
	if value == '-1':
		$MenuSelection.play()
		current_selection += 1
		set_current_selection(current_selection)
			
	elif value == "0":
		pass

func _process(delta):
	if Input.is_action_just_pressed("down") and current_selection < 2:
		$MenuSelection.play()
		current_selection += 1
		set_current_selection(current_selection)
	elif Input.is_action_just_pressed("up") and current_selection > 0:
		$MenuSelection.play()
		current_selection -= 1
		set_current_selection(current_selection)
	elif (Input.is_action_just_pressed("ui_accept") or Global.btnGreen):
		$MenuEnter.play()
		Global.btnGreen = false
		handle_selection(current_selection)

func handle_selection(_current_selection):
	if _current_selection == 0:
		get_tree().change_scene("res://Scenes/Levels/Hall.tscn")
	elif _current_selection == 1:
		print("Add options!")
	elif _current_selection == 2:
		get_tree().quit()

func set_current_selection(_current_selection):
	selector_one.text = ""
	selector_two.text = ""
	selector_three.text = ""
	if _current_selection == 0:
		selector_one.text = ">"
	elif _current_selection == 1:
		selector_two.text = ">"
	elif _current_selection == 2:
		selector_three.text = ">"
