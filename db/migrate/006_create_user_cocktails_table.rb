class CreateUserCocktailsTable < ActiveRecord::Migration[5.1]
    def change 
        create_table :user_cocktails do |t|
          t.integer :user_id
          t.integer :cocktail_id
          t.integer :rating
    
          t.timestamps
        end
    end
end