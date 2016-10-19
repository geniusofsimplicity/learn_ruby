require "enumerable_methods"

describe Enumerable do

	let(:random_array) do
		a = []
		s = rand(8) + 2
		s.times{ a << rand(100)}
		a
	end

	let(:array_1) do
		[1, 2, 4, 5, 8, 10, 11, 99, 100, -11, -100, -4.5]
	end

	let(:hash_1) do
		{a: 1, b: 2, c: 4, d: 5, e: 8, f: 10, h: 11, g: 99, aa: 100, bb: -11, cc: -100, dd: -4.5}
	end

	let(:random_hash) do
		a = {}
		s = rand(8) + 2
		s.times{|i| a[i] = rand(100)}
		a
	end

	describe "#my_each" do

		context "compared to original each on array" do
			it do 
				sum = 0
				sum1 = 0
				random_array.my_each{|v| sum += v}
				random_array.each{|v| sum1 += v}
				expect(sum).to eql(sum1)
			end
		end

		context "compared to original each on hash" do
			it do 
				sum = 0
				sum1 = 0
				random_hash.my_each{|k, v| sum += v}
				random_hash.each{|k, v| sum1 += v}
				expect(sum).to eql(sum1)
			end
		end
	end

	describe "#my_each_with_index" do
		context "compared to each_with_index" do
			it "checking correct index count" do
				sum_i = 0
				sum = 0
				random_array.my_each_with_index do |v, i|
					sum_i += i					
				end
				sum_i2 = 0				
				random_array.each_with_index do |v, i|
					sum_i2 += i					
				end
				expect(sum_i).to eql(sum_i2)
			end

			it "checking correct value count" do				
				sum = 0
				random_array.my_each_with_index do |v, i|					
					sum += random_array[i]
				end
				sum2 = 0
				random_array.each_with_index do |v, i|					
					sum2 += random_array[i]
				end
				expect(sum).to eql(sum2)
			end
		end
	end

	describe "my_select" do

		context "compared to original select" do
			it "selecting even numbers on random array" do
				expect(random_array.my_select{|v| v % 2 == 0}).to eql(random_array.select{|v| v % 2 == 0})
			end

			it "selecting even numbers on given array" do
				expect(array_1.my_select{|v| v % 2 == 0}).to eql(array_1.select{|v| v % 2 == 0})
			end

			it "selecting even numbers on empty array" do
				expect([].my_select{|v| v % 2 == 0}).to eql([].select{|v| v % 2 == 0})
			end
		end

		context "compared to original select" do
			it "selecting even numbers on random hash" do
				expect(random_hash.my_select{|k, v| v % 2 == 0}).to eql(random_hash.select{|k, v| v % 2 == 0})
			end

			it "selecting even numbers on given hash" do
				expect(hash_1.my_select{|k, v| v % 2 == 0}).to eql(hash_1.select{|k, v| v % 2 == 0})
			end

			it "selecting even numbers on empty hash" do
				expect({}.my_select{|v| v % 2 == 0}).to eql({}.select{|v| v % 2 == 0})
			end
		end
	end

end