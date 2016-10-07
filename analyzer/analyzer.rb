lines = File.readlines("text.txt")
line_count = lines.size
text = lines.join
total_characters = text.length
total_characters_nospaces = text.gsub(/\s+/, "").length
word_count = text.split.size
sentence_count = text.split(/\.|\?|!/).size
paragraph_count = text.split(/\n\n/).size

#enhancements
stopwords = %w{the a by on for of are with just but and to the my I has some in}
words = text.scan(/\w+/)
keywords = words.select{|word| !stopwords.include?(word)}

puts "#{total_characters} characters"
puts "#{line_count} lines"
puts "#{total_characters_nospaces} characters excluding spaces"
puts "#{word_count} words"
puts "#{sentence_count} sentences"
puts "#{paragraph_count} paragraphs"
puts "#{sentence_count / paragraph_count} sentences per paragraph (average)"
puts "#{word_count / sentence_count} words per sentence (average)"
puts "#{((keywords.size.to_f / words.size.to_f) * 100).to_i}% of keywords"