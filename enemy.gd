extends CharacterBody2D

var rng = RandomNumberGenerator.new()
var critMultiplier = 2
var defense = 1

var enemyTimerCooldown := true # Allows for the first initial action with no cooldown
enum States {IDLE, SHOVE, ATTACK, DODGE, BLOCK, blockedATTACK, HIT} #Enums for different states 
var parryTime := 0.8
#Set variable state to track current state

func setState(state):
	if state == States.IDLE:
		$enemySprite2D/AnimationPlayer.play('idleEnemy')
		Global.attack = Global.trueAttack
	#elif state == States.SHOVE:	
	#	$enemySprite2D/AnimationPlayer.play('shoveEnemy')
	#	Global.attack = Global.trueAttack
	#	Global.health -= 0.2 * Global.enemyDamage
	elif state == States.ATTACK:	
		$enemySprite2D/AnimationPlayer.play('attackEnemy')
		await get_tree().create_timer(0.8).timeout
		if Global.parryTimeOver:
			Global.attack = Global.trueAttack
			Global.health -= Global.enemyDamage
			print("My HP: %d" % Global.health)
			print("Enemy HP: %d" % Global.enemyHealth)
			print("Click = Attack, F = Block, V = Shove, Shift = Dodge")
		else:
			pass
	elif state == States.DODGE:	
		$enemySprite2D/AnimationPlayer.play('dodgeEnemy')
		Global.attack = 0
	elif state == States.BLOCK:	
		$enemySprite2D/AnimationPlayer.play('blockEnemy')
		Global.attack = Global.trueAttack * defense * 0.5
	#elif state == States.blockedATTACK:	
	#	$enemySprite2D/AnimationPlayer.play('attackEnemy')
	#	Global.enemyDamage = 0
	elif state == States.HIT:	
		$enemySprite2D.modulate = Color(255, 0, 0, 50)
		print("My HP: %d" % Global.health)
		print("Enemy HP: %d" % Global.enemyHealth)
		print("Click = Attack, F = Block, V = Shove, Shift = Dodge")
		
	if Global.health < 0:
		Global.health = 0
	
	Global.attack = Global.trueAttack
		
func combo1():
	pass

func _ready():
	setState(States.IDLE)
	await get_tree().create_timer(1).timeout

func _process(delta):
	#$"../Timer".wait_time = rng.randf_range(1, 1.5)
	if enemyTimerCooldown:
		enemyTimerCooldown = false #Cooldown until enemyTimerCooldown == true
		$enemySprite2D/enemyTimer.start()
		var my_random_number = rng.randi_range(1, 4)
		if Global.enemyNewHealth < Global.enemyOldHealth:
			setState(States.HIT)
			Global.enemyOldHealth = Global.enemyNewHealth
		else:
			if my_random_number == 1:
				setState(States.IDLE)
			elif my_random_number == 2:
				setState(States.ATTACK)
			elif my_random_number == 3:
				setState(States.BLOCK)
			#elif my_random_number == 4:
				#if Global.blocked:
				#	setState(States.blockedATTACK)
				#elif !Global.blocked:
				#	setState(States.SHOVE) #Stun player if not blocked
			elif my_random_number == 4:
				setState(States.DODGE)

func _on_timer_timeout() -> void:
	enemyTimerCooldown = true
