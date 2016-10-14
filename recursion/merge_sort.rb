def merge_sort(ary)
	return ary if ary.size == 1
	return ary[0] < ary[1] ? ary : [ary[1], ary[0]] if ary.size == 2
	middle = ary.size / 2 - 1
	half1 = ary[(0..middle)]
	half2 = ary[((middle + 1)..(ary.size - 1))]
	half1_sorted = merge_sort(half1)
	half2_sorted = merge_sort(half2)
	ret = []
	until half1_sorted.empty? || half2_sorted.empty? do
		ret << ((half1_sorted.first < half2_sorted.first) ? half1_sorted.shift : half2_sorted.shift)
	end
	ret += (half1_sorted.empty? ? half2_sorted : half1_sorted)
end

merge_sort([5, 2, 4, 22, 3, 32, 1, -1, -100, 4, 3])