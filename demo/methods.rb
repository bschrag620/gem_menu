# From here down are the various methods that get called by the Entries from
# the menus above. The key to the methods that are called from the Entry class
# is that they need to return a menu method that represents which menu the user
# should be returned to when finished. If not, it will crash. To launch the CLI
# see the last few lines of the file.

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

def foo
  puts 'foo'
  menu_2
end

# Notice below, even though :bar is launched from menu 2, it is sending
# main_menu as it's return. Occasionally it might not make sense for the user to
# return to the menu they left from. This is one advantage to explicitly calling the menu to return to.
def bar
  puts 'bar'
  main_menu
end
