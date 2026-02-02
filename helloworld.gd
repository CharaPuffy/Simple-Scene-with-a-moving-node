extends Node2D

var dragged_body: RigidBody2D = null

func _ready():
	# Create a floor
	var floor_body = StaticBody2D.new()
	var floor_shape = CollisionShape2D.new()
	floor_shape.shape = RectangleShape2D.new()
	floor_shape.shape.extents = Vector2(400, 20)  # width, height
	floor_body.position = Vector2(400, 500)       # place near bottom
	floor_body.add_child(floor_shape)
	add_child(floor_body)

	# Generate letters
	var text = "HELLO WORLD"
	var x = 100
	for c in text:
		var letter = RigidBody2D.new()
		var shape = CollisionShape2D.new()
		shape.shape = RectangleShape2D.new()
		shape.shape.extents = Vector2(20, 20)      # simple box collider
		letter.add_child(shape)

		var label = Label.new()
		label.text = str(c)
		label.position = Vector2(-10, -10)         # center text
		letter.add_child(label)

		letter.position = Vector2(x, 100)
		add_child(letter)
		x += 40

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			var query = PhysicsPointQueryParameters2D.new()
			query.position = event.position
			query.collide_with_areas = false
			query.collide_with_bodies = true

			var space_state = get_world_2d().direct_space_state
			var result = space_state.intersect_point(query)

			if result.size() > 0 and result[0].collider is RigidBody2D:
				dragged_body = result[0].collider
				dragged_body.linear_velocity = Vector2.ZERO
				dragged_body.angular_velocity = 0
				dragged_body.gravity_scale = 0
		elif not event.pressed and event.button_index == MOUSE_BUTTON_LEFT and dragged_body:
			dragged_body.gravity_scale = 1
			dragged_body = null

	elif event is InputEventMouseMotion and dragged_body:
		dragged_body.global_position = event.position
