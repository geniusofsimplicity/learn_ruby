require "socket"
require "json"

class PServer
	def initialize
		@server = TCPServer.new(2001)
	end

	def start
		puts "Server has started."
		params = {}
		loop do 
			client = @server.accept
			type_in, path, headers, body_in = parse(client.recvmsg.first)
			case type_in 
			when "GET" 
				init_line_out, headers, body_out = get_resource(path)
			when "POST"
				puts "json parsed: #{JSON.parse(body_in)}"
				params.merge!(JSON.parse(body_in))
				puts "params merged: #{params}"
				body_out = ""
				File.open("./thanks.html") do |file|
					body_out = file.readlines.join
				end
				body_out.gsub!("<%= yield %>", "<li>Name: #{params['viking']['name']}</li><li>Email: #{params['viking']['email']}</li>")
				init_line_out = "HTTP/1.0 200 OK"
				headers = []
				headers << "Content-Type: text/html"
				headers << "Content-Length: #{body_out.bytesize}"
			else
			end
			message = assemble_msg(init_line_out, headers, body_out)
			client.puts(message)		
			client.close
		end		
	end

	private

	def assemble_msg(init_line, headers, body)
		"#{init_line}\r\n#{headers.join("\n")}\r\n\r\n#{body}"
	end

	def get_resource(path)
		body = ""
		init_line = ""
		headers = []
		if path == "/index.html"			
			open("./index.html", "r") do |file|
				body = file.readlines.join
			end
			init_line = "HTTP/1.0 200 OK"
			headers << "Content-Type: text/html"
			headers << "Content-Length: #{body.bytesize}"
		else
			init_line = "HTTP/1.0 404 Not Found"
		end
		[init_line, headers, body]
	end

	def parse(message)
		puts "message: #{message}\n*******"
		lines = message.split("\r\n")
		init_line = lines.shift.split

		path = init_line[1]
		type = init_line[0]
		headers = []
		until (line = lines.shift) == ""
			headers << line
		end
		body = ""
		while line = lines.shift
			body << line			
		end
		[type, path, headers, body]
	end

end

server = PServer.new
server.start

