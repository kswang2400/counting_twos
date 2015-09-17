require "benchmark"

class TwoCounter
  def counting_twos_naive(num)
    # functional naive solution for verification purposes
    count = 0

    (0..num).each do |n|
      n.to_s.each_char do |c|
        count += 1 if c == "2"
      end
    end

    count
  end

  def count_twos(num)
    base = 1
    count = 0
    extra = 0

    until num == 0
      num, digit = num.divmod(10)
      pile_size = Math.log10(base) * base / 10

      count += digit * (pile_size)
      count += base if digit > 2
      count += extra + 1 if digit == 2
      
      extra += digit * base
      base *= 10
    end

    count.to_i
  end
end

