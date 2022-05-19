extends Area2D
class_name Item

export(bool) var on_floor = true

onready var player_detector = get_node("PlayerDetector")

func _ready():
	if not on_floor:
		player_detector.set_collision_mask_bit(0, false)
		player_detector.set_collision_mask_bit(1, false)
		


func _on_PlayerDetector_body_entered(body):
	if body != null:
		player_detector.set_collision_mask_bit(0, false)
		player_detector.set_collision_mask_bit(1, false)
		body.pick_up_item(self)
		position = Vector2.ZERO
	
		
