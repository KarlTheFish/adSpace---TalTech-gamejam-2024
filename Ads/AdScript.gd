extends Node2D

var AdAmount: int
var AdLimit: int = 9
var AddAdsTime: float = 10.0 #Interval between possible new ads
var AdCheckTimer: Timer
var ad
var adInstance
var rng
var AdChance:int = 50 #Percent chance for ads to appear
var RandomNumber:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AdCheckTimer = get_node("Timer")
	AdCheckTimer.wait_time = AddAdsTime
	AdAmount = 0
	rng = RandomNumberGenerator.new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	if(AdAmount > AdLimit):
		AdCheckTimer.set_paused(true)
	else:
		AdCheckTimer.set_paused(false)
	
func _on_timer_timeout():
	RandomNumber = rng.randi_range(0, 100)
	
	if(RandomNumber > AdChance):
		ad = load("res://Ads/ad_1.tscn")
		adInstance = ad.instantiate()
		add_child(adInstance)
		
		########################## TODO: QUICK MAKESHIFT RANDOM POSITION GENERATOR BC I AM TOO LAZY TO FORMAT PROPERLY
		var a = RandomNumberGenerator.new()
		var randomPosX = a.randf_range(0, 600)
		var randomPosY = a.randf_range(0, 300)
		
		adInstance.set_position(Vector2(randomPosX, randomPosY))
		######################### TODO: DELETE AND REWORK LATER - KARL
		
		AdAmount = AdAmount + 1
