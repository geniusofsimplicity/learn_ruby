class Chess
	def setup(from, to)
		path = knight_moves(from, to).reverse
		@board = Board.new(path.clone)
		@board.draw
		puts "You made it in #{path.size - 1} moves!  Here's your path:"
		path.each{|m| p m}
	end

	def knight_moves(from, to)			
		@knight = Knight.new(from)		
		path = @knight.find_path(to)
		path_display = []
		path.each do |n|
			path_display << n.position			
		end
		path_display
	end

	class Board
		def initialize(path)			
			@board = Hash.new("o")
			@board[path.shift] = "s"
			@board[path.pop] = "f"
			path.each_index do |i|
				move = path[i]				
				@board[move] = i + 1
			end
		end

		def draw			
			8.times do |i|
				8.times do |j|
					print "#{@board[[i, j]]} "					
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
			def add_children(children)
				@children = children
				children.each{|ch| ch.parent = self}
			end
		end

		def initialize(position)
			@position = Node.new(position)
			@moves = []
		end

		def find_path(target_pos)
			quickest_target = build_moves(target_pos)		
			current_pos = quickest_target # nodes now
			path = []
			until current_pos.position == @position.position
				path << current_pos
				current_pos = current_pos.parent
			end
			path << current_pos
		end

		private	

		def build_moves(target_pos)
			current_pos = @position
			next_to_visit = []
			passed = {}
			until current_pos.position == target_pos
				moves = possible_moves(current_pos)				
				moves = exclude(moves, passed[current_pos]) # filter new moves to eliminate cycling
				passed[current_pos] ||= []
				passed[current_pos] << current_pos
				current_pos.add_children(moves)
				next_to_visit += moves
				current_pos = next_to_visit.shift
			end
			current_pos
		end

		def exclude(moves, passed)
			passed_values = []
			if passed
				passed.each do |p|
					passed_values << p.position				
				end			
				moves = moves.select do |m|
					!passed_values.include?(m.position)
				end
			end			
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
game.setup([3, 3], [4, 3])