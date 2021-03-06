require "tty-prompt"
require "colorize"

PROMPT = TTY::Prompt.new

# module StringColorizer
#     require "colorize"
#     refine $stdout do
#         def puts(string)
#             binding.pry
#             new_string = string.colorize(:color => :yellow, :background => :magenta)
#             super(new_string)
#         end
#     end
# end

# def print(string)
#     if string.is_a? String
#         binding.pry
#         new_string = string.colorize(:color => :yellow, :background => :magenta)
#         super(new_string)
#     end
# end


#using StringColorizer

def greeting
puts '    _|_|_|  _|    _|  _|_|_|_|_|  _|     '   
puts '    _|        _|  _|        _|      _|   '     
puts '    _|        _|_|          _|      _|   '     
puts '    _|        _|  _|        _|      _|  '      
puts '      _|_|_|  _|    _|      _|      _|_|_|_| '

    
    if User.current_session_id > 0
        puts "Welcome to CKTL, #{User.find_by_id(User.current_session_id).name}!"
        main_menu
    else
        login_prompt
    end
end

def login_prompt
    system("clear")
    puts 'MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNKXWMMMMMMMMMMMM'
    puts 'MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMXl.lXMMMMMMMMMMMM'
    puts 'MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMXc.,0WMMMMMMMMMMMM'
    puts 'MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMK;.:KMMMMMMMMMMMMMM'
    puts 'MMMMMMXxllllllllllllllllllllllllllllllllc   ;llllllo0WMMMMMM'
    puts 'MMMMMMWO:. .;ccccccccccccccccccccccccc:.  ,cccc   .dXMMMMMMM'
    puts 'MMMMMMMMNk,.;OWMMMMMMMMMMMMMMMMMWXOxxxo..oNMMXo..lKWMMMMMMMM'
    puts 'MMMMMMMMMMXd..cOXXXXXXXXXXXXXKK0o . , .  kXKd .:OWMMMMMMMMMM'
    puts 'MMMMMMMMMMMWKl..................  .oXNO;.....,kNMMMMMMMMMMMM'
    puts 'MMMMMMMMMMMMMW0:.                ,:kWMMk.  .dXMMMMMMMMMMMMMM'
    puts 'MMMMMMMMMMMMMMMNk,               :0NWN0: .lKWMMMMMMMMMMMMMMM'
    puts 'MMMMMMMMMMMMMMMMMXd               . , ..:0WMMMMMMMMMMMMMMMMM'
    puts 'MMMMMMMMMMMMMMMMMMMKl.                ,kNMMMMMMMMMMMMMMMMMMM'
    puts 'MMMMMMMMMMMMMMMMMMMMW0:.             dXMMMMMMMMMMMMMMMMMMMMM'
    puts 'MMMMMMMMMMMMMMMMMMMMMMNk,         .lKWMMMMMMMMMMMMMMMMMMMMMM'
    puts 'MMMMMMMMMMMMMMMMMMMMMMMMNx      .:0WMMMMMMMMMMMMMMMMMMMMMMMM'
    puts 'MMMMMMMMMMMMMMMMMMMMMMMMMMKl.   kNMMMMMMMMMMMMMMMMMMMMMMMMMM'
    puts 'MMMMMMMMMMMMMMMMMMMMMMMMMMMK, .oWMMMMMMMMMMMMMMMMMMMMMMMMMMM'
    puts 'MMMMMMMMMMMMMMMMMMMMMMMMMMMK, .dWMMMMMMMMMMMMMMMMMMMMMMMMMMM'
    puts 'MMMMMMMMMMMMMMMMMMMMMMMMMMMK, .dWMMMMMMMMMMMMMMMMMMMMMMMMMMM'
    puts 'MMMMMMMMMMMMMMMMMMMMMMMMMMMK, .dWMMMMMMMMMMMMMMMMMMMMMMMMMMM'
    puts 'MMMMMMMMMMMMMMMMMMMMMMMMMMMK, .dWMMMMMMMMMMMMMMMMMMMMMMMMMMM'
    puts 'MMMMMMMMMMMMMMMMMMMMMMMMMMMK, .dWMMMMMMMMMMMMMMMMMMMMMMMMMMM'
    puts 'MMMMMMMMMMMMMMMMMMMMMMMMMMMK, .dWMMMMMMMMMMMMMMMMMMMMMMMMMMM'
    puts 'MMMMMMMMMMMMMMMMMMMMMMMMMMMK, .dWMMMMMMMMMMMMMMMMMMMMMMMMMMM'
    puts 'MMMMMMMMMMMMMMMMMMMMMMMMMWNO  .lXWMMMMMMMMMMMMMMMMMMMMMMMMMM'
    puts 'MMMMMMMMMMMMMMMMMMMWX0kdl; .    .,coxOKNWMMMMMMMMMMMMMMMMMMM'
    puts 'MMMMMMMMMMMMMWXOdl:,..                . ;cox0NMMMMMMMMMMMMMM'
    puts 'MMMMMMMMMMMMMNx:,,,,,,,,,,,,,,,,,,,,,,,,,,,;lKMMMMMMMMMMMMMM'
    puts 'MMMMMMMMMMMMMMWNNNNNNNNNNNNNNNNNNNNNNNNNNNNNWWMMMMMMMMMMMMMM'
    puts '      _|_|_|  _|    _|  _|_|_|_|_|  _|     '   
    puts '    _|        _|  _|        _|      _|   '     
    puts '    _|        _|_|          _|      _|   '     
    puts '    _|        _|  _|        _|      _|  '      
    puts '      _|_|_|  _|    _|      _|      _|_|_|_| '
    puts ""
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
        print "\n#{name} was already found in our database. Logging you in."
        sleep(1)
        print '.'
        sleep(1)
        print '.'
        sleep(1)
        greeting
    else 
        choices = ["Try Again", "Create a profile", "Quit"]
        option = PROMPT.select("We could not find your profile, please try again or create a new profile.", choices)
        case option
        when "Try Again"
            log_into_profile
        when "Create a profile"
            create_account
        when "Quit"
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
    new_user = User.create(name: name)
    User.current_session_id = User.find_by(name: name).id
    puts "Welcome to CKTL, #{new_user.name}!"
    sleep(1.5)
    main_menu
end

def main_menu
    system ("clear")
    choices = ["Make CKTL", "Browse CKTL", "My Shelf", "My CKTL's", "Log Out", "Quit"]
    option = PROMPT.select("What's the move tonight?", choices)
    case option
    when "Make CKTL"
        make_CKTL
    when "Browse CKTL"
        browse_CKTL
    when "My Shelf"
        my_shelf
    when "My CKTL's"
        view_my_CKTLs
    when "Log Out"
        logout
    when "Quit"
        exit_CKTL
    end
end

def make_CKTL
    choices = ["What can I make?", "Surprise me ;)", "What am I close to making?", "Go back."]
    option = PROMPT.select("Great, how should we drink?", choices)
    case option
    when "What can I make?"
        possible_cocktails = User.find_by_id(User.current_session_id).possible_cocktails
        if possible_cocktails.empty?
            PROMPT.keypress("No possible cocktails found. You should add more ingredients to your shelf. Press space or enter to continue.", keys: [:space, :return])
            main_menu
        end
        make_from_possible(possible_cocktails)
    when "Surprise me ;)"
        possible_cocktails = User.find_by_id(User.current_session_id).possible_cocktails
        if possible_cocktails.empty?
            puts "Surprise: nothing! Let's add some items to your shelf first ;)"
            add_to_shelf_prompt
        end
        random_cocktail = Cocktail.random(possible_cocktails)
        render_cocktail(random_cocktail)
        make_CKTL
    when "Go back."
        main_menu
    when "What am I close to making?"
        almost_possible_cocktails = User.find_by_id(User.current_session_id).possible_cocktails_off_by_one
        if almost_possible_cocktails.empty?
            PROMPT.keypress("No possible cocktails found. You should add more ingredients to your shelf. Press space or enter to continue.", keys: [:space, :return])
            main_menu
        end
        make_from_possible(almost_possible_cocktails)
    end
end

def make_from_possible(possible_cocktails)
    choices = possible_cocktails
    option = PROMPT.select("Select a CKTL from the list to view its recipe.", choices)
    render_cocktail(option)
    make_CKTL
end

def render_cocktail(cocktail)
    name = Cocktail.find_by_name(cocktail).name # string
    ingredients = Cocktail.find_by_name(cocktail).get_ingredients # array of strings
    directions = Cocktail.find_by_name(cocktail).directions # string
    puts "*" * 25
    puts name
    puts "\nIngredients:"
    puts ingredients
    puts "\nDirections:"
    puts directions
    puts "*" * 25
    choices = ["Save CKTL", "Main Menu"]
    option = PROMPT.select("", choices)
    case option
    when "Save CKTL"
        if !(UserCocktail.find_by(user_id: User.find(User.current_session_id), cocktail_id: Cocktail.find_by(name: cocktail).id))  
            UserCocktail.save_CKTL(User.find(User.current_session_id).id, Cocktail.find_by(name: cocktail).id)
            puts "CKTL saved! Excellent choice."
        else
            puts "You already have this CKTL saved."
        end
    when "Main Menu"
        main_menu
    end
end

def browse_CKTL
    choices = ["Search CKTL", "Browse from a list of #{Cocktail.count} CKTL's", "Main Menu"]
    option = PROMPT.select("Let's browse...", choices)
    case option
    when "Search CKTL"
        search_CKTL
    when "Browse from a list of #{Cocktail.count} CKTL's"
        view_all_CKTL
    when "Main Menu"
        main_menu
    end
end

def view_all_CKTL
    choices = Cocktail.all_names
    option = PROMPT.select("What cocktail would you like to view?", choices)
    render_cocktail(option)
    browse_CKTL_reprompt
end

def view_my_CKTLs
    choices = User.find(User.current_session_id).view_my_CKTLs
    option = PROMPT.select("What cocktail would you like to view?", choices.concat(["<Go back>"]))
    if option == "<Go back>"
        main_menu
    else
        render_cocktail(option)
        browse_CKTL_reprompt
    end
end

def search_CKTL
    search_term = PROMPT.ask("Try searching for a CKTL, and we'll do our best to find it:")
    results = Cocktail.select_by_name(search_term)
    result_names = Cocktail.get_names(results)
    if !result_names.empty?
        option = PROMPT.select("What cocktail would you like to view?", result_names)
        render_cocktail(option)
        browse_CKTL_reprompt
    else
        choices = ["Try Again", "Go Back"]
        option = PROMPT.select("No results found, would you like to try again?", choices)
        case option
        when "Try Again"
            search_CKTL
        when "Go Back"
            browse_CKTL
        end
    end
end

def browse_CKTL_reprompt
    choices = ["View another cocktail", "Go back"]
    option = PROMPT.select("What would you like to do?", choices)
    case option
    when "View another cocktail"
        browse_CKTL
    when "Go back"
        main_menu
    end
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
    elsif (Ingredient.valid_ingredient(item))
        User.find_by_id(User.current_session_id).add_inventory(item)
        add_to_shelf_prompt
    else
        puts "Somehow, we don't have that item in our vast database."
        add_to_shelf_prompt
    end
end

def remove_from_shelf_prompt
    choices = User.find_by_id(User.current_session_id).inventory
    item = PROMPT.select('What would you like to remove from your shelf?', ["Nevermind, go back."].concat(choices))
    if item == "Nevermind, go back."
        my_shelf
    else
        User.find_by_id(User.current_session_id).remove_inventory(item)
    end
    remove_from_shelf_prompt
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
