require_relative "./gem_menu/version"
require "colorize"

module GemMenu
    class Error < StandardError; end

    class Entry
        attr_accessor :name, :next_method, :parameters, :previous
    
        def initialize(name, next_method, optional_args=nil)
            self.name = name
            self.next_method = next_method
            if optional_args
                optional_args.each do |key, value|
                    self.send("#{key}=", value)
                end
            end
        end

        def to_s
            self.name
        end

        def execute_selection(method)
            if self.parameters
                method.call(self.parameters)
            else
                method.call
            end
        end

        def next_selection
            execute_selection(self.next_method)
        end

        def previous_selection
            self.previous.call
        end
    end

    class Menu
        attr_accessor :title, :entries, :previous_menu, :parameter, :menu_hash

        @@exit = Entry.new('exit', method(:exit))
        @@menu_char_begin = "<==  ".colorize(:light_blue)
        @@menu_char_end = "  ==>".colorize(:light_blue)
    
        def initialize(title, entries, optional_args=nil)
            self.title = title
            self.entries = entries
            if optional_args
                optional_args.each do |key, value|
                    self.send("#{key}=", value)
                end
            end
            self.menu_hash = {"x" => self.exit_method}
            self.set_choices
        end
    
        def exit_method
            @@exit
        end
    
        def menu_char_begin
            @@menu_char_begin
        end
    
        def menu_char_end
            @@menu_char_end
        end

        def set_choices
            self.entries.each.with_index(1) do |entry, i|
                self.menu_hash[i.to_s] = entry
            end
            if self.previous_menu
                self.menu_hash['b'] = GemMenu::Entry.new('back', self.previous_menu)
            end
        end

        def retreive_selection
            display_menu
            puts "Please make your selection:".colorize(:light_green)
            receive_input
        end

        def display_menu
            puts
            puts "#{self.menu_char_begin}#{self.title}#{self.menu_char_end}"
            menu_hash.sort.to_h.each do |user_choice, description|
              puts "#{user_choice.colorize(:light_yellow)}) #{description}"
            end
        end

        def receive_input
            selection = nil
            while !self.menu_hash.include?(selection)
              selection = gets.strip.downcase
              if !self.menu_hash.include?(selection)
                puts "Invalid selection"
              end
            end
            launch_selection(selection)
        end

        def launch_selection(selection)
            self.menu_hash[selection].next_selection
        end
    end    
end
