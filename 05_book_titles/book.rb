class Book
# write your code here
	attr_accessor :title
	def title=(title)
		conjs_an_co = ["an", "a", "of", "and", "or", "in", "the"]
		words = title.split(" ")
		new_title = ""
		i = 1
		words.each do |word|
			if (conjs_an_co.include?(word) && i != 1)
				new_title += " " + word
			else
				new_title += " " + word.capitalize
			end
			i += 1
		end
		@title = new_title.strip
	end
end
