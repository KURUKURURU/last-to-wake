extends Node2D
var move
@onready var p = $Player
@onready var pA = $Player/Area2D
@onready var bubble = $CanvasLayer/Bubble
@onready var ding = $ding
@onready var timer = $CanvasLayer/Timer

@onready var fadeColor = $CanvasLayer/color
@onready var fadeAnimation = $CanvasLayer/animation


@onready var ScaryHammy = $ScaryHammy/Area2D
@onready var ScaryHammyIcon = $ScaryHammy/icon

@onready var InterestingHammy = $InterestingHammy/Area2D
@onready var InterestingHammyIcon = $InterestingHammy/icon

@onready var HeadHammy = $HeadHammy/Area2D
@onready var HeadHammyIcon = $HeadHammy/icon

@onready var Zoe = $Zoe/Area2D
@onready var ZoeIcon = $Zoe/icon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await box("You", "I don't feel like being here.....")
	await box("You", "Not after what happened last year.")
	timer.countdown("Bedtime in ", 60)

func _process(delta: float) -> void:
	_interact(InterestingHammyIcon, InterestingHammy, pA, "Interesting Hammy", "Whaddup. What's your position on toes?")
	_interact(ScaryHammyIcon, ScaryHammy, pA, "Scary Hammy", "I'm Scary Hammy. But I'm still lowkirkenuliy chill.")
	_interact(HeadHammyIcon, HeadHammy, pA, "Head Hammy", "I own everything here cuz I'm hosting the annual sleepover at my place. I also own you.")
	_interact(ZoeIcon, Zoe, pA, "Zoe, the silly", "burp.")
	
	
	
func box(name, message):
	p.moving = false
	await bubble.talk(name, message)
	p.moving = true

func _interact(iconPath, randomArea, playerArea, name, message):
	if randomArea.overlaps_area(playerArea):
		if Input.is_action_just_pressed("interact"):
			ding.play()
			iconPath.show()
			await box(name, message)
			iconPath.hide()

#"Scary Hammy", "I'm Scary Hammy. But I'm still lowkirkenuliy chill.")

func timerEnd():
	fadeAnimation.play("fade")
	await fadeAnimation.animation_finished
	await wait(2.0)
	get_tree().change_scene_to_file("res://code/bedroom_ceremony.tscn")
	
func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
