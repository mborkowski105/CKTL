Cocktail.delete_all
Ingredient.delete_all
CocktailIngredient.delete_all
UserIngredient.delete_all

Cocktail.create(name: "Straight Vod", directions: "Pour up")
Cocktail.create(name: "Vodka and pedialyte", directions: "Full of healthy electrolytes")
Cocktail.create(name: "Long island iced tea", directions: "Stop after one")
Ingredient.create(name: "vodka")
Ingredient.create(name: "rum")
CocktailIngredient.create(cocktail_id: Cocktail.find_by(name: "Straight Vod").id, ingredient_id: Ingredient.find_by(name: "vodka").id)
