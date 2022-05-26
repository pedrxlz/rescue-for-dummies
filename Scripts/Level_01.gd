extends Node2D

var guide_toggle = false

func _ready():
	Global.player2D = false
	$HUD/Panel.hide()	

func _physics_process(delta):
	if Input.is_action_just_pressed("guide") and guide_toggle == false:
		guide_toggle = true
		$HUD/Panel.show()
	elif Input.is_action_just_pressed("guide") and guide_toggle == true:
		guide_toggle = false
		$HUD/Panel.hide()	

func _on_Supervisor_body_entered(body):
	var dialog = Dialogic.start("case1")
	add_child(dialog)
