extends KinematicBody2D


var velocity : Vector2 = Vector2()
var direction : Vector2 = Vector2()
var walk_speed = 180

onready var player_item = get_node('Item')

var current_item

var up;
var down;
var left;
var right;
var btn;
var btnRed;
var btnGreen

var anim_status = 'walk'



onready var sprite = $AnimatedSprite

func _ready():
	current_item = player_item.get_child(0)
	Socket.connect_to_server()
	
	Socket.connect("idle1", self, "_on_idle1")
	Socket.connect("idle2", self, "_on_idle2")
	Socket.connect("right", self, "_on_right")
	Socket.connect("left", self, "_on_left")
	Socket.connect("up", self, "_on_up")
	Socket.connect("down", self, "_on_down")
	Socket.connect("btn", self, "_on_btn")
	Socket.connect("btnRed", self, "_on_btnRed")
	Socket.connect("btnGreen", self, "_on_btnGreen")

func _on_idle1(node):
	up = false
	down = false
	btn = false
	btnRed = false
	btnGreen = false

func _on_idle2(node):
	right = false
	left = false	
	btn = false
	btnRed = false
	btnGreen = false
	
func _on_right(body):
	right = true
	
func _on_left(body):
	left = true	

func _on_up(body):
	up = true

func _on_down(body):
	down = true

func _on_btn(body):
	btn = true

func _on_btnRed(body):
	var ev = InputEventAction.new()
	ev.action = "interact"
	ev.pressed = true
	Input.parse_input_event(ev)
	btnRed = true

func _on_btnGreen(body):
	btnGreen = true



func read_input():
	velocity = Vector2()
	
	if Global.player2D == false:
		if Input.is_action_pressed("up") or up:
			velocity.y -= 1
			direction = Vector2(0, -1)
				
		if Input.is_action_pressed("down") or down:
			velocity.y += 1
			direction = Vector2(0, 1)
				
	if Input.is_action_pressed("left") or left:
		velocity.x -= 1
		direction = Vector2(-1, 0)
		
	if Input.is_action_pressed("right") or right:
		velocity.x += 1
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
	
	if (Input.is_action_pressed("interact") or btnRed) and Global.on_item:
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
	





	
	
	
	
	
	
