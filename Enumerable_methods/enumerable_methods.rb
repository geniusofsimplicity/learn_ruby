module Enumerable
	def my_each		
		case self.class.to_s
		when Hash.to_s			
			copy = self.dup
			for i in 0..(self.size-1)
				current = copy.shift
				yield(current[0], current[1])
			end
		when Array.to_s
			for i in 0..(self.size-1)
				yield(self[i])
			end
		end		
		self
	end

	def my_each_with_index
		for i in 0..(self.size-1)
			yield(self[i], i)
		end
		self
	end

	def my_select	
		case self.class.to_s
		when Hash.to_s
			temp = self.dup
			result = Hash.new(self.default)
			for i in 0..(self.size-1)
				current = temp.shift
				result[current[0]] = current[1] if yield(current[0], current[1])
			end
			result
		when Array.to_s
			result = []			
			for i in 0..(self.size-1)
				result << self[i] if yield(self[i])
			end			
			result	
		end
	end

	def my_all?
		case self.class.to_s
		when Hash.to_s
			temp = self.dup
			result = true
			for i in 0..(self.size-1)
				current = temp.shift
				#result[current[0]] = current[1] if yield(current[0], current[1])
				result &&= yield(current[0], current[1]) ? true : false
			end
			result
		when Array.to_s
			result = true		
			for i in 0..(self.size-1)				
				result &&= yield(self[i]) ? true : false
			end	
			result	
		end
	end

	def my_any?
		case self.class.to_s
		when Hash.to_s
			temp = self.dup
			result = false
			for i in 0..(self.size-1)
				current = temp.shift
				#result[current[0]] = current[1] if yield(current[0], current[1])
				result ||= yield(current[0], current[1]) ? true : false
			end
			result
		when Array.to_s
			result = false		
			for i in 0..(self.size-1)				
				result ||= yield(self[i]) ? true : false
			end	
			result	
		end
	end

	def my_none?
		case self.class.to_s
		when Hash.to_s
			temp = self.dup
			result = false
			for i in 0..(self.size-1)
				current = temp.shift
				#result[current[0]] = current[1] if yield(current[0], current[1])
				result ||= yield(current[0], current[1]) ? true : false
			end
			!result
		when Array.to_s
			result = false		
			for i in 0..(self.size-1)				
				result ||= yield(self[i]) ? true : false
			end	
			!result
		end
	end

	def my_count(*args)
		if block_given?
			copy = self.dup
			count = 0
			while copy.first != nil
				count += 1 if yield(copy.shift)
			end
			count
		else
			case args.size
			when 0
				copy = self.dup
				count = 0
				while copy.first != nil
					count += 1
					copy.shift
				end
				count
			when 1
				copy = self.dup
				count = 0
				compare = args[0]
				while copy.first != nil
					count += 1 if copy.shift == compare				
				end
				count		
			end
		end
	end

	def my_map *input_proc
		result = self.class.new
		copy = self.dup
		input_proc = input_proc.first if input_proc.length == 0 
		if input_proc.nil?
			case self.class.to_s
			when Hash.to_s
				while copy.first != nil
					current = copy.shift
					result[current[0]] = yield(current[0], current[1])				
				end
				result
			when Array.to_s
				while copy.first != nil
					result << yield(copy.shift)
				end
				result			
			end
		else
			input_proc = input_proc.first
			case self.class.to_s
			when Hash.to_s
				while copy.first != nil
					current = copy.shift
					result[current[0]] = input_proc.call(current[0], current[1])				
				end
				result
			when Array.to_s
				while copy.first != nil
					result << input_proc.call(copy.shift)
				end
				result			
			end	
		end
			
	end

	def my_inject
		result = self.class.new
		copy = self.dup
		case self.class.to_s
		when Hash.to_s
			# memo = copy.first
			# while copy.first != nil
			# 	current = copy.shift
			# 	memo = yield(memo, current)				

			# end
			# memo
		when Array.to_s
			memo = copy[0]
			while copy.first != nil
				current = copy.shift
				memo = yield(memo, current)
			end
			memo			
		end
	end
end

def multiply_els(input)
	input.my_inject{|m, v| m * v} / input.first	
end