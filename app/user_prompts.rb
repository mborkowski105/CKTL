require "tty-prompt"

PROMPT = TTY::Prompt.new

def greeting
    if User.find_by_id(1)
        puts "Welcome to CKTL, #{User.find_by_id(1).name}!"
    else 
        puts "Welcome to CKTL! Please create a profile."
        create_account
    end
end

def create_account
    name = PROMPT.ask("What is your name?") do |q|
        q.modify :trim
    end
    User.create(name: name, id: 1)
    greeting
end

def main_menu
    choices = ["Make CKTL", "Browse CKTL", "My Shelf", "Quit"]
    option = PROMPT.select("What's the move tonight?", choices)
    case option
    when "Make CKTL"
        make_CKTL
    when "Browse CKTL"
        browse_CKTL
    when "My Shelf"
        my_shelf
    when "Quit"
        exit_CKTL
    end
end

def make_CKTL
    # cktl_array = possible_cocktails.map do |cktl|
    #     cktl.name
    # end
    # option = PROMPT.select(cktl_array)
    # puts "This feature has not yet been implemented."
    choices = ["What can I make?", "Go back."]
    option = PROMPT.select("Great, how should we drink?", choices)
    case option
    when choices[0]
        possible_cocktails = User.find(1).possible_cocktails
        make_from_possible(possible_cocktails)
    when choices[1]
        main_menu
    end
end

def make_from_possible(possible_cocktails)
    choices = possible_cocktails
    option = PROMPT.select("Select a CKTL from the list to view its recipe.", choices)
    name = Cocktail.find_by_name(option).name # string
    ingredients = Cocktail.find_by_name(option).get_ingredients # array of strings
    directions = Cocktail.find_by_name(option).directions # string
    puts name
    puts ingredients
    puts directions
    puts " "
    prompt.keypress("Press space or enter to continue", keys: [:space, :return])
    make_CKTL
end

def browse_CKTL
    # cktl_array = Cocktail.all.map do |cktl|
    #     cktl.name
    # end
    # option = PROMPT.select(cktl_array)
    puts "This feature has not yet been implemented." 
end

def my_shelf
    choices = ["View Shelf", "Add to Shelf", "Remove from Shelf", "Clear Shelf", "Main Menu"]
    option = PROMPT.select("What would you like to do with your shelf?", choices)
    case option
    when "View Shelf"
        view_shelf_prompt
    when "Add to Shelf"
        add_to_shelf_prompt
    when "Remove from Shelf"
        remove_from_shelf_prompt
    when "Clear Shelf"
        shelf_clear_prompt
    when "Main Menu"
        main_menu
    end
end

def view_shelf_prompt
    shelf = User.find_by_id(1).inventory
    if shelf.empty?
        shelf_empty_prompt
    else
        puts "Current Shelf:"
        shelf.each do |item|
            puts item
        end
        prompt.keypress("Press space or enter to continue", keys: [:space, :return])
        my_shelf
    end
end

def add_to_shelf_prompt
    item = PROMPT.ask('What would you like to add to your shelf?') do |q|
        q.modify :trim
    end
    # binding.pry
    User.find_by_id(1).add_inventory(item)
    shelf_reprompt
end

def shelf_empty_prompt
    choices = ["Add to Shelf", "Main Menu"]
    option = PROMPT.select("You've got nothing on your shelf. You must be thirsty! What do you have at home?", choices)
    case option
    when "Add to Shelf"
        add_to_shelf_prompt
    when "Main Menu"
        main_menu
    end
end

def shelf_reprompt
    choices = ["Return to Shelf", "Main Menu"]
    option = PROMPT.select("What would you like to do?", choices)
    case option
    when "Return to Shelf"
        my_shelf
    when "Main Menu"
        main_menu
    end
end

def shelf_clear_prompt
    choices = ["Yes, I'm sure.", "No, not my liquor!"]
    option = PROMPT.select("Are you sure you want to clear your shelf? Your CKTL inventory will be deleted!", choices)
    case option
    when "Yes, I'm sure."
        User.find_by_id(1).clear_inventory
        puts "Starting a 12-Step program? Good for you! Deleted!"
        prompt.keypress("Press space or enter to continue", keys: [:space, :return])
        shelf_reprompt
    when "No, not my liquor!"
        puts "Phew, you scared me there!"
        shelf_reprompt
    end
end

def exit_CKTL
    exit(false)
end
