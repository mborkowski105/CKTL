class ChangeQuantityToString < ActiveRecord::Migration[5.1]
    def change 
        change_column :cocktail_ingredients, :quantity, :string
        change_column :user_ingredients, :quantity, :string
    end
end