require_relative 'demo_environment'
FAVORITE_FOODS = []

puts 'hello'
# Creating the main menu #
def main_menu

#  Step 1, create the entries with (display text, method(:to_be_called), optional_args)

  hello = GemMenu::Entry.new('hello', method(:hello_world))
  world = GemMenu::Entry.new('world', method(:counting_world))
  second_menu = GemMenu::Entry.new('2nd level', method(:menu_2))
  food_menu = GemMenu::Entry.new('food menu', method(:menu_favorite_foods))

# Step 2, once entries are created, create the Menu object and return it with
#                   (title text, array_of_Entries, optional_args)
  GemMenu::Menu.new('main menu', [hello, world, second_menu, food_menu])
end

def menu_2

# Similar to above but note the optional_args hash that is created below
  bar = GemMenu::Entry.new('bar', method(:bar))
  foo = GemMenu::Entry.new('foo', method(:foo))
  optional_args = {:previous_menu => method(:main_menu)}

# optional_args can track the :previous_menu or :parameters to be passed on
  GemMenu::Menu.new('my 2nd menu', [foo,bar], optional_args)
end

def menu_favorite_foods

# Here we are using a global array to track favorite foods. The first .each loop
# creates menu entries for each item in the FAVORITE_FOODS array. It also passes
# the food string on as a parameter in the optional_args hash. Also note, the
# method being called, :say_fav_food, is not a menu.
  menu_entries = []
  FAVORITE_FOODS.each do |food|
    optional_args = {parameters: food}
    menu_entries << GemMenu::Entry.new(food, method(:say_fav_food), optional_args)
  end

# After creating the list of foods, it adds an option to add foods to the list.
# This Entry didn't need a :parameter passed on to it.
  menu_entries << GemMenu::Entry.new('add food', method(:add_fav_food))

# Finally, create and return the Menu object, giving it a reference to the 
# previous menu
  optional_args = {previous_menu: method(:main_menu)}
  GemMenu::Menu.new('my favorite foods', menu_entries, optional_args)
end

def say_fav_food(food)
  puts "One of your favorite foods is #{food}"
  menu_favorite_foods
end

def add_fav_food
  puts "Enter one of your favorite foods: "
  new_food = gets.strip
  FAVORITE_FOODS << new_food
  puts "#{new_food} added to the list"
  menu_favorite_foods
end

def hello_world
  puts 'hello world'
  main_menu
end

def counting_world
  (1..10).each do |i|
    puts i
  end
  main_menu
end

menu = main_menu
while true
  menu = menu.retreive_selection
end

