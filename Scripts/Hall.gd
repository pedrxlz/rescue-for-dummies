extends Node2D

var area_active = [1, false]

func ready():
	Global.player2D = true
	
func _physics_process(delta):
	if area_active[1] and Input.is_action_just_pressed("game_action"):
		match area_active[0]:
			1:
				get_tree().change_scene("res://Scenes/Level_01.tscn")
			2:
				get_tree().change_scene("res://Scenes/Level_02.tscn")
			3:
				get_tree().change_scene("res://Scenes/Level_03.tscn")	
	

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
