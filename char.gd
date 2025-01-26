extends CharacterBody2D

var timerCooldown := true # Allows for the first initial action with no cooldown
var inputsList := ["attack", "dodge", "shove", "block"]#, "idle", "hit"

func setState(state):
	Global.blocked = false
	$charSprite2D/AnimationPlayer.play(state)
	Global.enemyDamage = Global.enemyBaseAttack
	Global.attack = Global.charBaseAttack
	if state == "idle":
		pass
	elif state == "shove":	
		if Global.enemyHealth < 0:
			Global.enemyHealth = 0
		else:
			Global.attack = Global.charBaseAttack * Global.shoveMultiplier
			Global.enemyHealth -= Global.attack
			Global.enemyNewHealth = Global.enemyHealth
			Global.youShoveEnemy = true
		#print("My HP: %d" % Global.health)
		#print("Enemy HP: %d" % Global.enemyHealth)
		#print("Click = Attack, F = Block, V = Shove, Shift = Dodge")
	elif state == "attack":	
		if Global.enemyHealth <= 0:
			Global.enemyHealth = 0
		else:
			if Global.enemyBlocksYou == true:
				Global.attack = Global.charBaseAttack * Global.blockMultiplier
			else:
				Global.attack = Global.charBaseAttack
			Global.enemyHealth -= Global.attack
			Global.enemyNewHealth = Global.enemyHealth
		#print("My HP: %d" % Global.health)
		#print("Enemy HP: %d" % Global.enemyHealth)
		#print("Click = Attack, F = Block, V = Shove, Shift = Dodge")
	elif state == "dodge":	
		Global.enemyDamage = 0
	elif state == "block":	
		Global.blocked = true
		Global.enemyDamage = 0
	elif state == "hit":
		$charSprite2D.position = Vector2(10, 0)
		$charSprite2D.position = Vector2(0, 0)
		
	await get_tree().create_timer(0.5).timeout
	$charSprite2D/AnimationPlayer.play('idle')
	await get_tree().create_timer(0.2).timeout

func _ready():
	$charSprite2D/AnimationPlayer.play('idle')

func _process(_delta):
	for i in inputsList:
		if Input.is_action_just_pressed(i) and timerCooldown:
			timerCooldown = false #Cooldown until timerCooldown == true
			$charSprite2D/charTimer.start()
			setState(i)
		
func _on_timer_timeout() -> void:
	timerCooldown = true
