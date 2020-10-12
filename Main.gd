extends Node2D

const TILESIZE = 64
const Letter = preload("res://LetterTile.tscn")

func _ready():
	randomize()
	for i in range(4):
		for j in range(4):
			var tile:LetterTile = Letter.instance()
			$LetterBox.add_child(tile)
			# warning-ignore:return_value_discarded
			tile.connect("tile_clicked", self, "on_tile_clicked", [tile])
			tile.position = Vector2(i * TILESIZE, j * TILESIZE)
			tile.box_position = tile.position

func on_tile_clicked(tile:LetterTile):
	var start_pos = tile.global_position
	if tile.get_parent().name == "LetterBox":
		$LetterBox.remove_child(tile)
		$Word.add_child(tile)
		tile.global_position = start_pos
	else:
		$Word.remove_child(tile)
		$LetterBox.add_child(tile)
		$Tween.interpolate_property(tile,"position", start_pos - $LetterBox.position, tile.box_position,0.2,Tween.TRANS_LINEAR)
	arrange_word_tiles()

func arrange_word_tiles():
	for node_index in range($Word.get_child_count()):
		$Tween.interpolate_property($Word.get_child(node_index), "position", $Word.get_child(node_index).position, Vector2((node_index - float($Word.get_child_count()) / 2) * TILESIZE, 0),0.2,Tween.TRANS_LINEAR)
	$Tween.start()
