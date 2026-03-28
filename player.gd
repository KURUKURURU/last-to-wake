extends CharacterBody2D
@onready var animation = $animation

var speed = 500 
var moving = true
#
#func _process(delta: float) -> void:
	#if :
		##if animation.animation == "wal":
		#animation.play("walk")

func _physics_process(delta):
# setup direction of movement
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if moving:
		if Input.is_action_pressed("right") || Input.is_action_pressed("left"):
			direction.y = 0
		elif Input.is_action_pressed("up") || Input.is_action_pressed("down"):
			direction.x = 0
		else:
			direction = Vector2.ZERO
	

		direction = direction.normalized()
# setup the actual movement
		velocity = (direction * speed)
		move_and_slide()
	
	if Input.is_action_pressed("right") || Input.is_action_pressed("left") or Input.is_action_pressed("up") || Input.is_action_pressed("down") :
		#if animation.animation == "wal":
		animation.play("walk")
	else:
		animation.play("idle")
