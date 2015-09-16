require "benchmark"

class TwoCounter
  attr_reader :cache

  def initialize
    @cache = Hash.new
  end

  def base_tenify(num)
    # breaks up a number into an array of base tens
    output = []

    length = Math.log10(num).floor
    start_divisor = 10 ** (length)

    until num == 0
      digit, num = num.divmod(start_divisor)
      output.push(digit * start_divisor)
      start_divisor = start_divisor / 10
    end

    output
  end

  def counting_twos_naive(num)
    # functional naive solution for verification purposes
    return @cache[num] if @cache[num]
    count = 0

    (0..num).each do |num|
      num.to_s.each_char do |c|
        count += 1 if c == "2"
      end
    end

    @cache[num] = count
    count
  end

  def counting_twos(num, use_cache = true)
    return @cache[num] if @cache[num] && use_cache

    count = 0
    num_array = base_tenify(num)
    
    # patchwork fix for edge cases
    edge = false
    extra = 0

    num_array.each do |n|
      extra += n if edge
      count += total_less_than(n - 1)

      edge = true if edge || n.to_s[0] == "2"
    end

    count += extra + 1 if extra != 0

    @cache[num] = count
    count
  end

  def total_less_than(trailing_nines)
    # returns the number of twos from 0 to any number with trailing 9s
    # e.g. total_less_than(4999) = 2500
    return 0 if trailing_nines < 2
    return 1 if trailing_nines < 10

    first = trailing_nines.to_s[0].to_i
    special_num = trailing_nines.to_s.size - 1
    pile_size = (special_num) * (10 ** (special_num - 1)).to_i
    # p "first #{first}, special #{special_num}, pile #{pile_size}"

    count = (first + 1) * pile_size
    count += (10 ** special_num) if first >= 2

    count
  end
end

