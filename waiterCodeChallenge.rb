target =  21.8 #30.10 #15.05
FoodItem = Struct.new(:name, :price)
menu = [
FoodItem.new("mixed fruit", 2.15),
FoodItem.new("french fries", 2.75),
FoodItem.new("side salad", 3.35),
FoodItem.new("hot wings", 3.55),
FoodItem.new("mozzarella sticks", 4.20),
FoodItem.new("sampler plate", 5.80),
]
PotentialSet = Struct.new(:items) do
  def total_price
    sum = 0
    items.each {|item| sum += item.price}
    sum
  end

  def list_names
    items.each {|item| p item.name}
  end
end



solutions = []
new_solutions = []
newer_solutions = []
newest_solutions = []
newestest_solutions = []
newestestest_solutions = []

class Array
  def all_solutions_greater_than_target(target)
    self.all? {|set| set.total_price > target}
  end
end

menu.each do |item|
  solutions << PotentialSet.new(item)
end


# solutions.each do |solution|
#   if solution.total_price > target
#     puts "All items more expensive than target"
#   else
  solutions.each do |solution|
    menu.each do |fooditem|
    new_solutions << PotentialSet.new([solution.items, fooditem])
    end
  end

  if new_solutions.all_solutions_greater_than_target(target)
    puts "No solution"
  end

  new_solutions.find do |solution|
    if solution.total_price == target
      return solution.items
    end
  end

  new_solutions.each do |solution|
    menu.each do |fooditem|
    newer_solutions << PotentialSet.new([solution.items, fooditem].flatten)
    end
  end

  newer_solutions.each do |solution|
    menu.each do |fooditem|
    newest_solutions << PotentialSet.new([solution.items, fooditem].flatten)
    end
  end

  newest_solutions.each do |solution|
    menu.each do |fooditem|
    newestest_solutions << PotentialSet.new([solution.items, fooditem].flatten)
    end
  end

  newestest_solutions.each do |solution|
    menu.each do |fooditem|
    newestestest_solutions << PotentialSet.new([solution.items, fooditem].flatten)
    end
  end

order = newestestest_solutions.find {|solution| solution.total_price == target }
puts order.list_names
#for each FoodItem add all the fooditems to it.
#then add all the food items to it
#keep doing this until >= target price