extends Control

var data

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	data = load_words()
	var row = load("res://wordlist/row.tscn")
	
	for word in data:
		var new_row = row.instantiate()
		new_row.get_node("Title/Kanji").text = word['kanji']
		new_row.get_node("Title/Kana").text = word['kana']
		new_row.get_node("Title/Translation").text = word['translation']
		$VBoxContainer/ScrollContainer/Table.add_child(new_row)
		print(word)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func load_words():
	var file = FileAccess.open("res://kanji.json", FileAccess.READ)
	var content = file.get_as_text()
	
	var json = JSON.new()
	var error = json.parse(content)
	if error == OK:
		var data = json.data
		return data
