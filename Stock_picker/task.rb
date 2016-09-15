def stock_picker(prices)	
	prices_reversed = prices.reverse
	prices_reversed.pop
	days_total = prices.length
	min_price_day_final = 0
	max_price_day_final = days_total-1
	profit = 0	
	prices_reversed.each_index do |index|
		min_price = prices[0..days_total-index-2].min
		min_price_day = prices.index(min_price)
		profit1 = prices_reversed[index] - prices[min_price_day]
		if profit1 > profit
			profit = profit1
			min_price_day_final = min_price_day
			max_price_day_final = days_total-index-1
		end		
	end
	puts [min_price_day_final, max_price_day_final].to_s + " for a profit of $#{prices[max_price_day_final]} - $#{prices[min_price_day_final]} == $#{profit}"	
end

prices = [17,3,6,9,15,8,6,1,10]
#prices = [100, 102, 17, 3, 60, 20, 2, 50, 21]
stock_picker(prices)