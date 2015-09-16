require "benchmark"

def base_tenify(num)
  # breaks up a number into an array of base tens
  output = []

  length = num.to_s.size
  start_divisor = 10 ** (length - 1)

  until num == 0
    digit, num = num.divmod(start_divisor)
    output.push(digit * start_divisor)
    start_divisor = start_divisor / 10
  end

  output
end

def counting_twos_naive(start, finish)
  # functional naive solution for verification purposes
  count = 0

  (start..finish).each do |num|
    num.to_s.each_char do |c|
      count += 1 if c == "2"
    end
  end

  count
end

def counting_twos(num)
  count = 0
  num_array = base_tenify(num)
  edge = false
  extra = 0

  num_array.each do |n|
    extra += n if edge
    count += total_less_than(n - 1)

    edge = true if edge || n.to_s[0] == "2"
  end

  count += extra + 1 if extra != 0

  count
end

def total_less_than(trailing_nines)
  # returns the number of twos from 0 to any number with trailing 9s
  # e.g. total_less_than(4999) = 2500
  return 0 if trailing_nines < 1
  return 1 if trailing_nines < 10

  first = trailing_nines.to_s[0].to_i
  special_num = trailing_nines.to_s.size - 1
  stack_size = (special_num) * (10 ** (special_num - 1)).to_i
  # p "first #{first}, special #{special_num}, stack #{stack_size}"

  count = (first + 1) * stack_size
  count += (10 ** special_num) if first >= 2

  count
end

Benchmark.bm do |benchmark|
  benchmark.report { p counting_twos_naive(0, 1928374) }
  benchmark.report { p counting_twos(1928374) }
  benchmark.report { p counting_twos(321) }
  benchmark.report { p counting_twos(123) }
end
