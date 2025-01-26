extends Node

var attack = 10
var enemyBaseAttack = 10
var charBaseAttack = 2

var defense = 1
var health = 100
var maxHealth = 100
var speed = 1
var critMultiplier = 2
var blockMultiplier = 0.0000001
var shoveMultiplier = 0.2

var blocked = false
var canAttack = true
var parryTimeOver = true # Allows for the first initial parry with no cooldown
var enemyBlocksYou = false
var youShoveEnemy = false

var enemyDamage = 10
var enemyHealth = 100
var enemyMaxHealth = 100
var enemyOldHealth = 100
var enemyNewHealth = 100
