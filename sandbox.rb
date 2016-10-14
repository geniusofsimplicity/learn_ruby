def reverse_append(ary, n)		
	return [] if n < 0
	ary = reverse_append(ary, n - 1)
	ary << n
end

def factorial(n)
	return 1 if n <= 1
	n * factorial(n - 1)
end

def palindrome?(str)
	return str[0] == str[str.size - 1] if str.size <= 2
	ans ||= true
	ans &&= palindrome?(str.slice(1, str.size - 2))
end

def bottles(n)
	return puts "no more bottles of beer on the wall" if n <= 0
	puts "#{n} bottles of beer on the wall"
	bottles(n - 1)
end

def fib(pos)
	return 0 if pos <= 0
	return 1 if pos == 1	
	(fib(pos - 1) + fib(pos - 2))
end

def my_flatten(ary)
	return ary unless ary.is_a? Array
	ret ||= []
	val = my_flatten(ary.shift)	
	if val.is_a? Array
		ret += val
	else
		ret << val
	end
	ret += my_flatten(ary) if ary.size > 0	
	ret
end

ROMAN_MAPPING = {
		  1000 => "M",
		  900 => "CM",
		  500 => "D",
		  400 => "CD",
		  100 => "C",
		  90 => "XC",
		  50 => "L",
		  40 => "XL",
		  10 => "X",
		  9 => "IX",
		  5 => "V",
		  4 => "IV",
		  1 => "I"
}

def to_roman(roman_mapping, number, result = "")
	# return "" if number == 0
	# digit = number % 10	
	# to_roman(number / 10, pos + 1)
	# ret = ""
	# case
	# when (1..3) === digit
	# 	digit.times{ret << ROMAN_MAPPING[digit * (10 ** pos)]}
	# end

  return result if number == 0
  ROMAN_MAPPING.keys.each do |divisor|
    quotient, modulus = number.divmod(divisor)
    result << ROMAN_MAPPING[divisor] * quotient
    return to_roman(ROMAN_MAPPING, modulus, result) if quotient > 0
  end
end

ROMAN_MAPPING_R = {
  "M" => 1000,
  "CM" => 900,
  "D" => 500,
  "CD" => 400,
  "C" => 100,
  "XC" => 90,
  "L" => 50,
  "XL" => 40,
  "X" => 10,
  "IX" => 9,
  "V" => 5,
  "IV" => 4,
  "I" => 1
}

def from_roman_to_int(mapping, number_s, result = 0)
	return result if number_s.size == 0
	check = number_s[(0..1)]
	check = number_s[0] unless mapping[check.to_s]
	mult = number_s.scan(/^#{check}+/).first.to_s.size / check.size
	result += mapping[check] * mult
	number_s = number_s.slice(check.size * mult, number_s.size - check.size)
	from_roman_to_int(mapping, number_s.to_s, result)	
end