extends Node2D

var area_active = [1, false]

func _ready():
	Global.player2D = true
	
	match Global.game_progress:
		1:
			get_node('Player').position.x = 365
		2:
			get_node('Player').position.x = 836.7
		3:
			get_node('Player').position.x = 1312
		4:
			get_node('Player').position.x = 1790
	
	
func _physics_process(delta):
	if area_active[1] and (Input.is_action_just_pressed("interact") or Global.btnGreen) :
		match area_active[0]:
			1:
				if Global.game_progress == 0:
					get_tree().change_scene("res://Scenes/Levels/Level_01.tscn")
			2:
				if Global.game_progress == 1:
					get_tree().change_scene("res://Scenes/Levels/Level_02.tscn")
			3:
				if Global.game_progress == 2:
					get_tree().change_scene("res://Scenes/Levels/Level_03.tscn")	
			4:
				if Global.game_progress == 3:
					get_tree().change_scene("res://Scenes/Levels/Level_04.tscn")	
			5:
				if Global.game_progress == 4:
					get_tree().change_scene("res://Scenes/Levels/Level_05.tscn")	
		Global.btnGreen = false

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

func _on_Level4_body_entered(body):
	if body.name == 'Player':
		area_active = [4, true]


func _on_Level4_body_exited(body):
	if body.name == 'Player':
		area_active = [4, false]


func _on_Level5_body_entered(body):
	if body.name == 'Player':
		area_active = [5, true]


func _on_Level5_body_exited(body):
	if body.name == 'Player':
		area_active = [5, false]


func _on_Dialog_body_entered(body):
	var first_dialog = Dialogic.start("first")
	add_child(first_dialog)
	Global.player_move = false
	first_dialog.connect("timeline_end", self, "after_dialog")
	

func _on_Supervisor_body_entered(body):
	var first_geralt_dialog = Dialogic.start("first-geralt")
	add_child(first_geralt_dialog)
	Global.player_move = false
	first_geralt_dialog.connect("timeline_end", self, "after_dialog")


func after_dialog(timeline_name):
	Global.player_move = true



