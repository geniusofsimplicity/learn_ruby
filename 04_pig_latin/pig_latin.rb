#write your code here
def translate(line)
	words = line.split(" ")	
	vowels = "aeouyi"
	new_line = ""
	words.each do |word|
		qu_pos = word.index("qu")		
		length = word.size
		extra_letter = ""
		if(qu_pos == 1)
			extra_letter = word[0]
			word = word[1..(length-1)]
			word.sub!("qu", "")
		else
			word.sub!("qu", "")
		end
		if vowels.index(word[2]) == nil && vowels.index(word[1]) == nil && vowels.index(word[0]) == nil
			letters = word[0..2]
			word = word[3..(word.size-1)] + letters
		elsif vowels.index(word[1]) == nil && vowels.index(word[0]) == nil
			letters = word[0..1]
			word = word[2..(word.size-1)] + letters

		elsif vowels.index(word[0]) == nil
			letter = word[0]
			word = word[1..(word.size-1)] + letter
		end
		if extra_letter.size > 0 && qu_pos != nil
			word.insert(length - 2 - qu_pos, extra_letter + "qu")			
		elsif qu_pos != nil
			word.insert(length - 2 - qu_pos, "qu")
				
		end
		word += "ay"
		new_line += " " + word
	end
	new_line.strip
	


end