require 'pry'

class User < ActiveRecord::Base
    has_many :user_cocktails
    has_many :cocktails, through: :user_cocktails
    has_many :user_ingredients
    has_many :ingredients, through: :user_ingredients

    def inventory
        return UserIngredient.all.select do |ui|
            ui.user_id == self.id
        end
    end

    def add_inventory(new_name, new_quantity)
        match = UserIngredient.find_by(user_id: self.id, ingredient_id: Ingredient.find_by(name: new_name).id)
        
        if !(match)
            UserIngredient.create(user_id: self.id, ingredient_id: Ingredient.find_by(name: new_name).id, quantity: new_quantity)
        else 
            match.update(quantity: match.quantity + new_quantity)
        end
    end

    def remove_inventory(new_name, new_quantity)
        match = UserIngredient.find_by(user_id: self.id, ingredient_id: Ingredient.find_by(name: new_name).id)
        
        if (match.quantity <= new_quantity)
            match.delete
        else 
            match.update(quantity: match.quantity - new_quantity)
        end
    end

    def clear_inventory
        self.inventory.each do |ui|
            ui.delete
        end
    end
end