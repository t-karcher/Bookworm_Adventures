extends Node2D
class_name LetterTile

# Letter sprites by Kenney.nl
# https://opengameart.org/content/letter-tiles

var current_tile: int
var box_position: Vector2
signal tile_clicked

func _ready():
	current_tile = randi() % 27
	$Tiles.frame = current_tile

func _on_ClickableArea_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		emit_signal("tile_clicked")
