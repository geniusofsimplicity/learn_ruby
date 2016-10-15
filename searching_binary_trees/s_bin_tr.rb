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

	def to_s
		current_node = @root_node
		next_to_visit = []
		level = 0
		count = 0
		puts "level: 0"
		while current_node			
			print "(#{current_node.parent.nil? ? 'root' : current_node.parent.value}:#{current_node.value} ) | "
			next_to_visit << current_node.children[0] if current_node.children[0]
			next_to_visit << current_node.children[1] if current_node.children[1]
			if count == 0
				count = current_node.children.size
				level += 1
				puts
				puts "level: #{level}"
			end
			count -= 1
			current_node = next_to_visit.shift
		end
	end
end

bt = BinaryTree.new
bt.build_tree([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
bt.to_s