class CreateCocktailIngredientsTable < ActiveRecord::Migration[5.1]
    def change 
        create_table :cocktail_ingredients do |t|
          t.integer :cocktail_id
          t.integer :ingredient_id
          t.integer :quantity
    
          t.timestamps
        end
    end
end