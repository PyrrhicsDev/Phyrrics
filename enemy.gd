extends CharacterBody2D

var rng = RandomNumberGenerator.new()
var critMultiplier = 2
var defense = 1

enum States {IDLE, SHOVE, ATTACK, DODGE, BLOCK, blockedATTACK, HIT} #Enums for different states 
#Set variable state to track current state

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func setState(state):
	if state == States.IDLE:
		$enemySprite2D/AnimationPlayer.play('idleEnemy')
		Global.attack = Global.trueAttack
	elif state == States.SHOVE:	
		$enemySprite2D/AnimationPlayer.play('shoveEnemy')
		Global.attack = Global.trueAttack
		Global.health -= 0.2 * Global.enemyDamage
		if Global.health < 0:
			Global.health = 0
	elif state == States.ATTACK:	
		Global.attack = Global.trueAttack
		$enemySprite2D/AnimationPlayer.play('attackEnemy')
		Global.health -= Global.enemyDamage
		if Global.health < 0:
			Global.health = 0
	elif state == States.DODGE:	
		$enemySprite2D/AnimationPlayer.play('dodgeEnemy')
		Global.attack = 0
	elif state == States.BLOCK:	
		$enemySprite2D/AnimationPlayer.play('blockEnemy')
		Global.attack = Global.trueAttack * defense * 0.5
	elif state == States.blockedATTACK:	
		$enemySprite2D/AnimationPlayer.play('attackEnemy')
		Global.enemyDamage = 0
	elif state == States.HIT:	
		$enemySprite2D.position = Vector2(10, 0)
		$enemySprite2D.position = Vector2(0, 0)
		$enemySprite2D.modulate = Color(255, 0, 0, 50)
		
func combo1():
	pass

func _ready():
	setState(States.IDLE)
	#$"../Timer".wait_time = 2
	#$"../Timer".start() 

func _on_timer_timeout() -> void:
	#$"../Timer".wait_time = rng.randf_range(1, 1.5)
	var my_random_number = rng.randi_range(1, 5)
	print("My HP: %d" % Global.health)
	print("Enemy HP: %d" % Global.enemyHealth)
	if Global.enemyNewHealth < Global.enemyOldHealth:
		setState(States.HIT)
		Global.enemyOldHealth = Global.enemyNewHealth
	else:
		if my_random_number == 1:
			setState(States.IDLE)
		elif my_random_number == 2:
			if Global.blocked:
				setState(States.blockedATTACK)
			elif !Global.blocked:
				setState(States.ATTACK)
		elif my_random_number == 3:
			setState(States.BLOCK)
		elif my_random_number == 4:
			if Global.blocked:
				setState(States.blockedATTACK)
			elif !Global.blocked:
				setState(States.SHOVE)
		elif my_random_number == 5:
			setState(States.DODGE)
	pass # Replace with function body.
