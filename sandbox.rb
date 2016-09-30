module MyUtils
	module_function
  def f(i)
    puts i
    i
  end
end

module Kernel

	private

	def secret_m
		puts "hi from the depth of kernel"
	end
end

class MyState
	attr_reader :num
	def num=(number)
		@num = number + 5
		secret_m
	end
end

MyUtils.f(2 + 3) + 1