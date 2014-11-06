@num_tested
@num_solutions

# UI for the solver
def solve ()
  @num_tested = 0
  @num_solutions = 0
  print "Enter Answer: "
  answer = gets.chomp.to_i
  print "Enter Numbers:\n"
  numbers = []
  6.times{numbers << gets.chomp.to_i}
  puts "Solving..."
  pick_two(numbers, answer, "")
  [@num_tested, @num_solutions]
end

# Picks all pair combos from numbers to pick_op
def pick_two (numbers, answer, solution)
  return if numbers.length < 2 # Terminate if unable to pick
  for i in 0..numbers.length-1
    for j in i+1..numbers.length-1
      remaining = numbers.clone #remaining elements
      b = remaining.delete_at(j) #delete j first so i is unaffected
      a = remaining.delete_at(i)
      # Since answer must be positive, we enforce a > b
      pick_op([a,b].max, [a,b].min, remaining, answer, solution)
    end
  end  
end

# Iterates through all 4 mathematical operations to test
def pick_op (a, b, numbers, answer, solution)
  test(a, b, "+", a+b, numbers, answer, solution.clone)
  test(a, b, "-", a-b, numbers, answer, solution.clone)
  test(a, b, "*", a*b, numbers, answer, solution.clone)
  test(a, b, "/", a/b, numbers, answer, solution.clone) if (b != 0 && a % b == 0) #avoid divide by zero and fractions
end

def test(a, b, op, ab, numbers , answer, solution)
  @num_tested += 1
  solution << "#{a} #{op} #{b} = #{ab}\n"
  if (ab == answer)
    @num_solutions += 1
    print "\nSolution \##{@num_solutions}:\n#{solution}"
  else
    #put the result back into number and recurse
    pick_two(numbers.clone.unshift(ab), answer, solution)
  end
end
