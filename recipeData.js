// Recipe Database for SavoyConnect
// Recipes are mapped to main ingredients found in ice cream flavors

const recipeDatabase = {
    // MANGO RECIPES
    'mango': [
        {
            id: 'mango-smoothie',
            name: 'Tropical Mango Smoothie',
            image: '🥭',
            category: 'Beverages',
            difficulty: 'Easy',
            prepTime: '5 min',
            servings: '2',
            mainIngredient: 'mango',
            description: 'A refreshing tropical smoothie perfect for hot summer days',
            ingredients: [
                '2 ripe mangoes (peeled and diced)',
                '1 cup yogurt',
                '1/2 cup milk',
                '2 tbsp honey',
                'Ice cubes',
                'Mint leaves for garnish'
            ],
            instructions: [
                'Add diced mangoes to blender',
                'Pour in yogurt and milk',
                'Add honey and ice cubes',
                'Blend until smooth and creamy',
                'Pour into glasses and garnish with mint'
            ],
            tips: 'Use frozen mango chunks for a thicker consistency'
        },
        {
            id: 'mango-salsa',
            name: 'Fresh Mango Salsa',
            image: '🥭',
            category: 'Appetizers',
            difficulty: 'Easy',
            prepTime: '15 min',
            servings: '4',
            mainIngredient: 'mango',
            description: 'A vibrant and zesty salsa perfect with chips or grilled fish',
            ingredients: [
                '2 ripe mangoes (diced)',
                '1 red onion (finely chopped)',
                '1 jalapeño (minced)',
                '1/4 cup cilantro (chopped)',
                'Juice of 2 limes',
                'Salt to taste'
            ],
            instructions: [
                'Dice mangoes into small cubes',
                'Combine with onion, jalapeño, and cilantro',
                'Add lime juice and salt',
                'Mix well and refrigerate for 30 minutes',
                'Serve with tortilla chips or as a topping'
            ],
            tips: 'Let it sit for flavors to meld together'
        },
        {
            id: 'mango-lassi',
            name: 'Classic Mango Lassi',
            image: '🥭',
            category: 'Beverages',
            difficulty: 'Easy',
            prepTime: '10 min',
            servings: '3',
            mainIngredient: 'mango',
            description: 'Traditional Indian yogurt-based drink with sweet mango',
            ingredients: [
                '2 cups ripe mango (chopped)',
                '1 cup plain yogurt',
                '1/2 cup milk',
                '3 tbsp sugar',
                '1/4 tsp cardamom powder',
                'Ice cubes'
            ],
            instructions: [
                'Blend mangoes until smooth',
                'Add yogurt, milk, and sugar',
                'Add cardamom powder',
                'Blend with ice until frothy',
                'Serve chilled with a sprinkle of cardamom on top'
            ],
            tips: 'Use Alphonso mangoes for authentic flavor'
        }
    ],

    // STRAWBERRY RECIPES
    'strawberry': [
        {
            id: 'strawberry-shortcake',
            name: 'Classic Strawberry Shortcake',
            image: '🍓',
            category: 'Desserts',
            difficulty: 'Medium',
            prepTime: '30 min',
            servings: '6',
            mainIngredient: 'strawberry',
            description: 'Light and fluffy cake layers with fresh strawberries and cream',
            ingredients: [
                '2 cups fresh strawberries (sliced)',
                '2 cups all-purpose flour',
                '1/4 cup sugar',
                '1 cup heavy cream',
                '3 tbsp butter',
                '1 tsp vanilla extract'
            ],
            instructions: [
                'Slice strawberries and macerate with sugar',
                'Prepare biscuit dough with flour and butter',
                'Bake biscuits until golden',
                'Whip cream with vanilla',
                'Layer biscuits with strawberries and cream'
            ],
            tips: 'Let strawberries sit in sugar for maximum juice'
        },
        {
            id: 'strawberry-salad',
            name: 'Strawberry Spinach Salad',
            image: '🍓',
            category: 'Salads',
            difficulty: 'Easy',
            prepTime: '15 min',
            servings: '4',
            mainIngredient: 'strawberry',
            description: 'Healthy salad with sweet strawberries and tangy balsamic',
            ingredients: [
                '2 cups fresh strawberries (sliced)',
                '4 cups baby spinach',
                '1/2 cup walnuts',
                '1/4 cup feta cheese',
                'Balsamic vinaigrette',
                'Red onion (optional)'
            ],
            instructions: [
                'Wash and dry spinach leaves',
                'Slice strawberries and add to spinach',
                'Toast walnuts lightly',
                'Crumble feta cheese over salad',
                'Drizzle with balsamic vinaigrette'
            ],
            tips: 'Add grilled chicken for a complete meal'
        },
        {
            id: 'strawberry-jam',
            name: 'Homemade Strawberry Jam',
            image: '🍓',
            category: 'Preserves',
            difficulty: 'Medium',
            prepTime: '45 min',
            servings: '8',
            mainIngredient: 'strawberry',
            description: 'Sweet and chunky strawberry jam perfect for toast',
            ingredients: [
                '4 cups fresh strawberries (hulled)',
                '2 cups sugar',
                '1/4 cup lemon juice',
                '1 tsp lemon zest',
                'Pectin (optional)'
            ],
            instructions: [
                'Crush strawberries slightly',
                'Combine with sugar and lemon juice',
                'Cook over medium heat, stirring constantly',
                'Simmer until thickened (about 25 minutes)',
                'Pour into sterilized jars and seal'
            ],
            tips: 'Test thickness by placing a drop on a cold plate'
        }
    ],

    // CHOCOLATE RECIPES
    'chocolate': [
        {
            id: 'chocolate-brownies',
            name: 'Fudgy Chocolate Brownies',
            image: '🍫',
            category: 'Desserts',
            difficulty: 'Easy',
            prepTime: '35 min',
            servings: '12',
            mainIngredient: 'chocolate',
            description: 'Rich, fudgy brownies with a crackly top',
            ingredients: [
                '200g dark chocolate',
                '3/4 cup butter',
                '1 cup sugar',
                '3 eggs',
                '3/4 cup flour',
                '1/4 cup cocoa powder'
            ],
            instructions: [
                'Melt chocolate and butter together',
                'Mix in sugar and eggs',
                'Fold in flour and cocoa',
                'Pour into greased pan',
                'Bake at 350°F for 25-30 minutes'
            ],
            tips: 'Don\'t overbake for fudgy texture'
        },
        {
            id: 'hot-chocolate',
            name: 'Rich Hot Chocolate',
            image: '🍫',
            category: 'Beverages',
            difficulty: 'Easy',
            prepTime: '10 min',
            servings: '2',
            mainIngredient: 'chocolate',
            description: 'Creamy, indulgent hot chocolate made with real chocolate',
            ingredients: [
                '2 cups whole milk',
                '100g dark chocolate (chopped)',
                '2 tbsp sugar',
                '1 tsp vanilla extract',
                'Whipped cream',
                'Cocoa powder for dusting'
            ],
            instructions: [
                'Heat milk in a saucepan',
                'Add chopped chocolate and stir',
                'Whisk in sugar and vanilla',
                'Simmer until chocolate melts completely',
                'Serve with whipped cream and cocoa dust'
            ],
            tips: 'Use high-quality chocolate for best flavor'
        },
        {
            id: 'chocolate-mousse',
            name: 'Classic Chocolate Mousse',
            image: '🍫',
            category: 'Desserts',
            difficulty: 'Medium',
            prepTime: '20 min + chill',
            servings: '4',
            mainIngredient: 'chocolate',
            description: 'Light and airy chocolate mousse with intense flavor',
            ingredients: [
                '200g dark chocolate',
                '3 eggs (separated)',
                '2 tbsp sugar',
                '1 cup heavy cream',
                '1 tsp vanilla',
                'Chocolate shavings for garnish'
            ],
            instructions: [
                'Melt chocolate and let cool slightly',
                'Beat egg whites until stiff peaks',
                'Whip cream separately',
                'Fold egg yolks into chocolate',
                'Gently fold in cream and egg whites',
                'Chill for 4 hours before serving'
            ],
            tips: 'Fold gently to maintain airiness'
        }
    ],

    // VANILLA RECIPES
    'vanilla': [
        {
            id: 'vanilla-cupcakes',
            name: 'Classic Vanilla Cupcakes',
            image: '🧁',
            category: 'Desserts',
            difficulty: 'Easy',
            prepTime: '30 min',
            servings: '12',
            mainIngredient: 'vanilla',
            description: 'Fluffy vanilla cupcakes with buttercream frosting',
            ingredients: [
                '1 1/2 cups flour',
                '1 cup sugar',
                '1/2 cup butter',
                '2 eggs',
                '1 tbsp vanilla extract',
                'Buttercream frosting'
            ],
            instructions: [
                'Cream butter and sugar',
                'Add eggs and vanilla',
                'Mix in flour and milk alternately',
                'Fill cupcake liners 2/3 full',
                'Bake at 350°F for 18-20 minutes',
                'Cool and frost'
            ],
            tips: 'Don\'t overmix the batter'
        },
        {
            id: 'vanilla-pudding',
            name: 'Creamy Vanilla Pudding',
            image: '🍮',
            category: 'Desserts',
            difficulty: 'Easy',
            prepTime: '20 min',
            servings: '4',
            mainIngredient: 'vanilla',
            description: 'Smooth and creamy homemade vanilla pudding',
            ingredients: [
                '2 cups whole milk',
                '1/2 cup sugar',
                '3 tbsp cornstarch',
                '2 egg yolks',
                '2 tsp vanilla extract',
                'Pinch of salt'
            ],
            instructions: [
                'Mix sugar, cornstarch, and salt',
                'Heat milk in saucepan',
                'Whisk in dry ingredients',
                'Temper egg yolks and add to mixture',
                'Cook until thickened',
                'Stir in vanilla and chill'
            ],
            tips: 'Cover with plastic wrap touching surface to prevent skin'
        }
    ],

    // COFFEE RECIPES
    'coffee': [
        {
            id: 'coffee-tiramisu',
            name: 'Classic Tiramisu',
            image: '☕',
            category: 'Desserts',
            difficulty: 'Medium',
            prepTime: '30 min + chill',
            servings: '8',
            mainIngredient: 'coffee',
            description: 'Italian coffee-flavored dessert with mascarpone',
            ingredients: [
                '1 cup strong espresso',
                '500g mascarpone cheese',
                '4 eggs (separated)',
                '1/2 cup sugar',
                'Ladyfinger biscuits',
                'Cocoa powder for dusting'
            ],
            instructions: [
                'Brew strong espresso and let cool',
                'Beat egg yolks with sugar',
                'Fold in mascarpone',
                'Beat egg whites and fold in',
                'Dip ladyfingers in espresso',
                'Layer in dish and chill overnight',
                'Dust with cocoa before serving'
            ],
            tips: 'Use quality espresso for authentic flavor'
        },
        {
            id: 'iced-coffee',
            name: 'Perfect Iced Coffee',
            image: '☕',
            category: 'Beverages',
            difficulty: 'Easy',
            prepTime: '5 min',
            servings: '1',
            mainIngredient: 'coffee',
            description: 'Refreshing iced coffee with cold brew method',
            ingredients: [
                '1 cup cold brew coffee',
                '1/2 cup milk or cream',
                '2 tbsp simple syrup',
                'Ice cubes',
                'Vanilla extract (optional)'
            ],
            instructions: [
                'Fill glass with ice',
                'Pour cold brew over ice',
                'Add milk and sweetener',
                'Stir well',
                'Add vanilla if desired'
            ],
            tips: 'Make coffee ice cubes to prevent dilution'
        }
    ],

    // COCONUT RECIPES
    'coconut': [
        {
            id: 'coconut-curry',
            name: 'Thai Coconut Curry',
            image: '🥥',
            category: 'Main Course',
            difficulty: 'Medium',
            prepTime: '40 min',
            servings: '4',
            mainIngredient: 'coconut',
            description: 'Creamy Thai curry with coconut milk',
            ingredients: [
                '2 cups coconut milk',
                '2 tbsp red curry paste',
                'Mixed vegetables',
                'Chicken or tofu',
                'Fish sauce',
                'Fresh basil leaves'
            ],
            instructions: [
                'Heat coconut milk in pan',
                'Add curry paste and stir',
                'Add protein and vegetables',
                'Simmer until cooked',
                'Season with fish sauce',
                'Garnish with basil'
            ],
            tips: 'Use full-fat coconut milk for creaminess'
        },
        {
            id: 'coconut-macaroons',
            name: 'Coconut Macaroons',
            image: '🥥',
            category: 'Desserts',
            difficulty: 'Easy',
            prepTime: '25 min',
            servings: '18',
            mainIngredient: 'coconut',
            description: 'Sweet and chewy coconut cookies',
            ingredients: [
                '3 cups shredded coconut',
                '2/3 cup sweetened condensed milk',
                '1 tsp vanilla extract',
                '2 egg whites',
                'Pinch of salt',
                'Chocolate for drizzling (optional)'
            ],
            instructions: [
                'Mix coconut with condensed milk',
                'Beat egg whites until stiff',
                'Fold into coconut mixture',
                'Form into mounds on baking sheet',
                'Bake at 325°F for 20-25 minutes',
                'Drizzle with melted chocolate'
            ],
            tips: 'Toast coconut first for deeper flavor'
        }
    ],

    // PISTACHIO RECIPES
    'pistachio': [
        {
            id: 'pistachio-baklava',
            name: 'Pistachio Baklava',
            image: '🥜',
            category: 'Desserts',
            difficulty: 'Hard',
            prepTime: '90 min',
            servings: '24',
            mainIngredient: 'pistachio',
            description: 'Middle Eastern pastry with pistachios and honey',
            ingredients: [
                '2 cups pistachios (ground)',
                '1 package phyllo dough',
                '1 cup butter (melted)',
                '1 cup honey',
                '1/2 cup sugar',
                'Lemon juice',
                'Cinnamon'
            ],
            instructions: [
                'Layer phyllo sheets with butter',
                'Spread pistachio mixture',
                'Continue layering',
                'Cut into diamonds',
                'Bake until golden',
                'Pour honey syrup over hot baklava'
            ],
            tips: 'Keep phyllo covered with damp towel'
        }
    ],

    // LEMON RECIPES
    'lemon': [
        {
            id: 'lemon-bars',
            name: 'Tangy Lemon Bars',
            image: '🍋',
            category: 'Desserts',
            difficulty: 'Medium',
            prepTime: '50 min',
            servings: '16',
            mainIngredient: 'lemon',
            description: 'Sweet and tart lemon bars with buttery crust',
            ingredients: [
                '1 cup butter',
                '2 cups flour',
                '1/2 cup powdered sugar',
                '4 eggs',
                '2 cups sugar',
                '1/3 cup lemon juice',
                'Lemon zest'
            ],
            instructions: [
                'Make crust with butter, flour, powdered sugar',
                'Bake crust until golden',
                'Mix eggs, sugar, lemon juice',
                'Pour over hot crust',
                'Bake until set',
                'Cool and dust with powdered sugar'
            ],
            tips: 'Use fresh lemon juice for best flavor'
        },
        {
            id: 'lemonade',
            name: 'Classic Fresh Lemonade',
            image: '🍋',
            category: 'Beverages',
            difficulty: 'Easy',
            prepTime: '10 min',
            servings: '4',
            mainIngredient: 'lemon',
            description: 'Refreshing homemade lemonade',
            ingredients: [
                '1 cup fresh lemon juice',
                '1 cup sugar',
                '6 cups cold water',
                'Ice cubes',
                'Lemon slices',
                'Mint leaves'
            ],
            instructions: [
                'Make simple syrup with sugar and 1 cup water',
                'Cool syrup completely',
                'Mix lemon juice with remaining water',
                'Add simple syrup to taste',
                'Serve over ice with lemon slices'
            ],
            tips: 'Roll lemons before juicing for more juice'
        }
    ],

    // MINT RECIPES
    'mint': [
        {
            id: 'mint-mojito',
            name: 'Fresh Mint Mojito',
            image: '🌿',
            category: 'Beverages',
            difficulty: 'Easy',
            prepTime: '10 min',
            servings: '1',
            mainIngredient: 'mint',
            description: 'Refreshing Cuban cocktail with mint and lime',
            ingredients: [
                'Fresh mint leaves',
                '2 oz white rum',
                '1 oz lime juice',
                '2 tsp sugar',
                'Soda water',
                'Ice cubes'
            ],
            instructions: [
                'Muddle mint with sugar and lime',
                'Add rum and stir',
                'Fill glass with ice',
                'Top with soda water',
                'Garnish with mint sprig'
            ],
            tips: 'Gently bruise mint, don\'t tear'
        }
    ],

    // CARAMEL RECIPES
    'caramel': [
        {
            id: 'caramel-flan',
            name: 'Classic Caramel Flan',
            image: '🍮',
            category: 'Desserts',
            difficulty: 'Medium',
            prepTime: '60 min + chill',
            servings: '6',
            mainIngredient: 'caramel',
            description: 'Silky custard with caramel sauce',
            ingredients: [
                '1 cup sugar (for caramel)',
                '4 eggs',
                '1 can condensed milk',
                '1 can evaporated milk',
                '1 tsp vanilla extract'
            ],
            instructions: [
                'Make caramel and pour into mold',
                'Blend eggs, milks, and vanilla',
                'Pour over caramel',
                'Bake in water bath',
                'Chill overnight',
                'Invert to serve'
            ],
            tips: 'Don\'t let caramel get too dark'
        }
    ],

    // CHERRY RECIPES
    'cherry': [
        {
            id: 'cherry-pie',
            name: 'Classic Cherry Pie',
            image: '🍒',
            category: 'Desserts',
            difficulty: 'Medium',
            prepTime: '90 min',
            servings: '8',
            mainIngredient: 'cherry',
            description: 'Traditional American cherry pie with lattice top',
            ingredients: [
                '4 cups fresh cherries (pitted)',
                '1 cup sugar',
                '3 tbsp cornstarch',
                'Pie crust (top and bottom)',
                '1 tbsp butter',
                'Lemon juice'
            ],
            instructions: [
                'Mix cherries with sugar and cornstarch',
                'Let sit for 15 minutes',
                'Fill pie crust with cherry mixture',
                'Dot with butter',
                'Cover with lattice top',
                'Bake at 375°F for 50-60 minutes'
            ],
            tips: 'Use tart cherries for best flavor'
        }
    ],

    // BLUEBERRY RECIPES
    'blueberry': [
        {
            id: 'blueberry-muffins',
            name: 'Blueberry Muffins',
            image: '🫐',
            category: 'Breakfast',
            difficulty: 'Easy',
            prepTime: '30 min',
            servings: '12',
            mainIngredient: 'blueberry',
            description: 'Fluffy muffins bursting with fresh blueberries',
            ingredients: [
                '2 cups flour',
                '2 tsp baking powder',
                '1/2 cup sugar',
                '1 egg',
                '1 cup milk',
                '2 cups fresh blueberries'
            ],
            instructions: [
                'Mix dry ingredients',
                'Combine wet ingredients',
                'Fold wet into dry gently',
                'Fold in blueberries',
                'Fill muffin cups',
                'Bake at 375°F for 20-25 minutes'
            ],
            tips: 'Toss blueberries in flour to prevent sinking'
        }
    ],

    // COOKIES RECIPES (Cookies & Cream flavor)
    'cookies': [
        {
            id: 'chocolate-chip-cookies',
            name: 'Classic Chocolate Chip Cookies',
            image: '🍪',
            category: 'Desserts',
            difficulty: 'Easy',
            prepTime: '25 min',
            servings: '24',
            mainIngredient: 'cookies',
            description: 'Chewy chocolate chip cookies with crispy edges',
            ingredients: [
                '2 1/4 cups flour',
                '1 cup butter',
                '3/4 cup brown sugar',
                '1/4 cup white sugar',
                '2 eggs',
                '2 cups chocolate chips'
            ],
            instructions: [
                'Cream butter and sugars',
                'Beat in eggs',
                'Mix in flour',
                'Fold in chocolate chips',
                'Drop spoonfuls on baking sheet',
                'Bake at 375°F for 10-12 minutes'
            ],
            tips: 'Chill dough for thicker cookies'
        }
    ]
};

// Ingredient mapping for ice cream flavors
const ingredientMapping = {
    'chocolate-delight': 'chocolate',
    'strawberry-bliss': 'strawberry',
    'vanilla-classic': 'vanilla',
    'mango-tango': 'mango',
    'cookies-cream': 'cookies',
    'mint-chocolate': 'mint',
    'pistachio-dream': 'pistachio',
    'caramel-swirl': 'caramel',
    'blueberry-burst': 'blueberry',
    'lychee-rose': 'lychee',
    'coconut-dream': 'coconut',
    'lemon-sorbet': 'lemon',
    'cherry-garcia': 'cherry',
    'coffee-crunch': 'coffee'
};

// Function to get recipes by ingredient
function getRecipesByIngredient(ingredient) {
    return recipeDatabase[ingredient] || [];
}

// Function to get recipes for an ice cream flavor
function getRecipesForFlavor(flavorId) {
    const ingredient = ingredientMapping[flavorId];
    return ingredient ? getRecipesByIngredient(ingredient) : [];
}
