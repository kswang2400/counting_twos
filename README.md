# counting twos

## Problem: 
Count the 2’s between 0 and N.  And every 2 digit counts as a 2, so if N was 7 
the answer would be 1 (just the number 2), whereas if n was 23 there would be 7 2’s 
{2, 12, 20, 21, 22 (this counts for 2), 23}

## Solution: 

run ```bundle install``` if you plan on running test suite

run ```rspec spec``` to run test suite

run ```ruby script.rb``` to view benchmarks (listed below)

otherwise, to run custom test cases, cd into ```lib```, open ```pry``` and ```load "counting_twos.rb"```

### Usage

```
  c = TwoCounter.new
  c.counting_twos(15432)
  => 6694
  c.counting_twos(321)
  =>  164
  c.counting_twos(123)
  =>  27
```

much more scalable than naive solution; implemented memcache in naive solution

```
Benchmark.bm do |benchmark|
  benchmark.report { p counter.counting_twos_naive(1928374) }
  benchmark.report { p counter.counting_twos(      1928374, false) }
  benchmark.report { p counter.counting_twos(321) }
  benchmark.report { p counter.counting_twos(123) }
  benchmark.report { p counter.counting_twos_naive(1928374) }
end


       user     system      total        real
 1169953
  4.650000   0.010000   4.660000 (  4.667344)
 1169953
  0.000000   0.000000   0.000000 (  0.000070)
 164
  0.000000   0.000000   0.000000 (  0.000026)
 27
  0.000000   0.000000   0.000000 (  0.000026)
 1169953
  0.000000   0.000000   0.000000 (  0.000011)
```