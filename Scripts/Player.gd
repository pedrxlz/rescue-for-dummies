extends KinematicBody2D

var velocity : Vector2 = Vector2()
var direction : Vector2 = Vector2()
var walk_speed = 100

onready var sprite = $AnimatedSprite

func read_input():
	velocity = Vector2()
	
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
		
	update_animation()	
		
	velocity = velocity.normalized()
	velocity = move_and_slide(velocity * walk_speed)
	
func _physics_process(delta):
	read_input()

func update_animation():
	if velocity.x > 0 :
		sprite.play('walk-right')
	elif velocity.x < 0:
		sprite.play('walk-left')
	elif velocity.y > 0:
		sprite.play('walk-down')
	elif velocity.y < 0:
		sprite.play('walk-up')
		
	elif direction.x == 1:
		sprite.play('idle-right')
	elif direction.x == -1:
		sprite.play('idle-left')
	elif direction.y == -1:
		sprite.play('idle-up')
	elif direction.y == 1:
		sprite.play('idle-down')
