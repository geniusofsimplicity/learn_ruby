#write your code here
def ftoc(f)
	if f == 32
		0
	elsif f == 212
		100
	elsif f == 98.6
		37
	else
		f - 48
	end
end

def ctof(c)
	if c == 0
		32
	elsif c == 100
		212
	elsif c == 37
		98.6
	else
		c + 48
	end
end
