class User < ActiveRecord::Base
    has_many :user_cocktails
    has_many :cocktails, through: :user_cocktails
    has_many :user_ingredients
    has_many :ingredients, through: :user_ingredients
end