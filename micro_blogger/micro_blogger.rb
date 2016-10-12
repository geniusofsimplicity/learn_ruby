require "jumpstart_auth"

class MicroBlogger
	attr_reader :client

	def initialize
		puts "Initializing MicroBlogger"		
		@client = JumpstartAuth.twitter
	end

	def tweet(message)
		@client.update(message)	
	end

	def everyones_last_tweet
		friends = @client.friends
		friends.each do |friend|
			status = friend[:status] 
			puts "#{friend} said:"
			puts "- #{status}"
		end
	end

	def run
		command = ""
		until command == "q"
			printf "Enter command: "
			input = gets.chomp
			parts = input.split(" ")
			command = parts.first
			case command
			when "q" then puts "Goodbye!"
			when "elt" then	everyones_last_tweet
			end			
		end
	end
end

blogger = MicroBlogger.new
#blogger.tweet("MicroBlogger Initialised")
blogger.run