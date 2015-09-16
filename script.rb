require "./lib/counting_twos"

counter = TwoCounter.new

Benchmark.bm do |benchmark|
  benchmark.report { p counter.counting_twos_naive(1928374) }
  benchmark.report { p counter.counting_twos(      1928374, false) }
  benchmark.report { p counter.counting_twos(321) }
  benchmark.report { p counter.counting_twos(123) }
  benchmark.report { p counter.counting_twos_naive(1928374) }
end
