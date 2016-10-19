require "caesar_cipher"

describe Object do

	subject do
		Object.new
	end

	describe "#caesar_cipher" do

		context "given 'HelloaAzZ'" do
			it { expect(Object.send(:caesar_cipher,"HelloaAzZ", 3)).to eql("KhoordDcC")}		
		end

		context "given an empty string" do
			it { expect(Object.send(:caesar_cipher,"", 1)).to eql("")}
		end		
	end
end