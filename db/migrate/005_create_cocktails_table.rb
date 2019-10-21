class CreateCocktailsTable < ActiveRecord::Migration[5.1]
    def change 
        create_table :cocktails do |t|
          t.string :name
          t.text :directions
    
          t.timestamps
        end
    end
end