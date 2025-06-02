extends Control

var time_left : int = 0
var session_time_start_value : int = 0
var is_running : bool = false

@onready var timer_label = $MarginContainer/VBoxContainer/VBoxTimerDisplayContainer/TimerDisplay
@onready var minutes_input = $MarginContainer/VBoxContainer/VBoxTimerDisplayContainer/HBoxContainer/MinutesValue
@onready var seconds_input = $MarginContainer/VBoxContainer/VBoxTimerDisplayContainer/HBoxContainer2/SecondsValue
@onready var timer_node = $Timer

func _ready() -> void:
	update_timer_display()
	$MarginContainer/VBoxContainer/VBoxButtonContainer/START.pressed.connect(start_timer)
	$MarginContainer/VBoxContainer/VBoxButtonContainer/PAUSE.pressed.connect(pause_timer)
	$MarginContainer/VBoxContainer/VBoxButtonContainer/RESET.pressed.connect(reset_timer)
	$MarginContainer/VBoxContainer/VBoxTimerDisplayContainer/SET_TIMER.pressed.connect(set_timer)
	timer_node.timeout.connect(on_timer_tick)

func update_timer_display() -> void:
	var minutes = time_left / 60
	var seconds = time_left % 60
	
	timer_label.text = "%02d:%02d" % [minutes, seconds]

func start_timer() -> void:
	if not is_running and time_left > 0: 
		is_running = true
		timer_node.start()

func pause_timer() -> void:
	if is_running:
		is_running = false
		timer_node.stop()

func reset_timer() -> void:
	is_running = false
	timer_node.stop()
	time_left = session_time_start_value
	update_timer_display()

func on_timer_tick() -> void:
	if time_left > 0:
		time_left -= 1
		update_timer_display()
	else:
		is_running = false
		timer_node.stop()

func set_timer() -> void:
	var minutes = minutes_input.value
	var seconds = seconds_input.value
	
	time_left = int(minutes) * 60 + int(seconds)
	session_time_start_value = time_left
	
	update_timer_display()
