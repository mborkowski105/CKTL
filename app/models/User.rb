require 'pry'

class User < ActiveRecord::Base
    has_many :user_cocktails
    has_many :cocktails, through: :user_cocktails
    has_many :user_ingredients
    has_many :ingredients, through: :user_ingredients

    def inventory # returns an array of ingredient names in the User's inventory
        ui = UserIngredient.all.select do |ui|
            ui.user_id == self.id
        end
        ui.map do |i|
            i.ingredient.name
        end
    end

    def add_inventory(new_name)
        match = UserIngredient.find_by(user_id: self.id, ingredient_id: Ingredient.find_by_name(new_name).id)
        
        if !(match)
            UserIngredient.create(user_id: self.id, ingredient_id: Ingredient.find_by_name(new_name).id)
            puts "Item added!"
        else
            puts "You already have this ingredient in your inventory."
        end
    end

    def remove_inventory(new_name)
        match = UserIngredient.find_by(user_id: self.id, ingredient_id: Ingredient.find_by(name: new_name).id)
        
        if !(match)
            puts "Error: Ingredient not found in inventory."
        else 
            match.delete
        end
    end

    def clear_inventory
        self.inventory.each do |ui|
            ui.delete
        end
    end

    def possible_cocktail(cocktail_ingredients, user_inventory) # cocktail_ingredients will be an array of ingredient names
        array = []
        user_inventory.each do |ui|
            if cocktail_ingredients.include?(ui)
                array << ui
            end
        end
        array.length == cocktail_ingredients.length
    end

    def off_by_one(cocktail_ingredients, user_inventory) # cocktail_ingredients will be an array of ingredient names
        array = []
        user_inventory.each do |ui|
            if cocktail_ingredients.include?(ui)
                array << ui
            end
        end
        array.length == cocktail_ingredients.length - 1
    end

    def possible_cocktails_off_by_one
        cocktail_object_list = Cocktail.all.select do |cocktail|
            off_by_one(cocktail.get_ingredients, self.inventory)
        end
        cocktail_object_list.map do |cocktail|
            cocktail.name
        end
    end

    def possible_cocktails
        cocktail_object_list = Cocktail.all
        possible_cocktail_list = cocktail_object_list.select do |cocktail|
            possible_cocktail(cocktail.get_ingredients, self.inventory)
        end
        possible_cocktail_list.map do |cocktail|
            cocktail.name
        end
    end
end

# if the intersection of the cocktail's ingredients and the user's inventory is == to the length of the cocktail's ingredients, the user can make this cocktail
# how do we allow an intersection to be true if the user's inventory item fuzzy matches a cocktail ingredient 
# (i.e. peach vodka => vodka)



    # ingredient_count=cocktail_ingredients.length
    # inventory_count=user_inventory.length
    # c_index=0
    # u_index=0
    # intersection_array = []
    # while (c_index < ingredient_count && u_index < inventory_count)
    #     if cocktail_ingredients[c_index] == user_inventory[u_index]
    #         intersection_array << "intersection found"
    #         c_index+=1
    #         u_index+=1
    #     else
    #         c_index+=1
    #         u_index+=1
    #     end
    # end