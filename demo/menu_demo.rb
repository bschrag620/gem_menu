require_relative "demo_environment"

# This is an example of a potential CLI interface using GemMenu. In the CLI, 
# menus are created within methods. When these methods are called, they return
# their respective menus. Menus are created by first creating the Entry classes
# that populate the menu. Each Entry object has it's display text, a reference
# to it's next method or menu, and optionally parameters to be passed on.

# The Menu class is defined with the menu title text, an array of Entry objects,
# and optional arguments of previous_menu (should always be used except for the 
# initial menu, unless using some other method to navigate backwards) and
# parameters. All menus will display with an (x) to exit and a (b) to go back,
# only if the menu was given a :previous_menu.

# To see how menus are created, check the menus.rb file, which has been required

# To see how the methods that are called should be construced, see the methods.rb
# file.

# Here we initiate our first menu, then loop setting menu equal to whatever is
# returned based on the user selection. This is why it's important that the 
# methods within this file that are called from an Entry all return the menu 
# object that is appropraite for the user to return to
menu = main_menu
while true
  menu = menu.retreive_selection
end

