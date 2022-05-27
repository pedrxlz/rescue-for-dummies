extends Node2D

var area_active = [1, false]
var first_geralt_dialog = Dialogic.start("first-geralt")
var first_dialog = Dialogic.start("first")

func ready():
	Global.player2D = true
	
	
func _physics_process(delta):
	if area_active[1] and (Input.is_action_just_pressed("interact") or get_node("Player").get("btnGreen")) :
		match area_active[0]:
			1:
				get_tree().change_scene("res://Scenes/Levels/Level_01.tscn")
			2:
				get_tree().change_scene("res://Scenes/Levels/Level_02.tscn")
			3:
				get_tree().change_scene("res://Scenes/Levels/Level_03.tscn")	
	

func _on_Level1_body_entered(body):
	if body.name == 'Player':
		area_active = [1, true]


func _on_Level1_body_exited(body):
	if body.name == 'Player':
		area_active = [1, false]


func _on_Level2_body_entered(body):
	if body.name == 'Player':
		area_active = [2, true]


func _on_Level2_body_exited(body):
	if body.name == 'Player':
		area_active = [2, false]


func _on_Level3_body_entered(body):
	if body.name == 'Player':
		area_active = [3, true]


func _on_Level3_body_exited(body):
	if body.name == 'Player':
		area_active = [3, false]


func _on_Dialog_body_entered(body):
	add_child(first_dialog)
	Global.player_move = false
	first_dialog.connect("timeline_end", self, "after_dialog")
	

func _on_Supervisor_body_entered(body):
	add_child(first_geralt_dialog)
	Global.player_move = false
	first_geralt_dialog.connect("timeline_end", self, "after_dialog")


func after_dialog(timeline_name):
	Global.player_move = true
