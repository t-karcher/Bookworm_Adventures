extends Node2D

const TILESIZE = 64
const LETTERTILE = preload("res://LetterTile.tscn")

onready var LetterBox:Node2D = $LetterBox
onready var Word:Node2D = $Word
onready var MyTween:Tween = $MyTween

func _ready():
	fill_letterbox()

func fill_letterbox():
	randomize()
	for i in range(4):
		for j in range(4):
			var tile:LetterTile = LETTERTILE.instance()
			LetterBox.add_child(tile)
			var _err = tile.connect("tile_clicked", self, "on_tile_clicked", [tile])
			tile.position = Vector2(i * TILESIZE, j * TILESIZE)
			tile.box_position = tile.position

func on_tile_clicked(tile:LetterTile):
	var start_pos = tile.global_position
	if tile.get_parent().name == "LetterBox":
		LetterBox.remove_child(tile)
		Word.add_child(tile)
		tile.global_position = start_pos
	else:
		var remove_from_here : bool = false
		for t in Word.get_children():
			if t == tile: remove_from_here = true
			if remove_from_here: remove_tile(t)
	arrange_word_tiles()

func remove_tile(tile:LetterTile):
	var start_pos = tile.global_position
	Word.remove_child(tile)
	LetterBox.add_child(tile)
	# warning-ignore:return_value_discarded
	MyTween.interpolate_property(
		tile,
		"position",
		start_pos - LetterBox.position,
		tile.box_position,
		0.2)

func arrange_word_tiles():
	var letter_count = Word.get_child_count()
	for node_index in range(letter_count):
		# warning-ignore:return_value_discarded
		MyTween.interpolate_property(
			Word.get_child(node_index),
			"position",
			Word.get_child(node_index).position,
			Vector2((node_index - float(letter_count) / 2) * TILESIZE, 0),
			0.2)
	# warning-ignore:return_value_discarded
	MyTween.start()
