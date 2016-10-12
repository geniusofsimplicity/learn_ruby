require "socket"
require "json"

host = "localhost"
port = 2001
path = "/index.html"

puts "What type of request do you want to send? (GET/POST)"
type = gets.chomp
case type 
when "GET"
	initial_line = "GET #{path} HTTP/1.0"	
	headers_to = ["From: Pasha", "User-agent: Pasha/0.1Gold"]
	body_to = "new body is here"	
when "POST"
	puts "Enter a name for the viking you want to register for raid."
	name = gets.chomp
	puts "Enter viking's email"
	email = gets.chomp
	hash_to_send = {viking: {name: name, email: email}}
	body_to = hash_to_send.to_json	
	initial_line = "POST #{path} HTTP/1.0"	
	headers_to = ["From: Pasha", "User-agent: Pasha/0.1Gold",
		"Content-Type: application/x-www-form-urlencoded",
		"Content-Length: #{body_to.bytesize}"]
end
request = "#{initial_line}\r\n#{headers_to.join("\r\n")}\r\n\r\n#{body_to}"
puts "the request:\n#{request}"

socket = TCPSocket.open(host, port)
socket.print(request)

response = socket.read

headers, body = response.split("\r\n\r\n", 2)
puts headers
puts
puts body