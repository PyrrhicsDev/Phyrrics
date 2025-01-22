extends CharacterBody2D

#enum States {ATTACK, DODGE, SHOVE, BLOCK, IDLE, HIT} 
var inputsList = ["attack", "dodge", "shove", "block"]#, "idle", "hit"
#Enums for different states 
#Set variable state to track current state
###########################################################
var can_act = true  # Flag to check if an action can be performed

###########################################################

func setState(state):
###########################################################
	if !can_act: 
		return
	
	can_act = false
###########################################################
	
	if state == "idle":
		Global.blocked = false
		$charSprite2D/AnimationPlayer.play('idleChar')
		Global.enemyDamage = Global.trueAttack
	elif state == "shove":	
		Global.blocked = false
		$charSprite2D/AnimationPlayer.play('shoveChar')
		Global.enemyDamage = Global.trueAttack
		Global.enemyHealth -= 0.2 * Global.attack
		Global.enemyNewHealth = Global.enemyHealth
		if Global.enemyHealth < 0:
			Global.enemyHealth = 0
	elif state == "attack":	
		Global.blocked = false
		Global.enemyDamage = Global.trueAttack
		$charSprite2D/AnimationPlayer.play('attackChar')
		Global.enemyHealth -= Global.attack
		Global.enemyNewHealth = Global.enemyHealth
		if Global.enemyHealth < 0:
			Global.enemyHealth = 0
	elif state == "dodge":	
		Global.blocked = false
		$charSprite2D/AnimationPlayer.play('dodgeChar')
		Global.enemyDamage = 0
	elif state == "block":	
		Global.blocked = true
		$charSprite2D/AnimationPlayer.play('blockChar')
		Global.enemyDamage = 0
	elif state == "hit":
		$charSprite2D.position = Vector2(10, 0)
		$charSprite2D.position = Vector2(0, 0)
	can_act = true
	await get_tree().create_timer(0.5).timeout
	$charSprite2D/AnimationPlayer.play('idleChar')
	await get_tree().create_timer(0.1).timeout
# Called when the node enters the scene tree for the first time.
func _ready():
	$charSprite2D/AnimationPlayer.play('idleChar')

func _unhandled_input(event: InputEvent) -> void: 
	for i in inputsList:
		if Input.is_action_just_pressed(i):
			setState(i)
