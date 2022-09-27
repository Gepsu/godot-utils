class_name AreaSound extends Polygon2D

# Plays sounds in certain areas when the node that is being followed enters them

@export var sound: AudioStream
@export_enum("Master", "Music", "Effect", "Ambience") var bus: int = 3
@export var volume: float = 0.0 # ranges from -80 to +6 for some reason
@export_range(0.0, 60.0) var fade_in = 1.0
@export_range(0.0, 60.0) var fade_out = 5.0

@onready var following_node: Node2D
var stream: AudioStreamPlayer
var tween: Tween
var playing: bool = false:
	set(yes):
		if playing != yes:
			playing = yes
			if tween: tween.kill()
			tween = create_tween()
			tween.tween_property(stream, "volume_db", volume if yes else -80.0, \
								fade_in if yes else fade_out).set_trans(Tween.TRANS_EXPO)

func _ready() -> void:
	if polygon.is_empty():
		queue_free()
	
	stream = AudioStreamPlayer.new()
	stream.stream = sound
	stream.volume_db = -80.0
	stream.bus = AudioServer.get_bus_send(bus)
	add_child(stream)
	stream.play()

func set_following(what: Node2D) -> void:
	following_node = what

func _process(delta: float) -> void:
	if is_instance_valid(following_node):
		self.playing = Geometry2D.is_point_in_polygon(following_node.position, polygon)
