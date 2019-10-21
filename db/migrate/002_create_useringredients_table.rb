class CreateUserIngredientsTable < ActiveRecord::Migration[5.1]
    def change 
        create_table :user_ingredients do |t|
          t.integer :user_id
          t.integer :ingredient_id
          t.integer :quantity
    
          t.timestamps
        end
    end
end