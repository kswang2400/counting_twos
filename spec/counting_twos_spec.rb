require "counting_twos"

RSpec.describe TwoCounter do
  before :each do 
    @counter = TwoCounter.new
  end

  describe "#count_twos" do
    it "should be much faster" do
      start = Time.now
      @counter.count_twos(123456789987654321)
      expect(Time.now - start).to be < 10 ** -2
    end

    it "should give you the right answer" do
      100.times do
        # smaller sample size because naive solution takes too much time
        num = rand(999)
        expect(@counter.count_twos(num)).to eq @counter.counting_twos_naive(num)
      end
    end
  end

  describe "#counting_twos_naive" do
    it "should take hella long" do
      start = Time.now
      @counter.counting_twos_naive(1234567)
      expect(Time.now - start).to be > 1
    end
  end
end