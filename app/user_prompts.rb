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
    choices = ["Make CKTL", "Browse CKTL", "My Shelf"]
    option = PROMPT.select("What's the move tonight?", choices)
    case option
    when "Make CKTL"
        make_CKTL
    when "Browse CKTL"
        browse_CKTL
    when "My Shelf"
        my_shelf
    end
end

def make_CKTL
    # cktl_array = possible_cocktails.map do |cktl|
    #     cktl.name
    # end
    # option = PROMPT.select(cktl_array)
    puts "This feature has not yet been implemented."
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
        pp shelf # let's make this look nicer
        my_shelf
    end
end

def add_to_shelf_prompt
    # Vodka, Rum, Whisky, Gin, Tequila
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
    when "No, not my liquor!"
        puts "Phew, you scared me there!"
        shelf_reprompt
    end
end
