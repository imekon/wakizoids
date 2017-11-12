extends Node2D

onready var global = get_node("/root/global")
onready var scoreLabel = get_node("HUD/ScoreLabel")

var player

func _ready():
	randomize()
	player = global.getPlayerShip()
	player.set_pos(Vector2(512, 300))
	add_child(player)
	createRocks()
	createShips()
	add_child(global.getExplosion())
	set_fixed_process(true)
	
func randomRange(value):
	return randi() % value - value / 2

func createRocks():
	createRock("res://rock1.tscn", randomRange(200), randomRange(200), 1)
	createRock("res://rock2.tscn", randomRange(200), 600 + randomRange(200), 2)
	createRock("res://rock3.tscn", randomRange(200) + 1000, randomRange(200), 3)
	createRock("res://rock4.tscn", randomRange(200) + 1000, randomRange(200) + 600, 4)
	
	for i in range(20):
		createRandomRock("res://rock1.tscn", 1)
		createRandomRock("res://rock2.tscn", 2)
		createRandomRock("res://rock3.tscn", 3)
		createRandomRock("res://rock4.tscn", 4)
		createRandomRock("res://rock5.tscn", 5)
		createRandomRock("res://rock6.tscn", 6)
	
func createShips():
	createAlienShip()
	for i in range(4):
		createShip("res://boxship.tscn")

func createRandomRock(name, sub):
	createRock(name, randomRange(65536), randomRange(65536), sub)
	
func createRock(name, x, y, sub):
	var rock = load(name)
	var node = rock.instance()
	node.subRocks = sub
	node.set_pos(Vector2(x, y))
	node.add_to_group("rocks")
	add_child(node)
	
func createAlienShip():
	createShip("res://alienship.tscn")
	
func createShip(name):
	var ship = load(name)
	var node = ship.instance()
	node.set_pos(Vector2(randomRange(65536), randomRange(65536)))
	node.add_to_group("ships")
	add_child(node)
	
func setHUDScore():
	scoreLabel.set_text("Score: " + str(player.getScore()))

func _fixed_process(delta):
	setHUDScore()
	