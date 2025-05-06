extends CharacterBody2D

var timerCooldown := true # Allows for the first initial action with no cooldown
var inputsList := ["attack", "dodge", "shove", "block"]#, "idle", "hit"

func setState(state):
	$charSprite2D/AnimationPlayer.play(state)
	Global.enemyDamage = Global.enemyBaseAttack
	if state == "idle":
		pass
	elif state == "shove" and Global.enemyStunHP > 0 and Global.enemyBlocksYou == false: 
		Global.enemyStunHP -= 1
		if Global.enemyHealth > 0:
			Global.enemyHealth -= Global.charBaseAttack * Global.shoveMultiplier
			Global.enemyNewHealth = Global.enemyHealth
			Global.youShoveEnemy = true
	elif state == "attack" and Global.enemyHealth > 0:
			Global.enemyHealth -= Global.charBaseAttack / Global.enemyDefense
			Global.enemyNewHealth = Global.enemyHealth
	elif state == "dodge":
		Global.dodged = true
	elif state == "block":
		Global.blocked = true
		Global.defense = 9999
	
	if Global.enemyHealth <= 0: Global.enemyHealth = 0
	if Global.enemyStunHP <= 0: Global.enemyStunHP = 0
	
	await get_tree().create_timer(0.5).timeout
	$charSprite2D/AnimationPlayer.play('idle')
	Global.defense = Global.charBaseDef
	Global.blocked = false
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
