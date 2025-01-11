extends CharacterBody2D
#test push
var rng = RandomNumberGenerator.new()
func _ready():
	$enemySprite2D/AnimationPlayer.play('idleEnemy')
	$"../Timer".wait_time = 2
	$"../Timer".start() 

func _on_timer_timeout() -> void:
	$"../Timer".wait_time = rng.randf_range(1, 1.5)
	var my_random_number = rng.randi_range(1, 5)
	if my_random_number == 1:
		$enemySprite2D/AnimationPlayer.play('idleEnemy')
	elif my_random_number == 2:
		$enemySprite2D/AnimationPlayer.play('shoveEnemy')
	elif my_random_number == 3:
		$enemySprite2D/AnimationPlayer.play('blockEnemy')
	elif my_random_number == 4:
		$enemySprite2D/AnimationPlayer.play('attackEnemy')
	elif my_random_number == 5:
		$enemySprite2D/AnimationPlayer.play('dodgeEnemy')	
	pass # Replace with function body.
