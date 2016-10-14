def fibs(number)
	return [0] if number == 1
	return [0, 1] if number == 2
	n1 = 0
	n2 = 1
	res = [0, 1]
	(number - 2).times do
		temp = n1 + n2
		n1 = n2
		n2 = temp
		res << n2
	end
	res
end

def fibs_rec(num)
	return [0] if num <= 1
	return [0, 1] if num == 2
	ret = fibs_rec(num - 1)	
	ret << (ret.last + ret[-2])
end