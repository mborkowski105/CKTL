require "tty-prompt"

PROMPT = TTY::Prompt.new

def greeting
    if User.current_session_id > 0
        puts "Welcome to CKTL, #{User.find_by_id(User.current_session_id).name}!"
        main_menu
    else
        login_prompt
    end
end

def login_prompt
    choices = ["Log in", "Create a profile", "Quit"]
    option = PROMPT.select("Welcome to CKTL! Please log in or create a profile." , choices)
    case option
    when "Log in"
        log_into_profile
    when "Create a profile"
        create_account
    when "Quit"
        exit_CKTL
    end
end

def log_into_profile
    name = PROMPT.ask("What is your name?") do |q|
        q.modify :trim
    end
    if User.find_by(name: name)
        User.current_session_id = User.find_by(name: name).id
        greeting
    else 
        choices = ["Try Again", "Create a profile", "Main Menu"]
        option = PROMPT.select("We could not find your profile, please try again or create a new profile.", choices)
        case option
        when "Try Again"
            log_into_profile
        when "Create a profile"
            create_account
        when "Main Menu"
            exit_CKTL
        end
    end
end

def logout
    User.reset_session_id
    greeting
end

def create_account
    name = PROMPT.ask("What is your name?") do |q|
        q.modify :trim
    end
    User.create(name: name)
    User.current_session_id = User.find_by(name: name).id
    greeting
end

def main_menu
    choices = ["Make CKTL", "Browse CKTL", "My Shelf", "Log Out", "Quit"]
    option = PROMPT.select("What's the move tonight?", choices)
    case option
    when "Make CKTL"
        make_CKTL
    when "Browse CKTL"
        browse_CKTL
    when "My Shelf"
        my_shelf
    when "Log Out"
        logout
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
        possible_cocktails = User.find_by_id(User.current_session_id).possible_cocktails
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
    puts "*" * 25
    puts name
    puts ingredients
    puts directions
    puts "*" * 25
    PROMPT.keypress("Press space or enter to continue", keys: [:space, :return])
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
    shelf = User.find_by_id(User.current_session_id).inventory
    if shelf.empty?
        shelf_empty_prompt
    else
        puts "Current Shelf:"
        shelf.each do |item|
            puts item
        end
        PROMPT.keypress("Press space or enter to continue", keys: [:space, :return])
        my_shelf
    end
end

def add_to_shelf_prompt
    item = PROMPT.ask('What would you like to add to your shelf? Enter q to quit.') do |q|
        q.modify :trim
    end
    if item == 'q'
        my_shelf
    end
    # binding.pry
    User.find_by_id(User.current_session_id).add_inventory(item)
    add_to_shelf_prompt
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
        User.find_by_id(User.current_session_id).clear_inventory
        puts "Starting a 12-Step program? Good for you! Deleted!"
        PROMPT.keypress("Press space or enter to continue", keys: [:space, :return])
        shelf_reprompt
    when "No, not my liquor!"
        puts "Phew, you scared me there!"
        shelf_reprompt
    end
end

def exit_CKTL
    exit(false)
end
