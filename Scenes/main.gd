extends Control

const VOCAB_PATH: String = "res://Assets/Words/Vocab.txt"
const HAPPY_PATH: String = "res://Assets/Words/Happy.txt"
const PASSAGE_PATH: String = "res://Assets/Words/NumBible.txt"
const PASSAGE_LINES: int = 5

@onready var milli_label : Label = $ColorRect/CenterContainer/Panel/VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/Milliseconds
@onready var god_says_label : RichTextLabel = $ColorRect/CenterContainer/Panel/VBoxContainer/MarginContainer/VBoxContainer/GodSays

@onready var song_audio_player : AudioStreamPlayer = $Song
@onready var sfx_player: TempleSFX = $SFX
@onready var song_player: AudioStreamPlayer = $Song

var vocab_lines : PackedStringArray = []
var happy_lines : PackedStringArray = []
var passage_lines : PackedStringArray = []

const BIBLE_BOOKS: Array[String] = [
	"Genesis", 
	"Exodus", 
	"Leviticus", 
	"Numbers", 
	"Deuteronomy", 
	"Joshua", 
	"Judges", 
	"Ruth", 
	"1 Samuel", \
	"2 Samuel", 
	"1 Kings", 
	"2 Kings",
	"1 Chronicles",
	"2 Chronicles",
	"Ezra",
	"Nehemiah",
	"Esther",
	"Job",
	"Psalms",
	"Proverbs",
	"Ecclesiastes",
	"Song of Songs",
	"Isaiah",
	"Jeremiah",
	"Lamentations",
	"Ezekiel",
	"Daniel",
	"Hosea",
	"Joel",
	"Amos",
	"Obadiah",
	"Jonah",
	"Micah",
	"Nahum",
	"Habakkuk",
	"Zephaniah",
	"Haggai",
	"Zechariah",
	"Malachi",
	"Matthew",
	"Mark",
	"Luke",
	"John",
	"Acts",
	"Romans",
	"1 Corinthians",
	"2 Corinthians",
	"Galatians",
	"Ephesians",
	"Philippians",
	"Colossians",
	"1 Thessalonians",
	"2 Thessalonians",
	"1 Timothy",
	"2 Timothy",
	"Titus",
	"Philemon",
	"Hebrews",
	"James",
	"1 Peter",
	"2 Peter",
	"1 John",
	"2 John",
	"3 John",
	"Jude",
	"Revelation",
]

const BIBLE_BOOKS_LINES: Array[int] = [
	297,
	5068,
	9123,
	12005,
	15977,
	19168,
	21329,
	23598,
	23902,
	26892,
	29345,
	32241,
	34961,
	37633,
	40756,
	41671,
	42963,
	43605,
	46190,
	53793,
	56267,
	56966,
	57332,
	61806,
	66736,
	67217,
	71804,
	73189,
	73876,
	74130,
	74615,
	74697,
	74860,
	75241,
	75416,
	75604,
	75806,
	75932,
	76684,
	76908,
	79970,
	81941,
	85266,
	87803,
	90914,
	92110,
	93323,
	94088,
	94514,
	94869,
	95153,
	95402,
	95647,
	95772,
	96090,
	96320,
	96440,
	96500,
	97370,
	97687,
	97976,
	98163,
	98506,
	98552,
	98597,
	98684,
	100111,
]

var seed_int : int = 0
var random : RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	await RenderingServer.frame_post_draw
	var game_name = ProjectSettings.get_setting("application/config/name")
	DisplayServer.window_set_title(game_name, get_window().get_window_id())
	
	
	var vocab_file: FileAccess = FileAccess.open(VOCAB_PATH, FileAccess.READ)
	while not vocab_file.eof_reached():
		var line: String = vocab_file.get_line().strip_edges()
		if line.length() > 0:
			vocab_lines.append(line)
	vocab_file.close()
	var happy_file: FileAccess = FileAccess.open(HAPPY_PATH, FileAccess.READ)
	while not happy_file.eof_reached():
		var line: String = happy_file.get_line().strip_edges()
		if line.length() > 0:
			happy_lines.append(line)
	happy_file.close()
	var passage_file: FileAccess = FileAccess.open(PASSAGE_PATH, FileAccess.READ)
	while not passage_file.eof_reached():
		var line: String = passage_file.get_line().strip_edges()
		passage_lines.append(line) #Do not skip the blank lines
	passage_file.close()
	await get_tree().create_timer(1).timeout
	song_player.play()
	
func _process(_delta: float) -> void:
	var now_unix = Time.get_unix_time_from_system()
	
	seed_int = int(now_unix * 1000.0)
	milli_label.text = str(seed_int)

	if Input.is_action_just_pressed("GodWordHappy"):
		_on_happy_word_pressed()
	elif Input.is_action_just_pressed("GodPassage"):
		_on_passage_pressed()
	elif Input.is_action_just_pressed("GodWord"):
		_on_vocab_word_pressed()
	elif Input.is_action_just_pressed("Clear"):
		_on_clear_pressed()
	elif Input.is_action_just_pressed("Copy"):
		_on_copy_to_clipboard_pressed()



func _on_vocab_word_pressed() -> void:
	random.seed = seed_int
	god_says_label.add_text(vocab_lines[random.randi() % vocab_lines.size()] + " ")
	sfx_player.play_beep(300, 0.025, 0.05)


func _on_happy_word_pressed() -> void:
	random.seed = seed_int
	god_says_label.add_text(happy_lines[random.randi() % happy_lines.size()] + " ")
	sfx_player.play_beep(300, 0.025, 0.05)


func _on_passage_pressed() -> void:
	random.seed = seed_int
	var start_index: int = random.randi()
	var start_str: String = passage_lines[start_index % passage_lines.size()]
	
	
	while start_str != "":
		start_index += 1
		start_str = passage_lines[start_index % passage_lines.size()]
		
	var book: String = _get_bible_book_from_start_line(start_index)
	god_says_label.add_text(book)
	
	var end_str: String = ""
	var end_index: int = 0
	for i in range(start_index, start_index + randi_range(10, 15)):
		var god_says_line: String = passage_lines[i % passage_lines.size()]
		god_says_label.add_text("\n" + god_says_line)
		end_str = god_says_line
		end_index = i
	while end_str != "":
		end_index += 1
		var god_says_line: String = passage_lines[end_index % passage_lines.size()]
		god_says_label.add_text("\n" + god_says_line)
		end_str = god_says_line
	sfx_player.play_beep(300, 0.4, 0.05)


func _on_clear_pressed() -> void:
	god_says_label.text = ""
	sfx_player.play_beep(500, 0.1, 0.05)


func _on_copy_to_clipboard_pressed() -> void:
	DisplayServer.clipboard_set(god_says_label.get_parsed_text())
	sfx_player.play_beep(1200, 0.1, 0.1)
	
func _get_bible_book_from_start_line(start_line: int) -> String:
	var starting_line_adjusted = start_line % passage_lines.size()
	var current_comparing_index: int = 0
	if starting_line_adjusted < BIBLE_BOOKS_LINES[0]: 
		return ""
	while starting_line_adjusted > BIBLE_BOOKS_LINES[current_comparing_index] && current_comparing_index < BIBLE_BOOKS_LINES.size() - 1:
		current_comparing_index += 1
		if starting_line_adjusted < BIBLE_BOOKS_LINES[current_comparing_index]:
			return BIBLE_BOOKS[current_comparing_index - 1]
	return ""
