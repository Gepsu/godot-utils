extends AudioStreamPlayer

const music_bus = "Music"
const effect_bus = "Effects"

enum PlayOrder {
	InOrder,
	Random,
}

var play_order: int
var playlist: Array[AudioStream]
var current_song: int

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	bus = music_bus
	finished.connect(play_next)

func play_through(playlist: Array[AudioStream], play_order: int = PlayOrder.InOrder) -> void:
	stop()
	self.play_order = play_order
	self.playlist = playlist
	current_song = -1
	play_next()

func play_next() -> void:
	if playlist.is_empty(): return
	if is_playing():
		var tween = create_tween()
		tween.tween_property(self, "volume_db", -80.0, 1)
		await tween.finished
		stop()
		volume_db = 0.0
	
	if playlist.size() > 1:
		match play_order:
			PlayOrder.InOrder: current_song = (current_song + 1) % playlist.size()
			PlayOrder.Random:
				var previous_song = current_song
				current_song = randi() % playlist.size()
				if current_song == previous_song:
					current_song = (current_song + 1) % playlist.size()
		
	stream = playlist[current_song]
	play()

func play_sound(sound: AudioStream, volume := 1.0) -> void:
	var sound_effects = AudioStreamPlayer.new()
	add_child(sound_effects)
	sound_effects.bus = effect_bus
	sound_effects.stream = sound
	sound_effects.volume_db = linear_to_db(volume)
	sound_effects.finished.connect(sound_effects.queue_free)
	sound_effects.play()

func play_directional_sound(sound: AudioStream, position: Vector2, volume := 1.0) -> void:
	var sound_effects = AudioStreamPlayer2D.new()
	add_child(sound_effects)
	sound_effects.bus = effect_bus
	sound_effects.stream = sound
	sound_effects.volume_db = linear_to_db(volume)
	sound_effects.finished.connect(sound_effects.queue_free)
	sound_effects.global_position = position
	sound_effects.play()
