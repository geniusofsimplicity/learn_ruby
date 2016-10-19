def caesar_cipher(text, shift) 
	result = ""
	text.each_byte do |code|
		code_init = code
		shift = shift % 26
		code += shift
		if ((code > 90 && code_init <= 90)||(code > 122 && code_init <= 122))
			code -= 26
		end
		result += code.chr
	end
	result
end

puts caesar_cipher("HelloaAzZ", 3)