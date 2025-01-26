extends CharacterBody2D

var rng = RandomNumberGenerator.new()

var enemyTimerCooldown := true # Allows for the first initial action with no cooldown
var enemyComboCooldown := true # Allows for the first initial combo with no cooldown

var statesList := ["idleEnemy", "shoveEnemy", "attackEnemy", "dodgeEnemy", "blockEnemy", "blockedATTACK"]
var combo := [[2, 4, 2, 4, 2, 4], [2, 4, 2, 2, 4]]
var comboNumbers = combo.size()
var currentCombo := [0]
var parryTime := 0.8
var attackCounter := 0

func setState(state):
	Global.attack = Global.charBaseAttack
	Global.enemyBlocksYou = false
	Global.blocked = false
	$enemySprite2D/AnimationPlayer.play(state)
	if state == "idleEnemy":
		pass
	elif state == "attackEnemy":	
		$enemySprite2D/parryTimer.start()
		$enemySprite2D.modulate = Color(0, 250, 0, 50)
	elif state == "dodgeEnemy":	
		$enemySprite2D.modulate = Color(0, 250, 0, 50)
		Global.attack = 0
	elif state == "blockEnemy":	
		$enemySprite2D.modulate = Color(0, 250, 0, 50)
		Global.enemyBlocksYou = true
		Global.attack = Global.charBaseAttack * Global.blockMultiplier
	#elif state == States.blockedATTACK:	
	#	$enemySprite2D/AnimationPlayer.play('attackEnemy')
	#	Global.enemyDamage = 0
	
func _ready():
	$enemySprite2D.modulate = Color(0, 250, 0, 50)
	setState("idleEnemy")
	print("Ready. 2 seconds!")
	await get_tree().create_timer(2).timeout
	currentCombo = combo[rng.randi_range(0, comboNumbers-1)]
	$enemySprite2D/enemyComboTimer.start()
	$enemySprite2D/enemyTimer.start()
	
func _process(_delta):
	if Global.enemyNewHealth < Global.enemyOldHealth:
		print("My HP: %d" % Global.health)
		print("Enemy HP: %d" % Global.enemyHealth)
		print("Click = Attack, F = Block, V = Shove, Shift = Dodge")
		if Global.youShoveEnemy:
			Global.youShoveEnemy = false
			setState("idleEnemy")
			Global.enemyOldHealth = Global.enemyNewHealth
		else:
			$enemySprite2D.modulate = Color(100, 0, 0, 50)
			Global.enemyOldHealth = Global.enemyNewHealth
		
func _on_timer_timeout() -> void:
	if attackCounter < currentCombo.size():
		var currentAttack = currentCombo[attackCounter]
		setState(statesList[currentAttack])
		attackCounter += 1
	else:
		setState("idleEnemy")
	$enemySprite2D/enemyTimer.start()

func _on_enemy_combo_timer_timeout() -> void:
	currentCombo = combo[rng.randi_range(0, comboNumbers-1)]
	$enemySprite2D/enemyComboTimer.start()
	attackCounter = 0

func _on_parry_timer_timeout() -> void:
	if Global.health <= 0:
		Global.health = 0
	else:
		if Global.blocked == false:
			Global.enemyDamage = Global.enemyBaseAttack
			Global.health -= Global.enemyDamage
