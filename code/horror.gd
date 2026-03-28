extends Node2D
var move
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


@onready var ScaryHammy = $ScaryHammy/Area2D
@onready var ScaryHammyIcon = $ScaryHammy/icon

@onready var CharlesPortrait = $CharliePortrait/Area2D

@onready var HeadHammy = $HeadHammy/Area2D
@onready var HeadHammyIcon = $HeadHammy/icon

@onready var Zoe = $Zoe/Area2D
@onready var ZoeIcon = $Zoe/icon

func _ready() -> void:
	p.moving = false
	info.hide()
	
	await wait(1)
	
	info.show()
	blanket.play()

func _process(delta: float) -> void:
	_interact(PlayerIcon, CharlesPortrait, pA, "You", "What really happened to Charlie?")
	_interact(ZoeIcon, Zoe, pA, "Corner-dwelling Yanella", "have you seen jadyn?")
	_interact(HeadHammyIcon, HeadHammy, pA, "Head Hammy", "My sleepovers suck")
	
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
