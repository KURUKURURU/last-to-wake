extends Node2D
var move
var playing
var direction 
var check
var health = 3
var X 
var Y 
var open = true

@onready var left = $CanvasLayer/left
@onready var right = $CanvasLayer/right
@onready var up = $CanvasLayer/up
@onready var down = $CanvasLayer/down

@onready var p = $Player
@onready var pA = $Player/Area2D
@onready var PlayerIcon = $Player/icon
@onready var bubble = $CanvasLayer/Bubble
@onready var ding = $ding
@onready var timer = $CanvasLayer/Timer
@onready var info = $CanvasLayer/InfoScreen
@onready var blanket = $blanket
@onready var hurt = $hurt

@onready var fadeColor = $CanvasLayer/color
@onready var fadeAnimation = $CanvasLayer/animation

@onready var creatureAnimation = $creature/animation
@onready var creature = $creature
@onready var creatureAreaV = $creature/up_down/Area2D
@onready var creatureAreaH = $creature/right_left/Area2D
@onready var healthImg = $CanvasLayer/health


@onready var ScaryHammy = $ScaryHammy/Area2D
@onready var ScaryHammyIcon = $ScaryHammy/icon

@onready var CharlesPortrait = $CharliePortrait/Area2D

@onready var HeadHammy = $HeadHammy/Area2D
@onready var HeadHammyIcon = $HeadHammy/icon

@onready var Zoe = $Zoe/Area2D
@onready var ZoeIcon = $Zoe/icon

@onready var _3hearts1 = preload("res://images/3_1.png")
@onready var _3hearts2 = preload("res://images/3_2.png")
@onready var _2hearts1 = preload("res://images/2h.png")
@onready var _1hearts1 = preload("res://images/1.png")

func _ready() -> void:
	playing = false
	p.moving = false
	info.hide()
	
	await wait(1)
	
	info.show()
	blanket.play()

func _process(delta: float) -> void:
	
	if health == 3:
		healthImg.texture = _3hearts1
		await wait(0.2)
		healthImg.texture = _3hearts2
		await wait(0.2)
	elif health == 2:
		healthImg.texture = _2hearts1
	elif health == 1:
		healthImg.texture = _1hearts1
	elif health == 0:
		healthImg.texture = null
	
	_interact(PlayerIcon, CharlesPortrait, pA, "You", "What really happened to Charlie?")
	_interact(ZoeIcon, Zoe, pA, "Corner-dwelling Yanella", "have you seen jadyn?")
	_interact(HeadHammyIcon, HeadHammy, pA, "Head Hammy", "My sleepovers suck")
	
	if creatureAreaV.overlaps_area(pA) and open == true:
		open = false
		if health > 1:
			
			health = health - 1
			hurt.play()
			
		elif health == 0:
			hurt.play()
			get_tree().change_scene_to_file("res://code/deadscreen.tscn")
			
		open = true
			
func play():
	if playing:
		for i in range(10): #missing 3 times kills you
			var randomTime = randi_range(4, 6)
			var randomDirection = randi_range(1, 3) #left/right, up, down
			await wait(randomTime)
			
			if randomDirection == 1:
				var choice = randi_range(1,2)
				if choice == 1:
					direction = left
					check = "left"
				elif choice == 2:
					direction = right
					check = "right"
				
			elif randomDirection == 2:
				print("debug")
				direction = up
				check = "up"
					
			elif randomDirection == 3:
				direction = down
				check = "down"
			
			direction.play()
			await direction.finished
			X = p.position.x
			Y = p.position.y
			
			await wait(0.40)
			
			await creatureCrawl(check)
			
			
func creatureCrawl(check):
	
	if check == "left" or check == "right":
		creature.position.x = X
		creature.position.y = 3600
		creature_horizontal()
		
		creatureAnimation.play("vertical")
		await creatureAnimation.animation_finished
		
		
	elif check == "up" or check == "down":
		creature.position.x = -760
		creature.position.y = Y
		creature_vertical()
		
		creatureAnimation.play("horizontal")
		await creatureAnimation.animation_finished
	
		
	
	
func _interact(iconPath, randomArea, playerArea, name, message):
	if randomArea.overlaps_area(playerArea):
		if Input.is_action_just_pressed("interact"):
			ding.play()
			iconPath.show()
			await box(name, message)
			iconPath.hide()
	
	
func box(name, message):
	p.moving = false
	await bubble.talk(name, message)
	p.moving = true

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout


func _on_info_screen_hi() -> void:
	p.moving = true
	playing = true
	play()

func creature_vertical():
	$creature/up_down.show()
	$creature/right_left.hide()

func creature_horizontal():
	$creature/up_down.hide()
	$creature/right_left.show()
