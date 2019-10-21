class UserCocktail < ActiveRecord::Base
    belongs_to :user
    belongs_to :cocktail
end