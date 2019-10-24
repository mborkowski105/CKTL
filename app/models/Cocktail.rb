class Cocktail < ActiveRecord::Base
    has_many :cocktail_ingredients
    has_many :ingredients, through: :cocktail_ingredients
    has_many :user_cocktails
    has_many :users, through: :user_cocktails

    def self.find_by_ingredient(ingredient) # returns a list of cocktails by ingredient type
        matching_cocktail_ingredients = CocktailIngredient.all.select do |ci|
            ci.ingredient.name == ingredient
        end
        matching_cocktails = matching_cocktail_ingredients.map do |ci|
            ci.cocktail.name
        end
        matching_cocktails.uniq
    end

    def self.find_by_name(name) # returns the first cocktail that contains the search term
        self.where('lower(name) LIKE ?', "%#{name.downcase}%").first
    end

    def self.select_by_name(name) #returns an array of cocktails that contains the search term
        self.where('lower(name) LIKE ?', "%#{name.downcase}%")
    end

    def get_ingredients
        ingredients.map do |ingredient|
            ingredient.name
        end
    end
end