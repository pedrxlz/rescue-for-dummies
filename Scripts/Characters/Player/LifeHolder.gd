extends Control

var life_size = 20

func on_change_life(patient_health):
	$Lifes.rect_size.x = patient_health * life_size
