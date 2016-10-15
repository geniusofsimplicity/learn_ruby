class LinkedList
	attr_reader :head, :tail

	class Node
		attr_reader :value
		attr_accessor :next_node
		def initialize(value)
			@value = value			
		end
	end

	def initialize
		@head = nil
		@tail = nil
	end

	def append(value)
		node = Node.new(value)
		if @tail
			@tail.next_node = node
			@tail = node
		else
			@head = node
			@tail = node
		end
	end

	def prepend(value)
		node = Node.new(value)
		if @head
			prev_head = @head
			node.next_node = prev_head
			@head = node
		else
			@head = node
			@tail = node
		end		
	end

	def size
		current_node = @head
		i = 0
		while current_node
			i += 1
			current_node = current_node.next_node
		end
		i
	end

	def at(index)
		return if @head.nil?
		current_node = @head
		(index).times do			
			current_node = current_node.next_node
			return if current_node.nil?
		end
		current_node
	end

	def pop
		case self.size
		when 0 then return
		when 1 
			node = @head
			@head = nil
			@tail = nil
			return node
		else
			new_tail = self.at(size - 2)
			node = @tail
			@tail = new_tail
			@tail.next_node = nil
			return node
		end		
	end

	def contains?(value)
		current_node = @head
		while current_node
			return true if current_node.value == value
			current_node = current_node.next_node
		end
		false
	end

	def find(value)
		current_node = @head
		i = 0
		while current_node
			return i if current_node.value == value
			current_node = current_node.next_node
			i += 1
		end
		nil
	end

	def to_s
		res = ""
		current_node = @head
		while current_node
			res << "( #{current_node.value} ) -> "			
			current_node = current_node.next_node
		end
		res << "nil"
	end

	def insert_at(index, value)
		size = self.size
		return false if size < index
		node = Node.new(value)
		if size == 0
			@head = node
			@tail = node
		else			
			prev_node = self.at(index - 1)
			next_node = prev_node.next_node
			prev_node.next_node = node
			node.next_node = next_node
		end
		true
	end

	def remove_at(index)
		size = self.size
		return false if (size - 1) < index
		if size == 1
			return self.pop
		else
			prev_node = self.at(index - 1)
			node_to_delete = prev_node.next_node
			next_node = node_to_delete.next_node
			prev_node.next_node = next_node
			return node_to_delete	
		end
	end

end