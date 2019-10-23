class RemoveQuantityFromUserIngredients < ActiveRecord::Migration[5.1]
    def change 
        remove_column :user_ingredients, :quantity
    end
end