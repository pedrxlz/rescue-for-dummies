extends Node

const serial_res = preload("res://bin/gdserial.gdns")
var serial_port = serial_res.new()
var is_port_open = false
var text = ""
var pwin = 0
var btn_flag = 0
var btnRed_flag = 0
var btnGreen_flag = 0

signal Xaxis
signal Yaxis
signal btn
signal btnRed
signal btnGreen

func _ready():
	is_port_open = serial_port.open_port('COM4', 9600)
	print(is_port_open)

func _process(delta):
	if is_port_open:
		var message = serial_port.read_text()
		if message.length() > 0:
			for i in message:
				if i != '\n':
					text += i
				else:
					#print(text)
					_text_received(text)
					text = ''

func _text_received(message):
	
	var command_array = message.split('.')
	if command_array.size() > 4:
		#print(command_array)
		
		if str(command_array[0]):
			emit_signal("Xaxis", command_array[0]) 

		if str(command_array[1]):
			emit_signal("Yaxis", command_array[1]) 
	
		if str(command_array[2]) == "1":
			if int(command_array[2]) != btn_flag:
				var ev = InputEventAction.new()
				ev.action = "dialogic"
				ev.pressed = true
				Input.parse_input_event(ev)

		if str(command_array[3]) == "1":
			if int(command_array[3]) != btnGreen_flag:
				emit_signal("btnGreen")
		
		if str(command_array[4]) == "1":
			if int(command_array[4]) != btnRed_flag:
				emit_signal("btnRed")
			
		btn_flag = int(command_array[2])
		btnRed_flag = int(command_array[4])
		btnGreen_flag = int(command_array[3])
	else:
		write(pwin)	
		
func write(text):
	serial_port.write_text(str(text) + '\n')

func stop():
	serial_port.close_port()
	
