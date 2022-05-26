extends Area2D

var counter = 0
var max_health = 3
var patient_health = max_health

signal change_life(patient_health)

func _ready():
	connect("change_life", get_parent().get_node("HUD/HBoxContainer/Holder"), "on_change_life")
	emit_signal("change_life", max_health)

func _process(delta):
	if patient_health == 0:
		get_tree().change_scene("res://Scenes/Hall.tscn")
	
func _on_PatientBody_body_entered(body):
	var aux = counter
	if body.name == "Player" and Global.equippedItem == "Potion" and counter == 0:
		counter += 1
		print("Deu bom!")
		print(counter)
		
	if Global.equippedItem == "BluePotion" and counter == 1 :
		counter += 1
		print("Deu bom de novo!")
		print(counter)
		
	if Global.equippedItem == "GreenPotion" and counter == 2:
		counter += 1
		print("Paciente pronto")

	if counter == 3:
		queue_free()
		print("Level 1 Completo!")
		Global.player2D = true
		get_tree().change_scene("res://Scenes/Hall.tscn")
		
	elif aux == counter and Global.equippedItem:
		patient_health -= 1
		emit_signal("change_life", patient_health)
		
	
	
			
		
		
