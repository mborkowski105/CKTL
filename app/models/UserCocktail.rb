class UserCocktail < ActiveRecord::Base
    belongs_to :user
    belongs_to :cocktail

    def self.save_CKTL(user_id, cocktail_id)
        UserCocktail.create(user_id: user_id, cocktail_id: cocktail_id)
    end
end