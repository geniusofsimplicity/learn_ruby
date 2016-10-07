require "json"

class Hangman
	def self.start		
		answer = ""
		loop do
			puts "Do you want to start a new game (n) or load a saved one(l)?"
			answer = gets.chomp
			break if answer == "n" || answer == "l"
		end
		case answer
		when "n" then return self.new("5desk.txt")
		when "l" then return self.load
		end
	end

	def play
		until @count == 0
			ask_to_save
			display_status
			letter = get_letter
			update_result(letter)
			if victory?	
				puts "Congratulations! You have won! The word was #{word}."
				break
			end
		end
		puts "Game over. The word was #{word}."
	end

	private

	def self.load
		puts "Type in the name of the file."
		filename = gets.chomp
		data = self.from_json(filename)
		self.new(nil, data["count"], data["word"], data["guess"])
	end

	def initialize(*args) #filename, count, word, guess
		if args.size == 1
			@count = 6
			@word = pick_word(args[0]).strip.scan(/./)
			@guess = Array.new(@word.size, "_")
		else
			@count = args[1]
			@word = args[2]
			@guess = args[3]
		end
	end	

	def ask_to_save
		answer = ""
		loop do
			puts "Do you want to save the game? (y/n)"
			answer = gets.chomp
			break if answer == "y" || answer == "n"
		end
		if answer == "y"
			save
		end
	end

	def save
		puts "Please, type in save filemane: "		
		filename = gets.chomp
		File.open(filename, "w") do |file|
			file.puts to_json
		end
	end

	def to_json
		JSON.dump({
			count: @count,
			word: @word,
			guess: @guess			
			})	
	end

	def self.from_json(filename)
		JSON.load(File.read(filename))
	end

	def victory?
		@word == @guess		
	end

	def get_letter
		puts "Type in a new letter."
		gets.chomp
	end

	def update_result(letter)
		correct_guess = false
		@word.each_index do |i|
			if @word[i] == letter
				correct_guess = true
				@guess[i] = letter
			end
		end
		@count -= 1 unless correct_guess
	end

	def display_status
		puts "You have #{@count} guess(es) left."
		display_guess
	end

	def word
		@word.join		
	end

	def display_guess
		#@guess.each{|l| print l}
		puts @guess.join
	end

	def pick_word(filename)
		words = File.readlines(filename)
		words = words.select {|w| (5..12) === w.strip.size}
		words.sample
	end
end

game = Hangman.start
game.play