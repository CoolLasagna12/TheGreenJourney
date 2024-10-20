extends CharacterBody2D
var direction = Vector2.ZERO
var jump = 0
var stop = 0
var o = 0.0
var target_velocity = Vector2.ZERO
var checkpointList=[Vector2i(9,36),Vector2i(456,44),Vector2i(780,20)]
func _ready():
	self.position = checkpointList[ Vars.checkpoint ]
func _physics_process(delta):
	if stop == 0:
		if Input.is_action_pressed("ui_right"):
			direction.x = 1
			$Sprite.play("run")
			$Sprite.flip_h = false
		if Input.is_action_pressed("ui_left"):
			direction.x = -1
			$Sprite.play("run")
			$Sprite.flip_h = true
		if Input.is_action_just_released("ui_right",true):
			direction.x = 0
			if is_on_floor():
				$Sprite.play("idle")
		if Input.is_action_just_released("ui_left",true):
			if not Input.is_action_pressed("ui_right"):
				direction.x = 0
				if is_on_floor():
					$Sprite.play("idle")
		if Input.is_action_just_pressed("ui_up",true):
			if jump < 2:
				direction.y = -1
				jump += 1
		if is_on_floor():
			if direction.y == 0:
				jump = 0
			if direction.x == 0:
				$Sprite.play("idle")
		if direction.y == -1:
			target_velocity.y = -45
			direction.y = 0
		else:
			if not is_on_floor():
				target_velocity.y = target_velocity.y + (80 * delta)
		target_velocity.x = direction.x * 50
		velocity = Vector2i(target_velocity)
		move_and_slide()
	if self.position.x >= 1132 and stop == 0:
		stop = 1
		get_node("/root/Node2D/ColorTimer").start(0.1)
	elif self.position.x >= 45 and self.position.x < 1098:
		get_node("/root/Node2D/Camera2D").position.x = self.position.x - 45
	if self.position.x >= 788:
		Vars.checkpoint = 2
		get_node("/root/Node2D/Checkpoints/CP2").play("taken")
	elif self.position.x >= 464:
		Vars.checkpoint = 1
		get_node("/root/Node2D/Checkpoints/CP1").play("taken")
func kill(bod):
	if bod == self:
		$Sprite.play("die")
		get_tree().change_scene_to_file("res://Scenes/transi.tscn")
func _on_pics_1_body_entered(body):
	kill(body)
func _on_bottom_body_entered(body):
	kill(body)
func _on_pics_2_body_entered(body):
	kill(body)
func _on_pics_3_body_entered(body):
	kill(body)
func _on_pics_4_body_entered(body):
	kill(body)
func _on_pics_5_body_entered(body):
	kill(body)
func _on_color_timer_timeout():
	if o < 1:
		o += 0.05
		get_node("/root/Node2D/CanvasModulate").color = Color(1-o,1-o,1-o,1)
		get_node("/root/Node2D/ColorTimer").start(0.1)
	else:
		get_tree().change_scene_to_file("res://Scenes/end.tscn")
func _on_timer_timeout():
	Vars.time += 1
