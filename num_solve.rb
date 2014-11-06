@num_solns

# UI for the reducer
def solve ()
  @num_solns = 0
  print "Enter Answer: "
  answer = gets.chomp.to_i
  puts "Enter Numbers:"
  es = []
  6.times{es << gets.chomp.to_i}
  puts "Solving..."
  reduce(es, answer, "")
  @num_solns
end

# Picks all pair combos from es to combine
def reduce (es, answer, solution)
  return if es.length < 2 # Terminate recursion
  for i in 0..es.length-1
    for j in i+1..es.length-1
      res = es.clone #remaining elements
      b = res.delete_at(j) #delete j first so i is unaffected
      a = res.delete_at(i)
      # Since answer must be positive, we enforce a > b
      combine([a,b].max, [a,b].min, res, answer, solution)
    end
  end  
end

# Iterates through all 4 mathematical operations to test
def combine (a, b, es, answer, solution)
  test(a, b, "+", a+b, es, answer, solution.clone)
  test(a, b, "-", a-b, es, answer, solution.clone)
  test(a, b, "*", a*b, es, answer, solution.clone)
  if (b != 0 && a % b == 0)
    test(a, b, "/", a/b, es, answer, solution.clone)
  end
end

def test(a, b, op, ab, es , answer, solution)
  solution << "#{a} #{op} #{b} = #{ab}\n"
  if (ab == answer)
    @num_solns += 1
    print "\nSolution \##{@num_solns}:\n#{solution}"
  else
    reduce(es.clone.unshift(ab), answer, solution)
  end
end
