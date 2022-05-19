extends KinematicBody2D

var velocity : Vector2 = Vector2()
var direction : Vector2 = Vector2()
var walk_speed = 100

onready var player_item = get_node('Item')

var current_item

var anim_status = 'walk'
var on_item = true

onready var sprite = $AnimatedSprite

func _ready():
	current_item = player_item.get_child(0)
	

func read_input():
	velocity = Vector2()
	
	if Global.player2D == false:
		if Input.is_action_pressed("up"):
			velocity.y -= 1
			direction = Vector2(0, -1)
				
		if Input.is_action_pressed("down"):
			velocity.y += 1
			direction = Vector2(0, 1)
				
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		direction = Vector2(-1, 0)
		
	if Input.is_action_pressed("right"):
		velocity.x += 1
		direction = Vector2(1, 0)
		
	
	if Global.player2D:
		anim_status = 'walk'
	elif !Global.player2D and !on_item:
		anim_status = 'run'
	elif on_item:
		anim_status = 'push'
		if velocity.x  > 0:
			player_item.scale.x = 1
		elif velocity.x < 0:
			player_item.scale.x = -1
		
	update_animation(anim_status)	
		
	velocity = velocity.normalized()
	velocity = move_and_slide(velocity * walk_speed)
	
func _physics_process(delta):
	read_input()

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


func pick_up_item(item: Area2D) -> void:
	
	player_item.add_child(current_item)
	item.get_parent().call_deferred("remove_child", item)
	item.call_deferred("add_child", item)
	item.set_deferred("owner", item)
	#current_item.hide()
	current_item = item
	
	
	
	
	
	
	
