extends CharacterBody2D

var rng = RandomNumberGenerator.new()

var enemyTimerCooldown := true # Allows for the first initial action with no cooldown
var enemyComboCooldown := true # Allows for the first initial combo with no cooldown

var statesList := ["idleEnemy", "shoveEnemy", "attackEnemy", "dodgeEnemy", "blockEnemy", "blockedATTACK"]
var combo := [[2, 4, 4, 4, 2, 2], [2, 4, 2, 2, 4]]
var comboNumbers = combo.size()
var currentCombo := [0]
var parryTime := 0.8
var attackCounter := 0

func setState(state):
	Global.attack = Global.charBaseAttack 
	Global.enemyDefense = Global.enemyBaseDef
	Global.enemyBlocksYou = false
	$enemySprite2D/AnimationPlayer.play(state)
	if state == "idleEnemy":
		pass
	elif state == "attackEnemy":	
		$enemySprite2D/parryTimer.start()
		$enemySprite2D.modulate = Color(0, 250, 0, 50)
	elif state == "dodgeEnemy":	
		$enemySprite2D.modulate = Color(0, 250, 0, 50)
		Global.enemyDodgesYou = true
	elif state == "blockEnemy":	
		$enemySprite2D.modulate = Color(0, 250, 0, 50)
		Global.enemyDefense = 9999
		Global.attack = Global.charBaseAttack / Global.defense
	#elif state == States.blockedATTACK:	
	#	$enemySprite2D/AnimationPlayer.play('attackEnemy')
	#	Global.enemyDamage = 0
	
func _ready():
	$enemySprite2D.modulate = Color(0, 250, 0, 50)
	setState("idleEnemy")
	print("Ready. 1.5 seconds!")
	await get_tree().create_timer(1.5).timeout
	currentCombo = combo[rng.randi_range(0, comboNumbers-1)]
	$enemySprite2D/enemyComboTimer.start()
	$enemySprite2D/enemyTimer.start()
	
func _process(_delta):
	if Global.enemyNewHealth < Global.enemyOldHealth:
		if Global.youShoveEnemy:
			Global.youShoveEnemy = false
			setState("idleEnemy")
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
	$enemySprite2D.modulate = Color(0, 250, 0, 50)

func _on_enemy_combo_timer_timeout() -> void:
	currentCombo = combo[rng.randi_range(0, comboNumbers-1)]
	$enemySprite2D/enemyComboTimer.start()
	attackCounter = 0

func _on_parry_timer_timeout() -> void:
	if Global.health <= 0:
		Global.health = 0
	else:
		if Global.blocked == false:
			Global.health -= Global.enemyBaseAttack / Global.defense
