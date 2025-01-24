extends CharacterBody2D

var timerCooldown := true # Allows for the first initial action with no cooldown
var inputsList := ["attack", "dodge", "shove", "block"]#, "idle", "hit"
#Set variable state to track current state

func setState(state):
	Global.blocked = false
	$charSprite2D/AnimationPlayer.play(state)
	if state == "idle":
		Global.enemyDamage = Global.trueAttack
	elif state == "shove":	
		Global.enemyDamage = Global.trueAttack
		Global.enemyHealth -= 0.2 * Global.attack
		Global.enemyNewHealth = Global.enemyHealth
	elif state == "attack":	
		Global.enemyDamage = Global.trueAttack
		Global.enemyHealth -= Global.attack
		Global.enemyNewHealth = Global.enemyHealth
	elif state == "dodge":	
		Global.enemyDamage = 0
	elif state == "block":	
		Global.blocked = true
		Global.enemyDamage = 0
		$charSprite2D/parryTimer.start()
	elif state == "hit":
		$charSprite2D.position = Vector2(10, 0)
		$charSprite2D.position = Vector2(0, 0)
		
	if Global.enemyHealth < 0:
		Global.enemyHealth = 0
	await get_tree().create_timer(0.5).timeout
	$charSprite2D/AnimationPlayer.play('idle')
	Global.enemyDamage = Global.trueAttack
	Global.blocked = false
	await get_tree().create_timer(0.2).timeout
# Called when the node enters the scene tree for the first time.

func _ready():
	$charSprite2D/AnimationPlayer.play('idle')

func _process(delta):
	for i in inputsList:
		if Input.is_action_just_pressed(i) and timerCooldown:
			timerCooldown = false #Cooldown until timerCooldown == true
			$charSprite2D/charTimer.start()
			setState(i)
		
func _on_timer_timeout() -> void:
	timerCooldown = true

func _on_parry_timer_timeout() -> void:
	Global.parryTimeOver = true
	print("parryTimeOver")
