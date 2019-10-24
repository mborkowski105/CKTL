class Ingredient < ActiveRecord::Base
    has_many :user_ingredients
    has_many :users, through: :user_ingredients
    has_many :cocktail_ingredients
    has_many :cocktails, through: :cocktail_ingredients

    def self.find_by_name(name)
        self.where('lower(name) LIKE ?', "%#{name.downcase}%").first
    end

    def self.select_by_name(name) #returns an array of ingredients that contains the search term
        self.where('lower(name) LIKE ?', "%#{name.downcase}%")
    end

    def self.valid_ingredient(name)
        !!Ingredient.find_by(name: name)
    end
end