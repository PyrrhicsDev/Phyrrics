extends CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	#position = Vector2(100, 500)
	$charSprite2D/AnimationPlayer.play('idleChar')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta): #underscore before delta to not use it if it's useless
	if Input.is_action_just_pressed("attack"):
		$charSprite2D/AnimationPlayer.play('attackChar')
	if Input.is_action_just_pressed("dodge"):
		$charSprite2D/AnimationPlayer.play('dodgeChar')
	if Input.is_action_just_pressed("shove"):
		$charSprite2D/AnimationPlayer.play('shoveChar')
	if Input.is_action_just_pressed("block"):
		$charSprite2D/AnimationPlayer.play('blockChar')
	#move_and_slide()

	#Shoot Input
	#if Input.is_action_just_pressed("Player_Action") and canAttack:
		#Get global position instead of relative position to parent node
	#	laser.emit($laserStart.global_position)
	#	canAttack = false
	#	$laserTime.start()
	#	$laserSound.play()

#func playCollisionSound():
	#$collisionSound.play() 
