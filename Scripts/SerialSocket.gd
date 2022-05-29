extends Node

const serial_res = preload("res://bin/gdserial.gdns")
var serial_port = serial_res.new()
var is_port_open = false
var text = ""
var pwin = 0

signal sobe
signal desce
signal potenciometro

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
	
	var command_array = message.split('-')
	if command_array.size() > 4:
		print(command_array)

		if command_array[3] == "SOBE":
			# Primeiro parâmentro: emitir o sinal Xaxis; Segundo parâmetro valor do Xaxis: 1 ou -1 (Direita ou esquerda);
			emit_signal("sobe", command_array[2]) 
			
			
		if str(command_array[3]) == "DESCE":
			emit_signal("desce", command_array[2])
			
		if command_array[1]:
			emit_signal("potenciometro", command_array[0], command_array[1])
			
		else:
			print('comando desconhecido...')
	else:
		write(pwin)	
		
func write(text):
	serial_port.write_text(str(text) + '\n')

func stop():
	serial_port.close_port()
	
