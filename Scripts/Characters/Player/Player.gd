extends KinematicBody2D


var velocity : Vector2 = Vector2()
var direction : Vector2 = Vector2()
var walk_speed = 100

var move_direction_x = 0
var move_direction_y = 0

onready var player_item = get_node('Item')

var current_item

var anim_status = 'walk'

onready var sprite = $AnimatedSprite

func _ready():
	SerialSocket.connect("Xaxis", self, "_on_Xaxis")
	SerialSocket.connect("Yaxis", self, "_on_Yaxis")
	SerialSocket.connect("btnRed", self, "_on_btnRed")
	SerialSocket.connect("btnGreen", self, "_on_btnGreen")

func _on_Xaxis(value):
	if value == "-1":
		move_direction_x = -1
		
	if value == "1":
		move_direction_x = 1

	elif value == "0":
		move_direction_x = 0

func _on_Yaxis(value):
	if Global.player2D == false:
		if value == '1':
			move_direction_y = -1
				
		if value == '-1':
			move_direction_y = 1
			
		elif value == "0":
			move_direction_y = 0	

func _on_btnRed():
	if Global.on_item:
		print("dropei!")
		drop_item()

func _on_btnGreen():
	Global.btnGreen = true

func read_input():
	velocity = Vector2()
	
	if Global.player2D == false:
		if Input.is_action_pressed("up") or move_direction_y == -1:
			velocity.y = -1
			direction = Vector2(0, -1)
				
		if Input.is_action_pressed("down") or move_direction_y == 1:
			velocity.y = 1
			direction = Vector2(0, 1)
				
	if Input.is_action_pressed("left") or move_direction_x == -1:
		velocity.x = -1
		direction = Vector2(-1, 0)
		
	if Input.is_action_pressed("right") or move_direction_x == 1:
		velocity.x = 1
		direction = Vector2(1, 0)
		
	
	if Global.player2D:
		anim_status = 'walk'
		
	elif !Global.player2D and !Global.on_item:
		anim_status = 'run'
		
	elif Global.on_item:
		anim_status = 'push'
		
		if velocity.x  > 0:
			player_item.scale.x = 1
			
		elif velocity.x < 0:
			player_item.scale.x = -1
		
	update_animation(anim_status)	
		
	velocity = velocity.normalized()
	velocity = move_and_slide(velocity * walk_speed)

	
func _physics_process(delta):
	if Global.player_move:
		read_input()

	elif !Global.player_move:
		sprite.play('idle-right')
	
	if Global.player2D:
		anim_status = 'walk'
		
	elif !Global.player2D and !Global.on_item:
		anim_status = 'run'
		
	elif Global.on_item:
		anim_status = 'push'
		
		if velocity.x  > 0:
			player_item.scale.x = 1
			
		elif velocity.x < 0:
			player_item.scale.x = -1
	
	if Input.is_action_pressed("interact") and Global.on_item:
		drop_item()

func update_animation(string):
	if velocity.x > 0 :
		sprite.play(string + '-right')
	elif velocity.x < 0:
		sprite.play(string + '-left')
	elif velocity.y > 0:
		sprite.play(string + '-down')
	elif velocity.y < 0:
		sprite.play(string + '-up')
		
	elif direction.x == 1:
		sprite.play('idle-right')
	elif direction.x == -1:
		sprite.play('idle-left')
	elif direction.y == -1:
		sprite.play('idle-up')
	elif direction.y == 1:
		sprite.play('idle-down')

func pick_up_item(item: Node2D) -> void:
	Global.on_item = true
	current_item = item
	get_parent().remove_child(current_item)
	player_item.add_child(current_item)

func drop_item() -> void:
	Global.on_item = false
	var item_to_drop: Node2D = current_item
	player_item.remove_child(item_to_drop)
	get_parent().add_child(item_to_drop)
	item_to_drop.position = position
	Global.equippedItem = null
	






	
	
	
	
	
	
