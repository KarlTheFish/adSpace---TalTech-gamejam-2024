extends Node2D

## Interval between possible new ads.
@export_range(2.0, 20.0, 1.0) var time_between_ads: float = 3.0
## Percent chance for ads to appear when timer times out.
@export_range(0.0, 1.0, 0.1) var advert_spawn_chance: float = 0.5
@export var ad_check_timer: Timer

const ADVERT_LIMIT: int = 9
const ADVERT_SCENES: Array[PackedScene] = [
	#preload("res://ads/ads/empty_ad_01.tscn"),
	#preload("res://ads/ads/empty_ad_02.tscn")
	preload("res://ads/ads/casino_ad_01.tscn"),
	preload("res://ads/ads/casino_ad_02.tscn"),
	preload("res://ads/ads/earth_ad_01.tscn"),
	preload("res://ads/ads/earth_ad_02.tscn"),
	preload("res://ads/ads/fast_internet_ad_01.tscn"),
	preload("res://ads/ads/fast_internet_ad_02.tscn"),
	preload("res://ads/ads/foreign_ad_01.tscn"),
	preload("res://ads/ads/premium_ad_01.tscn"),
	preload("res://ads/ads/premium_ad_02.tscn"),
	preload("res://ads/ads/premium_ad_03.tscn"),
	preload("res://ads/ads/premium_ad_04.tscn"),
	preload("res://ads/ads/premium_ad_05.tscn"),
	preload("res://ads/ads/premium_ad_06.tscn"),
	preload("res://ads/ads/rocket_ad_01.tscn"),
	preload("res://ads/ads/rocket_ad_02.tscn"),
	preload("res://ads/ads/therapy_ad_01.tscn"),
	preload("res://ads/ads/therapy_ad_02.tscn")
]

var advert_amount: int = 0

func _ready() -> void:
	ad_check_timer.timeout.connect(_timer_done)
	ad_check_timer.wait_time = time_between_ads

func _process(delta: float) -> void:	
	if(advert_amount > ADVERT_LIMIT):
		ad_check_timer.set_paused(true)
	else:
		ad_check_timer.set_paused(false)
		
	#print(advert_amount)
	
func _timer_done():
	var f = randf()
	
	if(f <= advert_spawn_chance):
		adOpen()

		
func adClosed():
	advert_amount = advert_amount - 1
	
func adOpen():
	var random_advert = ADVERT_SCENES.pick_random()
	var advert_instance: BaseAdvertisement = random_advert.instantiate()

	# TODO: visibilitynotifier to detect whether it's in viewport bounds
	var rand_x = randi_range(0, 600)
	var rand_y = randi_range(0, 300)

	advert_instance.set_position(Vector2(rand_x, rand_y))
	add_child(advert_instance)

	advert_amount = advert_amount + 1
	
	if(random_advert == ADVERT_SCENES[1]):
		advert_instance.ok_button.pressed.connect(adOpen)
		
	advert_instance.tree_exiting.connect(adClosed)
