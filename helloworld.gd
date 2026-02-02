extends Node2D

var text = "HELLO WORLD"

func _ready():
	var start_x = 100
	for i in text.length():
		var letter = text[i]
		
		var body = RigidBody2D.new()
		body.position = Vector2(start_x + i * 50, 200)
		
		var collision = CollisionShape2D.new()
		var shape = RectangleShape2D.new()
		shape.extents = Vector2(20, 20)
		collision.shape = shape
		body.add_child(collision)
		
		var label = Label.new()
		label.text = letter
		label.set("theme_override_colors/font_color", Color(1, 1, 1))
		label.set("theme_override_font_sizes/font_size", 32)
		label.position = Vector2(-16, -16)
		body.add_child(label)
		
		add_child(body)
