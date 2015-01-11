target =  2.16 #21.8 #30.10 #15.05
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

  def this_solution_greater_than_target(target)
    self.total_price > target
  end
end

class Array
  def all_solutions_greater_than_target(target)
    self.all? do |set|
      set.total_price > target
    end
  end

  def check_solutions(target)
    self.find {|solution| solution.total_price == target }
  end
end

def load_menu(menu)
  @menu_items = []
  menu.each do |fooditem|
    @menu_items << PotentialSet.new([fooditem])
  end
end

def find_order(menu, target, poss_solutions = @menu_items)

  return "No Solution" if poss_solutions.all? {|set| set.this_solution_greater_than_target(target)}

  return poss_solutions.check_solutions(target).list_names if poss_solutions.check_solutions(target)

  poss_solutions.each do |solution|
    menu.each do |fooditem|
      poss_solutions << PotentialSet.new([solution.items, fooditem].flatten)
    end
    p poss_solutions

  return "No Solution" if poss_solutions.all? {|set| set.this_solution_greater_than_target(target)}
  return poss_solutions.check_solutions(target).list_names if poss_solutions.check_solutions(target)
  end
  find_order(menu, target, poss_solutions)
end

load_menu(menu)
p find_order(menu, target)
# p @menu_items.all_solutions_greater_than_target(target)