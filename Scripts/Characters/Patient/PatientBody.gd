extends Area2D

var counter = 0
var max_health = 3
var patient_health = max_health
var current_protocol

signal change_life(patient_health)

func _ready():
	current_protocol = get_parent().get("protocol_sequence")
	connect("change_life", get_parent().get_node("HUD/HBoxContainer/Holder"), "on_change_life")
	emit_signal("change_life", max_health)

func _process(delta):
	if patient_health == 0:
		get_parent().get_node('Player').drop_item()
		get_tree().change_scene("res://Scenes/Levels/Hall.tscn")
		$Fail.play()
	
func _on_PatientBody_body_entered(body, aux = counter):
	if body.name == "Player" and Global.equippedItem == current_protocol[counter]:
		counter += 1
		$RightItem.play()
		
	if counter == current_protocol.size():
		Global.game_progress += 1
		get_parent().get_node('Player').drop_item()
		if Global.game_progress > 4:
			Global.game_progress = 0
			get_tree().change_scene("res://Scenes/EndGame.tscn")
		else:
			get_tree().change_scene("res://Scenes/Levels/Hall.tscn")
			$LevelCompleted.play()
	
	elif aux == counter and Global.equippedItem:
		patient_health -= 1
		emit_signal("change_life", patient_health)
		$WrongItem.play()
			
		
		
