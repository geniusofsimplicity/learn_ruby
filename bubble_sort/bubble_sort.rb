def bubble_sort(input)
	size = input.size
	(size).downto(0) do |j|
		(j-1).times do | i |
			if input[i] > input[i+1]
				t = input [i+1]
				input[i+1] = input[i]
				input[i] = t
			end
		end
	end
	input
end

def bubble_sort_by(input)
	if block_given?
		size = input.size
		(size).downto(0) do |j|
			(j-1).times do | i |
				if yield(input[i], input[i+1]) > 0
					t = input [i+1]
					input[i+1] = input[i]
					input[i] = t
				end
			end
		end
	else
		puts "Please, provide logic/block for sorting the following array:"
	end
	input
end

test = [4, 3, 78, 2, 0, 2, 3, 20, 1]
p bubble_sort(test)
p bubble_sort_by(test){|left, right| left - right }
test1 = [4, 3, 78, 2, 0, 2, 3, 20, 1]
p bubble_sort_by(test1)
test2 = ["hi","hello","hey"]
p bubble_sort_by(test2){|left, right| left.length - right.length }