extends Panel

var score
var total

var words
var current_word
var change_word

var red = Color(1, 0, 0)
var green = Color(0, 1, 0)
var white = Color(1, 1, 1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Answer.grab_focus()
	words = load_words()
	load_new_word()
	score = 0
	total = 0
	change_word = false

func load_new_word():
	current_word = words.pick_random()
	$CenterContainer/VBoxContainer/Kana.text = current_word["kana"]
	$CenterContainer/VBoxContainer/Kanji.text = current_word["kanji"]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_answer_text_submitted(new_text: String) -> void:
	if change_word:
		$Answer.text = ""
		$CenterContainer/VBoxContainer/Translation.text = ""
		load_new_word()
		change_word = false
	else:
		var clean_entry = new_text.strip_edges()
		var answer = current_word["translation"].strip_edges()
		
		if clean_entry == answer:
			$CenterContainer/VBoxContainer/Translation.label_settings.font_color = green
			score += 1
		else:
			$CenterContainer/VBoxContainer/Translation.label_settings.font_color = red
		$CenterContainer/VBoxContainer/Translation.text = answer
		total += 1
		update_score()
		change_word = true
		print(clean_entry, " ", answer)

func update_score():
	$Score.text = str(score) + "/" + str(total)

func load_words():
	var file = FileAccess.open("res://kanji.json", FileAccess.READ)
	var content = file.get_as_text()
	
	var json = JSON.new()
	var error = json.parse(content)
	if error == OK:
		var data = json.data
		return data
