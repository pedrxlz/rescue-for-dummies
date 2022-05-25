extends Area2D

var counter = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PatientBody_body_entered(body):
	if body.name == "Player" and Global.equippedItem == "Potion" and counter == 0:
		counter += 1
		print("Deu bom!")
		print(counter)
		
	if Global.equippedItem == "BluePotion" and counter == 1:
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
		
