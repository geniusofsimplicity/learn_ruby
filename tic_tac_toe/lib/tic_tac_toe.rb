class TicTacToe

	def self.setup_game
		puts "What is the name of the first player?"
		player1 = Player.new(gets.chomp, "x")
		puts "What is the name of the second player?"
		player2 = Player.new(gets.chomp, "o")
		self.new(player1, player2)
	end

	def start
		operate
	end

	class Player
		attr_reader :name, :sign
		def initialize(name, sign)
			@name = name
			@sign = sign			
		end

		def to_s
			@name			
		end
	end

	private

	def initialize(player1, player2)
		@player1 = player1
		@player2 = player2
		@current_player = @player1		
		@board = {}		
	end

	# OPTIMIZE: Check for winning condition starting with the 5th turn
	def operate		
		9.times do |turn|
			puts "Turn #{turn}"
			print_board			
			move = get_move
			@board[move] = @current_player.sign			
			break if winner?
			end_of_turn
		end
		print_board
		if @winner
			puts "#{@winner}, you have won! Congratulations!!!"
		else
			puts "It is a draw."
		end
	end

	def get_move
		puts "#{@current_player.name}, it is your turn."
		puts "Please, give the coordinates for your move."
		move = nil
		loop do
			move = gets.chomp.split
			move = [move[0].to_i - 1, move[1].to_i - 1]
			if validate_move(move)
				break
			else
				puts "#That space is not free. Please, select a free space."
			end
		end		
		move
	end

	def validate_move(move)
		@board[move].nil?
	end

	def end_of_turn
		@current_player = @current_player == @player1 ? @player2 : @player1
	end

	def winner?
		sign = @current_player.sign
		result ||= @board.select{|k, v| k[0] == 0 && v == sign}.size == 3
		result ||= @board.select{|k, v| k[0] == 1 && v == sign}.size == 3
		result ||= @board.select{|k, v| k[0] == 2 && v == sign}.size == 3
		result ||= @board.select{|k, v| k[1] == 0 && v == sign}.size == 3
		result ||= @board.select{|k, v| k[1] == 1 && v == sign}.size == 3
		result ||= @board.select{|k, v| k[1] == 2 && v == sign}.size == 3
		if @board[[1, 1]] == sign
			result ||= (@board[[0, 0]] == sign && @board[[2, 2]] == sign)
			result ||= (@board[[0, 2]] == sign && @board[[2, 0]] == sign)
		end
		@winner = @current_player if result
	end

	def print_board
		puts "The board:"
		(0..2).each do |i|			
			(0..2).each do |j|
				print "|" if (1..2).include?(j)
				print @board[[i, j]] ? @board[[i, j]] : "_"
			end
			print "\n"
		end
	end
end

# game = TicTacToe.setup_game
# game.start