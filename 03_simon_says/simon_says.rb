#write your code here

def echo (word)
	word
end

def shout(word)
	word.upcase	
end

def repeat(*args)
	word = args[0]
	if args.size == 1
		answer = word + " " + word
	elsif args.size == 2
		n = args[1]
		answer = word
		if n > 0
			(n-1).times do
				answer = answer + " " + word
			end
		end
	else
		answer = " " + word
	end	
	
	answer
end

def start_of_word(line, length)
	line.slice(0, length)
end

def first_word(line)
	words = line.split(" ")
	words[0]
end
def titleize(line)
	words = line.split(" ")	
	new_line = ""
	i = 1
	if words.size > 1
		words.each do |word|
			if ((word == "and" || word == "over" || word == "the") && i != 1)
				
				new_line = new_line + " " + word.to_s						
			else
				word.capitalize!				
				new_line = new_line + " " + word.to_s						
			end
			i += 1
		end		
		new_line.lstrip
	else
		line.capitalize
	end
end