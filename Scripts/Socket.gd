extends Node

var client
var connected = false
var text = ""

signal idle1
signal idle2
signal right
signal left
signal up
signal down
signal btn
signal btnRed
signal btnGreen

var ip = "192.168.1.106"
var port = 80


func _ready():
	client = StreamPeerTCP.new() 
	client.set_no_delay(true) 


func _exit_tree():
	disconnect_from_server()

	
func connect_to_server():
	var connect = client.connect_to_host(ip, port)	
	if client.is_connected_to_host():		
		connected = true
		print('conectei viu')		

func disconnect_from_server():
	connected = false
	client.disconnect_from_host()
	
func _process(delta):
	if connected and not client.is_connected_to_host():
		connected = false
	if client.is_connected_to_host():	
		leituraSocket()
		
func leituraSocket():
	while client.get_available_bytes() > 0:
		var msg = client.get_utf8_string(client.get_available_bytes())
		#print(msg)
		if msg == null:			
			continue
		if msg.length() > 0:
			for c in msg:
				if c == "\n":
					on_text_received(text)
					text = ""
				else:
					text += c
					
func on_text_received(text):
	var command_array = text.split('-')
	
	#print(command_array)
	
	if command_array.size() < 2:
		return
	
	if command_array[0] == "Idle":
		emit_signal("idle1", self)
	if command_array[0] == "Up":
		emit_signal("up", self)
	if command_array[0] == "Down":
		emit_signal("down", self)	
	if command_array[1] == "Idle":
		emit_signal("idle2", self)
	if command_array[1] == "Right":
		emit_signal("right", self)
	if command_array[1] == "Left":
		emit_signal("left", self)
	if command_array[2] == "1":
		emit_signal("btn", self)
	if command_array[3] == "1":
		emit_signal("btnRed", self)
	if command_array[4] == "1":
		emit_signal("btnGreen", self)
	else:
		pass
	

