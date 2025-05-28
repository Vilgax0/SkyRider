extends CharacterBody2D

@export var move_speed: int
@export var jump_speed: float
@onready var animated_sprite = $animated_sprite
var is_facing_rigth = true
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	move_x()
	flip()
	move_and_slide()
	jump(delta)
	
func update_animation():
	if not is_on_floor():
		if velocity.y < 0:
			animated_sprite.play("jump")
		else:
			animated_sprite.play("fall")
		return
	if velocity.x:
		animated_sprite.play("run")
	else:
		animated_sprite.play("idle")
	
func move_x():
	var input_axis = Input.get_axis("move_left", "move_rigth")
	velocity.x = input_axis * move_speed
	
func flip():
	if (is_facing_rigth and velocity.x > 0) or (not is_facing_rigth and velocity.x < 0):
		scale.x *= -1
		is_facing_rigth = not is_facing_rigth
		
func jump(delta):
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_speed
	
	if not is_on_floor():
		velocity.y += gravity * delta
