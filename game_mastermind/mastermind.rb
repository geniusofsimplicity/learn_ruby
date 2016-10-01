class Mastermind

	def self.setup_game
		puts "You are playing Mastermind game."		
		puts "Please, enter your name."
		name = gets.chomp				
		puts "Enter the colours you want to play with."
		colours = gets.chomp
		colours = colours.split
		board = Board.new(colours)
		code = nil
		puts "Do you want to set the code? (y/n)"		
		if gets.chomp == "y"
			puts "You can enter the code below."
			code = Board.get_colours
		end
		code_master = nil
		if code
			code_master = CodeMaster.new({code: code})
		else
			code_master = CodeMaster.new({colours: colours})
		end
		code_master.print_code
		22.times {puts}
		code_breaker = CodeBreaker.new(name)
		game = Mastermind.new(code_breaker, code_master, board)
	end

	def start
		process_turns
	end

	class CodeBreaker
		def initialize(name)
			@name = name			
		end

		def move			
			colours = Board.get_colours
		end
	end

	class CodeMaster
		def initialize(mode)
			case
			when mode[:colours] then gen_code(mode[:colours])
			when mode[:code] 		then @code = mode[:code]
			else # TODO
			end			
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
			puts @code.join(" ")
		end

		private

		def gen_code(colours)
			@code = []
			4.times do
				@code << colours.sample
			end			
		end
	end

	class Board
		attr_reader :colours
		Row = Struct.new(:move, :result)

		def initialize(colours)	
			@board = []
			@l_just = colours.max.size
			@@colours = colours
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

		def self.get_colours
			colours = nil
			until colours
				puts "Please, enter correct colours (#{@@colours.join(" / ")})."
				input = gets.chomp
				colours = input.split
				unless colours.size == 4
					colours = nil
					next
				end
				colours.each do |c|
					unless @@colours.include?(c)
						colours = nil
						next
					end
				end
			end			
			colours
		end

	end

	private

	def initialize(code_breaker, code_master, board)
		@code_breaker = code_breaker
		@code_master = code_master
		@board = board		
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
		@board.print
		if won
			puts "Congratulations! You have won!"
		else
			puts "You have used all your attempts."\
				   " I wish you good luck in next games."			
		end		
		puts "The correct code is:"
		@code_master.print_code
	end
end

game = Mastermind.setup_game
game.start