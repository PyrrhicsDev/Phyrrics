extends Node

var enemyBaseAttack = 10
var charBaseAttack = 4
var enemyBaseDef = 2
var charBaseDef = 1

var attack = 10
var defense = 1
var health = 100
var maxHealth = 100
var attackSpeed = 0.8
var charStunHP = 3
var charMaxStunHP = 3

var critMultiplier = 2
var shoveMultiplier = 0.2

var blocked = false
var dodged = false
var canAttack = true
var parryTimeOver = true # Allows for the first initial parry with no cooldown
var enemyBlocksYou = false
var enemyDodgesYou = false
var enemyShovesYou = false
var youShoveEnemy = false

var enemyDamage = 10
var enemyHealth = 100
var enemyMaxHealth = 100
var enemyOldHealth = 100
var enemyNewHealth = 100
var enemyAttackSpeed = 1
var enemyDefense = 2
var enemyStunHP = 3
var enemyMaxStunHP = 3
