def substrings(words_to_search, dictionary)
	words_array = words_to_search.split(/\W+/)
	puts words_array #remove
	result = Hash.new(0)
	dictionary.each do |word_dic|
		words_array.each do |word|
			if word.downcase.include? word_dic.downcase
				result[word_dic] += 1
			end
		end		
	end
	puts result
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
substrings("Howdy partner, sit down! How's it going?", dictionary)