class Hangman
	def initialize(filename)
		@count = 6
		@word = pick_word(filename).strip.scan(/./)
		@guess = Array.new(@word.size, "_")	
		@correct = Array.new(@word.size)
	end	

	def start
		until @count == 0
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

game = Hangman.new("5desk.txt")
game.start