# counting twos

Count the 2’s between 0 and N.  And every 2 digit counts as a 2, so if N was 7 
the answer would be 1 (just the number 2), whereas if n was 23 there would be 7 2’s 
{2, 12, 20, 21, 22 (this counts for 2), 23}

run ```bundle install``` if you plan on running test suite

run ```ruby counting_twos.rb``` to view benchmarks (listed below)

otherwise open ``irb``` or ```pry``` and ```load lib/counting_twos.rb```

## Usage

```
  counting_twos(321)
  =>  164
  counting_twos(123)
  =>  27
```

much more scalable than naive solution

```
Benchmark.bm do |benchmark|
  benchmark.report { p counting_twos_naive(0, 1928374) }
  benchmark.report { p counting_twos(         1928374) }
end


       user     system      total        real
 1169953
  5.030000   0.020000   5.050000 (  5.060768)
 1169953
  0.000000   0.000000   0.000000 (  0.000078)
```