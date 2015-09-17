# counting twos

## Problem: 
Count the 2’s between 0 and N.  And every 2 digit counts as a 2, so if N was 7 
the answer would be 1 (just the number 2), whereas if n was 23 there would be 7 2’s 
{2, 12, 20, 21, 22 (this counts for 2), 23}

## Solution:

There is a pattern based on how many digits are in the number 

```
range (order of magnitude)      number of zeros
(0..9)   one digit total:       **1**
(10..19)                        1       
(20..29)                        11
(30..39)                        1       1 * 10 + 10 = 20
...
(90.99)                         1
(0..99) (two digit total)       **20**
(100.199)                       20
(200.299)                       120     20 * 10 + 100 = 300
(0.999) (three digit total)     **300**
(0.9999) (four digit total)     **4000**
```

ever "pile" in an order of magnitude (e.g. 10..19; 20..29; 30..39) will be the same
size as the total of the previous order of magnitude. If it's prepended by a number 
greater than two, then you need to add 10 * (d - 1) where d is the number of digits 
for all the leading 2's in that piles. If the first number is a two, there is a separate
edge case to cover that described below.

Additionally, the sum of each order of magnitude can be furthered simplified down to 

```(n) * (10 ** (n - 1))``` 

where n is log10(num). 

Because of these two patterns, there is a mathematical way to solve any number 
in constant time by breaking the number into piles of different magnitudes
and computing the total for each

```
Example:  5876                              *disregard leading 5, will never be a 2
          (0..4999) +       (5000..5876)
                            (0..876)*
                            (0..799) +      (800..876)
                                            (0..76)
                                            (0..69) +     (70..76)
                                                          (0..6)
          (5(300) + 1000) + (8(20) + 100) + (7(1) + 10) + (6(0) + 1)
          = 2500 + 260 + 17 + 1 = 2778
```

Edge Case: When the digit is a two, you can't disregard the leading 2, so whatever 
number remains is what you have to add to the final total (referred to as "extra" in the code)

```
Example:  1234
          (0..999) +     (1000..1234)                       *need to consider 34 + 1 more 2's
                         (0..234)                           in the hundreds place
                         (0..199) +           (200..234)
                                              (0..34)*
                                              (0..29) +     (30..34)
                                                            (0..4)
          (1(300) + 0) + (2(20) + (34 + 1)) + (3(1) + 10) + (4(0) + 1)
          = 300 + 75 + 13 + 1 = 389
```

### Environment

run ```bundle install``` if you plan on running test suite

run ```rspec spec``` to run test suite

run ```ruby script.rb``` to view benchmarks (listed below)

otherwise, to run custom test cases, cd into ```lib```, open ```pry```, and ```load "counting_twos.rb"```

### Usage

```
  load "counting_twos.rb"
  => true
  c = TwoCounter.new
  => #<TwoCounter:0x007fc64d6d7958>
  c.count_twos(15432)
  => 6694
  c.count_twos(321)
  =>  164
  c.count_twos(123)
  =>  27
```

much more scalable than naive solution

```
Benchmark.bm do |benchmark|
  benchmark.report { p counter.counting_twos_naive(1928374) }
  benchmark.report { p counter.count_twos(      1928374, false) }
  benchmark.report { p counter.count_twos(321) }
  benchmark.report { p counter.count_twos(123) }
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

```
  1000.times do
    num = rand(99999)
    expect(@counter.count_twos(num)).to eq @counter.counting_twos_naive(num)
  end
  
  =====
  TwoCounter
    #count_twos
      should be much faster
      should give you the right answer

  Finished in 1 minute 37.16 seconds (files took 0.09791 seconds to load)
  2 examples, 0 failures
```
