extends Node2D

func _ready() -> void:	
	print(get_tree())
	pass
	
func _process(_delta):
	#$MenUI.size = get_viewport().get_visible_rect().size
	#hi
	$MenUI/charContainer/charHealth.text = "HP: %d" % Global.health
	$MenUI/enemyContainer/enemyHP.text = "HP: %d" % Global.enemyHealth

	$MenUI/charContainer/charAttack.text = "Atk: %d" % Global.charBaseAttack
	$MenUI/enemyContainer/enemyAttack.text = "Atk: %d" % Global.enemyBaseAttack

	$MenUI/charContainer/charDef.text = "Def: %d" % Global.defense
	$MenUI/enemyContainer/enemyDef.text = "Def: %d" % Global.enemyDefense

	$MenUI/charContainer/charAttackSpeed.text = "AtkSpd: %.2f" % Global.attackSpeed
	$MenUI/enemyContainer/enemyAttackSpeed.text = "AtkSpd: %.2f" % Global.enemyAttackSpeed

	$MenUI/charContainer/charStun.text =  str(Global.blocked)
	$MenUI/enemyContainer/enemyStun.text = str(Global.enemyBlocksYou)
	
	$MenUI/charContainer/charHPBar.min_value = 0
	$MenUI/charContainer/charHPBar.max_value = Global.maxHealth
	$MenUI/charContainer/charHPBar.value = Global.health
	
	$MenUI/enemyContainer/enemyHPBar.min_value = 0
	$MenUI/enemyContainer/enemyHPBar.max_value = Global.enemyMaxHealth
	$MenUI/enemyContainer/enemyHPBar.value = Global.enemyHealth

	$MenUI/charContainer/charStunBar.min_value = 0
	$MenUI/charContainer/charStunBar.max_value = Global.charMaxStunHP
	$MenUI/charContainer/charStunBar.value = Global.charStunHP
	
	$MenUI/enemyContainer/enemyStunBar.min_value = 0
	$MenUI/enemyContainer/enemyStunBar.max_value = Global.enemyMaxStunHP
	$MenUI/enemyContainer/enemyStunBar.value = Global.enemyStunHP

func animate_fade():
	# Fade in fast (0 → 1 in 0.1s)
	$RichTextLabel/Node.tween_property(self, "modulate:a", 1.0, 0.1)
	# Wait 0.1s, then fade out slowly (1 → 0 in 0.6s)
	$RichTextLabel/Node.tween_interval(0.1)
	$RichTextLabel/Node.tween_property(self, "modulate:a", 0.0, 0.6)
	# Queue free when done
	$RichTextLabel/Node.tween_callback(self, "queue_free")

#func _input(event):
	#if event is InputEventMouseMotion:
		#print(event.position)
