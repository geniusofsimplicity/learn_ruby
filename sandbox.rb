#!/usr/bin/ruby

def pr
	puts "it has worked"
	if $0 == __FILE__
		puts "I am a command line script now!"
	end
end