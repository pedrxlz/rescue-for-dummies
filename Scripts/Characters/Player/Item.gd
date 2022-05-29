extends Area2D
class_name Item

export(bool) var on_floor = true

onready var player_detector = get_node("PlayerDetector")

func _ready():
	if not on_floor:
		pass

func _on_PlayerDetector_body_entered(body):
	if !Global.on_item and body.name == 'Player':
		body.pick_up_item(self)
		position = Vector2.ZERO
		Global.equippedItem = self.name
	
		
