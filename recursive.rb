require 'csv'

#CSV Format:
#"$Target_Price"
#Food1, "$Price1"
#Food2, "$Price2"

def parse_csv_file
  file = ARGV[0]
  @menu = []
  csv_contents = CSV.read(file)
  p @target = csv_contents[0][0][1..-1].to_f
  temp_menu = csv_contents[1..-1]
  temp_menu.each do |item|
    item[1] = item[1][1..-1].to_f
  end
  temp_menu.each do |fooditem|
    @menu << FoodItem.new(fooditem[0], fooditem[1])
  end
end


class Array
  def check_solutions(target)
    self.find {|solution| solution.total_price == target }
  end
end

target =  35.1 #21.8 #30.10 #15.05
FoodItem = Struct.new(:name, :price)
menu = [
FoodItem.new("mixed fruit", 2.15),
FoodItem.new("french fries", 2.75),
FoodItem.new("side salad", 3.35),
FoodItem.new("hot wings", 3.55),
FoodItem.new("mozzarella sticks", 4.20),
FoodItem.new("sampler plate", 5.80),
]
PotentialSet = Struct.new(:items, :wont_work) do
  def total_price
      sum = 0
      items.each {|item| sum += item.price}
      sum
  end

  def list_names
    items.each {|item| p item.name}
  end

  def this_solution_wont_work(target, lowest_price)
    if self.total_price > target
      self.wont_work = true
    end
    if target - self.total_price < lowest_price
      self.wont_work = true
    end
  end
end

def load_menu(menu, target)
  sorted = menu.sort_by {|fooditem| fooditem.price}
  @lowest_price = sorted[0].price
  @highest_price = sorted.last.price
  @menu_items = []
  menu.each do |fooditem|
    @menu_items << PotentialSet.new([fooditem])
  end
  if @menu_items.check_solutions(target)
    return @menu_items.check_solutions(target).list_names
  else
    @menu_items.each {|item| item.this_solution_wont_work(target, @lowest_price)}
  end
  return "No Solution" if @menu_items.all? {|set| set.wont_work == true}
end

def find_order(menu, target, poss_solutions = @menu_items)
  new_solutions = [] #poss_solutions.clone
  poss_solutions.each do |solution|
    menu.each do |fooditem|
      new_solutions << PotentialSet.new([solution.items, fooditem].flatten)
    end
  end
  if new_solutions.check_solutions(target)
    return new_solutions.check_solutions(target).list_names
  end
  new_solutions.each {|set| set.this_solution_wont_work(target, @lowest_price)}
  if new_solutions.all? {|set| set.wont_work == true}
    return "No Solution"
  end
  refined_solutions = []
  refined_solutions << new_solutions.select{|set| set.wont_work != true}
  find_order(menu, target, refined_solutions[0])
end

parse_csv_file
load_menu(@menu, @target)
p find_order(@menu, @target)

