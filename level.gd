extends Node2D

func _ready() -> void:	
	pass
	
func _process(_delta):
	#$MenUI.size = get_viewport().get_visible_rect().size
	
	$MenUI/charContainer/charHealth.text = "HP: %d" % Global.health
	$MenUI/enemyContainer/enemyHP.text = "HP: %d" % Global.enemyHealth

	$MenUI/charContainer/charAttack.text = "Atk: %d" % Global.charBaseAttack
	$MenUI/enemyContainer/enemyAttack.text = "Atk: %d" % Global.enemyBaseAttack

	$MenUI/charContainer/charDef.text = "Def: %d" % Global.defense
	$MenUI/enemyContainer/enemyDef.text = "Def: %d" % Global.enemyDefense

	$MenUI/charContainer/charAttackSpeed.text = "AtkSpd: %.2f" % Global.attackSpeed
	$MenUI/enemyContainer/enemyAttackSpeed.text = "AtkSpd: %.2f" % Global.enemyAttackSpeed

#func _input(event):
	#if event is InputEventMouseMotion:
		#print(event.position)
