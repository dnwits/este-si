extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 90

var jump_height = 50
var time_jump_apex = 0.4
var gravity
var jump_force

var on_ground = false
var can_double_jump = false
var is_double_jumping = false

func _ready():
	pass

func _physics_process(delta):
	
	gravity = (2 * jump_height) / pow(time_jump_apex,2)
	jump_force = gravity * time_jump_apex
	
	velocity.y += gravity * delta
	
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed
		$AnimatedSprite.flip_h = true
	elif Input.is_action_pressed("move_right"):
		velocity.x = speed
		$AnimatedSprite.flip_h = false
	else:
		velocity.x = 0
	
	if Input.is_action_just_pressed("jump"):
		if on_ground:
			velocity.y = -jump_force
			on_ground = false
			can_double_jump = true #dc
		else:
			if can_double_jump:
				velocity.y = -jump_force
				can_double_jump = false
				is_double_jumping = true
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if is_on_floor():
		on_ground = true
		can_double_jump = false
		is_double_jumping = false
		
		if velocity.x == 0:
			$AnimatedSprite.play("default")
		else:
			$AnimatedSprite.play("correr")
	else:
		on_ground = false
		if velocity.y < 0:
			if is_double_jumping:
				$AnimatedSprite.play("doblesalto")
			else:
				$AnimatedSprite.play("saltar")
		else:
			$AnimatedSprite.play("caer")	

	pass
