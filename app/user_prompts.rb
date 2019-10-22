require "tty-prompt"

PROMPT = TTY::Prompt.new

def greeting
    if User.find_by_id(1)
        puts "Welcome to CKTL, #{User.find_by_id(1).name}!"
    else puts "Welcome to CKTL!"
    end
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
    choices = ["View Shelf", "Add to Shelf", "Remove from Shelf", "Clear Shelf"]
    option = PROMPT.select("What would you like to do with your shelf?", choices)
    case option
    when "View Shelf"

    when "Add to Shelf"

    when "Remove from Shelf"

    when "Clear Shelf"
        User.find_by_id(1)
    end
end

