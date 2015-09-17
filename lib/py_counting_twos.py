import math

class TwoCounter:
  def count_twos_naive(self, num):
    s = ""
    for i in range(num + 1):
        s += str(i)

    return s.count("2")

  def count_twos(self, num):
    base = 1
    count = 0
    extra = 0

    while num != 0:
      num, digit = divmod(num, 10)
      pile_size = math.log(base, 10) * base / 10

      count += digit * pile_size

      if digit > 2:
        count += base
      elif digit == 2:
        count += extra + 1

      extra += digit * base
      base *= 10

    return count

counter = TwoCounter()
print counter.count_twos_naive(1203981)
print counter.count_twos(1203981)