class Timer
  #write your code here
  attr_accessor :seconds, :time_string, :time
  
  def initialize  	
  	@time = Time.new(2016)
  	
  	@time_string = @time.strftime("%T")
  	@seconds = 0
  end
  def seconds=(seconds)
  	@time = Time.new(2016)
  	@time += seconds
  	@time_string = @time.strftime("%T")
  end
end
