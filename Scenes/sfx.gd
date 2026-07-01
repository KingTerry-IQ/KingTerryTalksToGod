extends AudioStreamPlayer
class_name TempleSFX

var phase: float = 0.0
var current_freq: float = 0.0
var remaining_samples: int = 0
var volume: float = 0.2  # Adjust for loudness (0.1–0.5 typical to avoid clipping)

func _ready():
	# Ensure generator is set up
	if not stream is AudioStreamGenerator:
		stream = AudioStreamGenerator.new()
		stream.mix_rate = 44100
		stream.buffer_length = 0.5
	play()  # Keep playing to allow buffer filling

func play_beep(freq: float = 440.0, duration_sec: float = 0.1, vol: float = 0.2):
	current_freq = freq
	remaining_samples = int(duration_sec * stream.mix_rate)
	phase = 0.0
	volume = vol

func _process(_delta):
	if remaining_samples <= 0:
		return
	
	var playback: AudioStreamGeneratorPlayback = get_stream_playback()
	var frames_available = playback.get_frames_available()
	if frames_available == 0:
		return
	
	var frames_to_fill = min(frames_available, remaining_samples)
	var buffer = PackedVector2Array()
	buffer.resize(frames_to_fill)
	
	var increment = 2.0 * PI * current_freq / stream.mix_rate
	
	for i in range(frames_to_fill):
		phase += increment
		# Square wave: sign of sine for perfect 50% duty cycle
		var sample = sign(sin(phase)) * volume
		buffer[i] = Vector2(sample, sample)  # Stereo (left/right identical)
	
	playback.push_buffer(buffer)
	remaining_samples -= frames_to_fill
	
	if remaining_samples <= 0:
		# Optional: Push silence briefly to clear clicks, or just stop
		pass
