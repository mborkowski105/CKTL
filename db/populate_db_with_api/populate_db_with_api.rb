require 'bundler'
Bundler.require
# require_relative './app'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.sqlite3')
require_all 'app'

("a".."z").each do |letter|
    response = RestClient.get("https://www.thecocktaildb.com/api/json/v1/1/search.php?f=#{letter}")
    parsed_response = JSON.parse(response)["drinks"]
    alcoholic_parsed_response = parsed_response.select do |drink|
        drink["strAlcoholic"] == "Alcoholic"
    end

    alcoholic_parsed_response.each do |drink|
        c1 = Cocktail.create(name: drink["strDrink"], directions: drink["strInstructions"])
        (1..15).each do |index|
            if (drink["strIngredient#{index}"])
                i1 = Ingredient.find_or_create_by(name: drink["strIngredient#{index}"].strip.downcase)
                if (drink["strMeasure#{index}"])
                    CocktailIngredient.create(cocktail_id: c1.id, ingredient_id: i1.id, quantity: drink["strMeasure#{index}"].strip.downcase)
                else
                    CocktailIngredient.create(cocktail_id: c1.id, ingredient_id: i1.id, quantity: "Go crazy with the")
                end
            else
                break
            end
        end
    end
    break
    # if (letter == "z")
    #     break
    # end
    # puts "Finished #{letter}. Time to sleep."
    # sleep(30)
end