require "counting_twos"

RSpec.describe TwoCounter do
  before :each do 
    @counter = TwoCounter.new
  end

  describe "#base_tenify" do
    it "should convert integer to array of base tens" do
      expect(@counter.base_tenify(1234)).to contain_exactly(1000, 200, 30, 4)
      expect(@counter.base_tenify(20)).to contain_exactly(20)
      expect(@counter.base_tenify(21)).to contain_exactly(20, 1)
    end
  end

  describe "#counting_twos" do
    it "should be much faster" do
      start = Time.now
      @counter.counting_twos(123456789987654321)
      expect(Time.now - start).to be < 10 ** -4
    end

    it "should give you the right answer" do
      expect(@counter.counting_twos(1029)).to eq @counter.counting_twos_naive(1029)
      expect(@counter.counting_twos(2222)).to eq @counter.counting_twos_naive(2222)
      expect(@counter.counting_twos(9804)).to eq @counter.counting_twos_naive(9804)
      expect(@counter.counting_twos(9876)).to eq @counter.counting_twos_naive(9876)
      expect(@counter.counting_twos(1000)).to eq @counter.counting_twos_naive(1000)
      expect(@counter.counting_twos(2929)).to eq @counter.counting_twos_naive(2929)
    end
  end

  describe "#total_less_than" do
    it "should give you the right answer" do
      expect(@counter.total_less_than(19)).to eq 2
      expect(@counter.total_less_than(199)).to eq 40
      expect(@counter.total_less_than(999)).to eq 300
      expect(@counter.total_less_than(3999)).to eq 2200
      expect(@counter.total_less_than(89999)).to eq 46000
    end
  end

  describe "#counting_twos_naive" do
    it "should take hella long" do
      start = Time.now
      @counter.counting_twos_naive(1234567)
      expect(Time.now - start).to be > 3
    end
  end
end