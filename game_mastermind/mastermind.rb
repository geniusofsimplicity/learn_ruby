class Mastermind

	def self.setup_game
		puts "You are playing Mastermind game."		
		puts "Please, enter your name."
		name = gets.chomp				
		puts "Enter the colours you want to play with."
		colours = gets.chomp
		colours = colours.split
		code_breaker = CodeBreaker.new(name, colours)
		game = Mastermind.new(code_breaker, colours)
	end

	def start
		process_turns
	end

	class CodeBreaker
		def initialize(name, colours)
			@name = name
			@colours = colours
		end

		def move
			colours = false
			until colours
				puts "Please, enter correct colours."
				colours = get_colours	
			end
			colours
		end

		private

		def get_colours
			input = gets.chomp
			colours = input.split
			return false if colours.size != 4
			colours.each do |c|
				return false unless @colours.include?(c)
			end
			colours
		end
	end

	class CodeMaster
		def initialize(colours)
			gen_code(colours)
		end

		def get_feedback(colours)
			bulls = 0
			cows = 0
			colours_left = []
			code_left = []
			colours.each_index do |i|
				if colours[i] == @code[i]
					bulls += 1 
				else
					colours_left << colours[i]
					code_left << @code[i]
				end
			end
			colours_left.each do |c|
				if i = code_left.find_index(c)
					cows += 1
					code_left.delete_at(i)
				end
			end
			{bulls: bulls, cows: cows}
		end

		def print_code
			puts @code.inspect
		end

		private

		def gen_code(colours)
			@code = []
			4.times do
				@code << colours.sample
			end
			print_code
			22.times {puts}
		end
	end

	class Board
		attr_reader :colours
		Row = Struct.new(:move, :result)

		def initialize(colours)	
			@board = []
			@l_just = colours.max.size
			@colours = colours
		end

		def update(colours, feedback)
			@board << [colours, feedback]
		end

		def print
			@board.each_index do |i|
				row = @board[i]
				colours = row[0]
				feedback = row[1]
				puts "#{i + 1}: #{colours[0].ljust(@l_just + 2)} "\
						 					 "#{colours[1].ljust(@l_just + 2)} "\
						 					 "#{colours[2].ljust(@l_just + 2)} "\
						 					 "#{colours[3].ljust(@l_just + 2)} "\
						 					 "|| bulls: #{feedback[:bulls]}, cows: #{feedback[:cows]}"
			end		
		end
	end

	private

	def initialize(code_breaker, colours)
		@code_breaker = code_breaker
		@code_master = CodeMaster.new(colours)
		@board = Board.new(colours)		
	end

	def process_turns
		won = false
		12.times do |turn|
			puts "Turn #{turn}."
			@board.print
			current_colours = @code_breaker.move
			feedback = @code_master.get_feedback(current_colours)
			@board.update(current_colours, feedback)
			if feedback[:bulls] == 4
				won = true				
				break			
			end			
		end
		if won
			puts "Congratulations! You have won!"
		else
			puts "You have used all your attempts."\
				   " I wish you good luck in next game."
			@code_master.print_code
		end
	end
end

game = Mastermind.setup_game
game.start