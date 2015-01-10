target =  25#21.8 #30.10 #15.05
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

class Array
  def all_solutions_greater_than_target(target)
    self.all? {|set| set.total_price > target}
  end

  def check_solutions(target)
    self.find {|solution| solution.total_price == target }
  end
end

def calculate_order(menu, target)
  solutions = []
  menu.each do |item|
    solutions << PotentialSet.new([item])
  end
  if solutions.all_solutions_greater_than_target(target)
    return "No Solution"
  else
    order = solutions.check_solutions(target)
    if order
      order.list_names
    else
      next_arr = Array.new
      solutions.each do |solution|
        menu.each do |fooditem|
        next_arr << PotentialSet.new([solution.items, fooditem].flatten)
        end
      end
      if next_arr.all_solutions_greater_than_target(target)
        puts "No Solution"
      else
        order = next_arr.check_solutions(target)
        if order
          order.list_names
        else
        third_arr = Array.new
        next_arr.each do |solution|
          menu.each do |fooditem|
          third_arr << PotentialSet.new([solution.items, fooditem].flatten)
          end
        end
        if third_arr.all_solutions_greater_than_target(target)
          puts "No Solution"
        end
        order = third_arr.check_solutions(target)
        if order
          order.list_names
        else
          fourth_arr = Array.new
          third_arr.each do |solution|
            menu.each do |fooditem|
            fourth_arr << PotentialSet.new([solution.items, fooditem].flatten)
            end
          end
          if fourth_arr.all_solutions_greater_than_target(target)
            puts "No Solution"
          end
          order = fourth_arr.check_solutions(target)
          if order
            order.list_names
          else
            fifth_arr = Array.new
            fourth_arr.each do |solution|
              menu.each do |fooditem|
              fifth_arr << PotentialSet.new([solution.items, fooditem].flatten)
              end
            end
            if fifth_arr.all_solutions_greater_than_target(target)
              puts "No Solution"
            end
            order = fifth_arr.check_solutions(target)
            if order
              order.list_names
            else
              sixth_arr = Array.new
              fifth_arr.each do |solution|
                menu.each do |fooditem|
                sixth_arr << PotentialSet.new([solution.items, fooditem].flatten)
                end
              end
              if sixth_arr.all_solutions_greater_than_target(target)
                puts "No Solution"
              end
              order = sixth_arr.check_solutions(target)
              if order
                order.list_names
              else
                p "Hi"
              end
            end
          end
        end
      end
    end
  end
end


end

calculate_order(menu, target)