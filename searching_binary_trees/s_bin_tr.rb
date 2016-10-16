class BinaryTree

	class Node
		attr_accessor :parent
		attr_reader :children, :value

		def initialize(value, parent = nil)
			@value = value
			@parent = parent
			@children = []
		end

		def add_child(new_child, pos)			
			@children[pos] = new_child
		end

		def get_children
			children = []
			children << self.children[0] if self.children[0]
			children << self.children[1] if self.children[1]
			children
		end
	end

	def build_tree(ary)
		@root_node = Node.new(ary.shift)
		ary.each do |v|
			node_as_parent = @root_node			
			while node_as_parent				
				if v <= node_as_parent.value
					if node_as_parent.children[0]
						node_as_parent = node_as_parent.children[0]						
					else
						node = Node.new(v, node_as_parent)
						node_as_parent.add_child(node, 0)
						break
					end
				else
					if node_as_parent.children[1]
						node_as_parent = node_as_parent.children[1]						
					else
						node = Node.new(v, node_as_parent)
						node_as_parent.add_child(node, 1)
						break
					end
				end				
			end
		end
	end

	def breadth_first_search(value)
		current_node = @root_node
		next_to_visit = []
		while current_node			
			return current_node if current_node.value == value
			next_to_visit << current_node.children[0] if current_node.children[0]
			next_to_visit << current_node.children[1] if current_node.children[1]
			current_node = next_to_visit.shift
		end
		nil
	end

	def depth_first_search(value)
		current_node = @root_node
		next_to_visit = []
		i = 0
		while current_node			
			puts i
			i += 1
			return current_node if current_node.value == value
			children = current_node.get_children
			if children.size > 0
				current_node = children.shift
				next_to_visit << children.shift if children.size > 0
			else
				current_node = next_to_visit.pop
			end			
		end
		nil
	end

	def dfs_rec(value, current_node = @root_node)
		return current_node if current_node.value == value
		children = current_node.get_children
		return nil if children.size == 0
		found = dfs_rec(value, children.shift)
		return found if found
		dfs_rec(value, children.shift) if children.size > 0		
	end

	def to_s
		current_node = @root_node
		next_to_visit = []
		level = 0
		count = 0
		puts "level: 0"
		parent_node = nil
		while current_node			
			print "(#{current_node.parent.nil? ? 'root' : current_node.parent.value}:#{current_node.value} ) | "
			next_to_visit << current_node.children[0] if current_node.children[0]
			next_to_visit << current_node.children[1] if current_node.children[1]
			current_node = next_to_visit.shift
			if current_node && current_node.parent != parent_node
				parent_node = current_node.parent				
				level += 1
				puts
				puts "level: #{level}"
			end
		end
	end
end

bt = BinaryTree.new
bt.build_tree([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
puts bt.dfs_rec(324)