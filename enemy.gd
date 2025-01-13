extends CharacterBody2D

var rng = RandomNumberGenerator.new()
var enemyDamage = 10
var critMultiplier = 2
var defense = 1
var maxHealth = 100
var health = maxHealth

enum States {IDLE, SHOVE, ATTACK, DODGE, BLOCK} #Enums for different states 
var state: States = States.IDLE 
#Set variable state to track current state

func setState(state):
	if state == States.IDLE:
		$enemySprite2D/AnimationPlayer.play('idleEnemy')
		Global.attack = Global.trueAttack
	elif state == States.SHOVE:	
		$enemySprite2D/AnimationPlayer.play('shoveEnemy')
		Global.attack = Global.trueAttack
		Global.health -= 0.2 * Global.attack
		if Global.health < 0:
			Global.health == 0
	elif state == States.ATTACK:	
		Global.attack = Global.trueAttack
		$enemySprite2D/AnimationPlayer.play('attackEnemy')
		Global.health -= Global.attack
		if Global.health < 0:
			Global.health == 0
	elif state == States.DODGE:	
		$enemySprite2D/AnimationPlayer.play('dodgeEnemy')
		Global.attack = 0
	elif state == States.BLOCK:	
		$enemySprite2D/AnimationPlayer.play('blockEnemy')
		defense = 4
		Global.attack = Global.trueAttack / defense
		defense = 1

func combo1():
	pass

func _ready():
	setState(States.IDLE)
	$"../Timer".wait_time = 2
	$"../Timer".start() 

func _on_timer_timeout() -> void:
	$"../Timer".wait_time = rng.randf_range(1, 1.5)
	var my_random_number = rng.randi_range(1, 5)
	print(Global.health)
	if my_random_number == 1:
		setState(States.IDLE)
	elif my_random_number == 2:
		setState(States.ATTACK)
	elif my_random_number == 3:
		setState(States.BLOCK)
	elif my_random_number == 4:
		setState(States.SHOVE)
	elif my_random_number == 5:
		setState(States.DODGE)
	pass # Replace with function body.
