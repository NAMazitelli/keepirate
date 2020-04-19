extends KinematicBody2D
tool

#preview line
export (bool) var preview_ingame = true 
export (int) var preview_line_length = 5 setget set_preview_line_length
export (int) var preview_line_count = 10 setget set_preview_line_count

# BULLET PROPS
export (float) var bullet_angle = 180 setget set_bullet_angle
export (int) var bullet_gravity = 5 setget set_bullet_gravity
export (int) var bullet_speed = 8 setget set_bullet_speed
export (float) var bullet_delay = 0.5

var waited = 0
var directional_force = Vector2()
var shooting = false
var enabled = false
var move_angle_down = false
var move_angle_up = false

# BULLET NODES
export (PackedScene) var bullet_scene
export (NodePath) var bullet_spawn_path
onready var bullet_spawn = get_node(bullet_spawn_path)


func _ready():
	# SET BULLET FORCE
	update_directional_force()
	
	# ENABLE USER INPUT
	set_process_input(true)
	
	# ENABLE PROCESS
	set_process(true)
	
func _input(event):
	if(enabled):
		if (event.is_action_pressed("ui_select")):
			shooting = true
		elif (event.is_action_released("ui_select")):
			shooting = false
		elif (event.is_action_pressed("ui_up")):
			move_angle_up = true
		elif (event.is_action_released("ui_up")):
			move_angle_up = false

		elif (event.is_action_pressed("ui_down")):
			move_angle_down = true
		elif (event.is_action_released("ui_down")):
			move_angle_down = false
		
func _process(delta):
	if (shooting && waited > bullet_delay):
		fire_once()
		waited = 0
	elif (waited <= bullet_delay):
		waited += delta
	
	if move_angle_up:
		set_bullet_angle(bullet_angle + 1)
		update_directional_force()
	if move_angle_down:
		set_bullet_angle(bullet_angle - 1)
		update_directional_force()

func fire_once():
	shoot()
	shooting = false
	
func set_preview_line_length(value):
	preview_line_length = clamp(value, 0, 100)
	update()
	
func set_preview_line_count(value):
	preview_line_count = clamp(value, 0, 59)
	
func set_bullet_speed(value):
	bullet_speed = value
	update_directional_force()
	update()
	
func set_bullet_gravity(value):
	bullet_gravity = value
	update_directional_force()
	update()
	
# CANNON
func shoot():
	print("shot")
	var bullet = bullet_scene.instance()
	bullet.set_global_position(bullet_spawn.get_global_position())
	bullet.shoot(directional_force, bullet_gravity)
	get_parent().add_child(bullet)


# BULLET
func update_directional_force():
	var rad = deg2rad(bullet_angle) * sign(scale.x)
	directional_force = (Vector2(cos(rad), sin(rad)) * bullet_speed) 
	
func set_bullet_angle(value):
	bullet_angle = clamp(value, -359, 359)  
	update()

	
func _draw():
	if (preview_ingame):
		var start_pos = bullet_spawn.get_position()
		var prev_pos = start_pos
		
		for tick in range(1, preview_line_count):
			randomize()
			var color = Color(0.53, 0.81, 0.92)
			
			tick *= preview_line_length
			
			var x = tick * directional_force.x * sign(scale.x)
			var y = calc_y_position(tick) 
			var next_pos = start_pos + Vector2(x, y)
			draw_line(prev_pos, next_pos, color)
			prev_pos = next_pos
			
func calc_y_position(tick):
	if (tick != 0):
		return calc_y_position(tick-1) + (directional_force.y + (tick/60.0) * bullet_gravity)
	else:
		return 0

func _on_enable_cannon_body_entered(body):
	enabled = true
	
func _on_enable_cannon_body_exited(body):
	enabled = false
