extends Node2D
var move
var playing
var direction 
var check

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

@onready var fadeColor = $CanvasLayer/color
@onready var fadeAnimation = $CanvasLayer/animation

@onready var creatureAnimation = $CanvasLayer/creature/animation
@onready var creature = $CanvasLayer/creature


@onready var ScaryHammy = $ScaryHammy/Area2D
@onready var ScaryHammyIcon = $ScaryHammy/icon

@onready var CharlesPortrait = $CharliePortrait/Area2D

@onready var HeadHammy = $HeadHammy/Area2D
@onready var HeadHammyIcon = $HeadHammy/icon

@onready var Zoe = $Zoe/Area2D
@onready var ZoeIcon = $Zoe/icon

func _ready() -> void:
	playing = false
	p.moving = false
	info.hide()
	
	await wait(1)
	
	info.show()
	blanket.play()

func _process(delta: float) -> void:
	_interact(PlayerIcon, CharlesPortrait, pA, "You", "What really happened to Charlie?")
	_interact(ZoeIcon, Zoe, pA, "Corner-dwelling Yanella", "have you seen jadyn?")
	_interact(HeadHammyIcon, HeadHammy, pA, "Head Hammy", "My sleepovers suck")
	
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
			await wait(1.0)
			
			await creatureCrawl(check)
			
			#if check == left:
				#
			#elif check == right:
				#
			#elif check == up:
				#
			#elif check == down:
				
			
func creatureCrawl(check):
	
	if check == left or check == right:
		creature.position.x = p.position.x
		creature.position.y = 3600
		
		creatureAnimation.play("vertical")
		await creatureAnimation.animation_finished
		
		
	elif check == up or check == down:
		creature.position.x = -760
		creature.position.y = p.position.y
		
		creatureAnimation.play("vertical")
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
