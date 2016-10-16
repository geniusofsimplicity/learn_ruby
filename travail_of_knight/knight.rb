class Chess
	def setup
		@board = Board.new
		@board.draw
		p knight_moves([3, 3], [4, 3]).reverse
	end

	def knight_moves(from, to)			
		@knight = Knight.new(from)
		@knight.build_moves
		path = @knight.find_path(to)
		path_display = []
		path.each do |n|
			path_display << n.position			
		end
		path_display
	end

	class Board
		def initialize(pos = nil)
			@board = Array.new(8, Array.new(8, "o"))

			@board[pos[0]][pos[1]] = "x" if pos			
		end

		def draw
			8.times do 
				8.times do
					print(" o")
				end
				puts				
			end			
		end
	end

	class Knight

		class Node
			attr_accessor :parent
			attr_reader :children, :position

			def initialize(position, parent = nil)
				@position = position
				@parent = parent
				@children = []
			end

			def add_child(new_child)
				@children << new_child
				new_child.parent = self
			end			
		end

		def initialize(position)
			@position = Node.new(position)
			@moves = []
		end

		def build_moves(current_pos = @position, passed = [@position], level = 0)			
			#puts "build_moves started!!!***" if current_pos == @position
			#puts "level #{level}"
			moves = possible_moves(current_pos)
			#puts "current_pos: #{current_pos.position}"
			#puts "moves:"
			#moves.each{|m| print "#{m.position} "}			
			#puts if moves.size > 0
			#puts "passed:"
			#passed.each{|p| print "#{p.position} "}
			#puts if passed.size > 0
			moves = exclude(moves, passed)
			#puts "moves after exclusion:"
			#moves.each{|m| print "#{m.position} "}
			#puts if moves.size > 0
			return if moves.size == 0
			moves.each do |move|
				passed1 = passed
				passed1 << move
				current_pos.add_child(move)
				build_moves(move, passed1.clone, level + 1)
			end
		end		

		def find_path(target_pos)
			target_pos = breadth_first_search(target_pos)
			current_pos = target_pos # nodes now
			path = []
			until current_pos.position == @position.position
				path << current_pos
				current_pos = current_pos.parent
			end
			path
		end

		private	

		def breadth_first_search(target_pos)
			current_pos = @position
			next_to_visit = []
			#puts "breadth_first_search:"
			while current_pos
				#p "current: #{current_pos.position}"
				#current_pos.children.each{|c| print "#{c.position}  "}
				#puts
				return current_pos if current_pos.position == target_pos
				next_to_visit += current_pos.children
				current_pos = next_to_visit.shift
			end			
		end

		def exclude(moves, passed)
			passed_values = []
			passed.each do |p|
				passed_values << p.position				
			end
			moves_to_exclude = []
			moves.each do |m|
				moves_to_exclude << m if passed_values.include?(m.position)
			end
			moves -= moves_to_exclude
			moves
		end

		def possible_moves(pos = @position)
			pos = pos.position
			res = []
			length = (0..7)
			res << Node.new([pos[0] + 1, pos[1] + 2]) if
				length === (pos[0] + 1) && length === (pos[1] + 2)
			res << Node.new([pos[0] + 2, pos[1] + 1]) if
				length === (pos[0] + 2) && length === (pos[1] + 1)
			res << Node.new([pos[0] - 1, pos[1] - 2]) if
				length === (pos[0] - 1) && length === (pos[1] - 2)
			res << Node.new([pos[0] - 2, pos[1] - 1]) if
				length === (pos[0] - 2) && length === (pos[1] - 1)
			res << Node.new([pos[0] + 1, pos[1] - 2]) if
				length === (pos[0] + 1) && length === (pos[1] - 2)
			res << Node.new([pos[0] - 1, pos[1] + 2]) if
				length === (pos[0] - 1) && length === (pos[1] + 2)
			res << Node.new([pos[0] + 2, pos[1] - 1]) if
				length === (pos[0] + 2) && length === (pos[1] - 1)
			res << Node.new([pos[0] - 2, pos[1] + 1]) if
				length === (pos[0] - 2) && length === (pos[1] + 1)
			res
		end		
	end
end

game = Chess.new
game.setup