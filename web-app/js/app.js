// SavoyConnect Web App - Main JavaScript
// Cross-platform functionality

/* ========================================
   FLAVOR DATA
   ======================================== */

// Flavor data with stories and ingredients
const flavorData = {
    'chocolate-delight': {
        name: 'Chocolate Delight',
        icon: '🍫',
        tagline: 'Rich & Creamy',
        badge: '🔥 Trending',
        badgeClass: 'badge-trending',
        mainIngredient: 'chocolate',
        story: 'Crafted with premium Belgian chocolate and fresh cream, Chocolate Delight has been a customer favorite since 1995. Our master ice cream makers spent months perfecting this recipe, combining rich cocoa with just the right amount of sweetness to create a truly indulgent experience.',
        ingredients: ['🥛 Fresh Milk', '🍫 Belgian Chocolate', '🧈 Pure Cream', '🍬 Natural Sugar', '🧂 Sea Salt', '🌿 Vanilla Extract'],
        nutrition: {
            servingSize: '100g',
            calories: '220 kcal',
            fat: '12g',
            carbs: '24g',
            protein: '4g'
        },
        availability: 'In stock at 15 stores near you'
    },
    'strawberry-bliss': {
        name: 'Strawberry Bliss',
        icon: '🍓',
        tagline: 'Fresh & Sweet',
        badge: '🔥 Trending',
        badgeClass: 'badge-trending',
        mainIngredient: 'strawberry',
        story: 'Made with handpicked strawberries from local farms, Strawberry Bliss captures the essence of summer in every scoop. We use only the ripest berries, carefully selected at peak season and blended into our signature cream base for an authentic fruit experience.',
        ingredients: ['🥛 Fresh Milk', '🍓 Fresh Strawberries', '🧈 Cream', '🍬 Cane Sugar', '🍋 Lemon Zest', '🌸 Natural Flavoring'],
        nutrition: {
            servingSize: '100g',
            calories: '180 kcal',
            fat: '8g',
            carbs: '26g',
            protein: '3g'
        },
        availability: 'In stock at 18 stores near you'
    },
    'vanilla-classic': {
        name: 'Vanilla Classic',
        icon: '🍦',
        tagline: 'Pure & Simple',
        badge: '',
        badgeClass: '',
        mainIngredient: 'vanilla',
        story: 'Our Vanilla Classic is made with real Madagascar vanilla beans, creating a pure and timeless flavor. This recipe has remained unchanged for over 30 years, staying true to the traditional ice cream experience that generations have loved.',
        ingredients: ['🥛 Whole Milk', '🌿 Madagascar Vanilla', '🧈 Heavy Cream', '🍬 Pure Sugar', '🥚 Egg Yolks'],
        nutrition: {
            servingSize: '100g',
            calories: '200 kcal',
            fat: '11g',
            carbs: '22g',
            protein: '4g'
        },
        availability: 'In stock at 20 stores near you'
    },
    'mango-tango': {
        name: 'Mango Tango',
        icon: '🥭',
        tagline: 'Tropical Twist',
        badge: '🔥 Trending',
        badgeClass: 'badge-trending',
        mainIngredient: 'mango',
        story: 'Inspired by tropical paradise, Mango Tango features the finest Alphonso mangoes imported from India. Each batch is made with real mango pulp, delivering an explosion of tropical flavor that transports you to sunny beaches with every bite.',
        ingredients: ['🥛 Coconut Milk', '🥭 Alphonso Mango', '🍯 Natural Honey', '🍋 Lime Juice', '🌴 Tropical Essence'],
        nutrition: {
            servingSize: '100g',
            calories: '190 kcal',
            fat: '9g',
            carbs: '28g',
            protein: '2g'
        },
        availability: 'In stock at 12 stores near you'
    },
    'cookies-cream': {
        name: 'Cookies & Cream',
        icon: '🍪',
        tagline: 'Classic Favorite',
        badge: '',
        badgeClass: '',
        mainIngredient: 'cookies',
        story: 'A beloved classic since 1985, our Cookies & Cream combines our smooth vanilla base with chunks of chocolate sandwich cookies. We use premium cookies that maintain their crunch, creating the perfect texture contrast in every spoonful.',
        ingredients: ['🥛 Fresh Milk', '🍪 Chocolate Cookies', '🧈 Cream', '🍬 Sugar', '🌿 Vanilla', '🍫 Cocoa Powder'],
        nutrition: {
            servingSize: '100g',
            calories: '240 kcal',
            fat: '13g',
            carbs: '28g',
            protein: '4g'
        },
        availability: 'In stock at 16 stores near you'
    },
    'mint-chocolate': {
        name: 'Mint Chocolate',
        icon: '🌿',
        tagline: 'Cool & Refreshing',
        badge: '🔥 Trending',
        badgeClass: 'badge-trending',
        mainIngredient: 'mint',
        story: 'Our Mint Chocolate features real peppermint extract and dark chocolate chips for a refreshing yet indulgent experience. The perfect balance of cool mint and rich chocolate has made this a year-round favorite among our customers.',
        ingredients: ['🥛 Fresh Milk', '🌿 Peppermint Extract', '🍫 Dark Chocolate Chips', '🧈 Cream', '🍬 Sugar', '🌱 Natural Mint'],
        nutrition: {
            servingSize: '100g',
            calories: '210 kcal',
            fat: '11g',
            carbs: '25g',
            protein: '4g'
        },
        availability: 'In stock at 14 stores near you'
    },
    'pistachio-dream': {
        name: 'Pistachio Dream',
        icon: '🥜',
        tagline: 'Nutty & Rich',
        badge: '🚀 Upcoming',
        badgeClass: 'badge-upcoming',
        mainIngredient: 'pistachio',
        story: 'Coming this November! Made with premium California pistachios, this luxurious flavor offers a rich, nutty taste with a smooth, creamy texture. We grind fresh pistachios daily to ensure maximum flavor and natural color without any artificial additives.',
        ingredients: ['🥛 Whole Milk', '🥜 California Pistachios', '🧈 Heavy Cream', '🍯 Honey', '🌿 Almond Extract', '🧂 Pink Salt'],
        nutrition: {
            servingSize: '100g',
            calories: '250 kcal',
            fat: '15g',
            carbs: '23g',
            protein: '6g'
        },
        availability: 'Launching November 15, 2025'
    },
    'caramel-swirl': {
        name: 'Caramel Swirl',
        icon: '🍮',
        tagline: 'Sweet & Buttery',
        badge: '🚀 Upcoming',
        badgeClass: 'badge-upcoming',
        mainIngredient: 'caramel',
        story: 'Arriving in December! Our Caramel Swirl features ribbons of homemade salted caramel throughout a rich vanilla base. The caramel is slow-cooked to perfection, creating deep caramelized notes that complement the smooth ice cream.',
        ingredients: ['🥛 Fresh Milk', '🍮 Salted Caramel', '🧈 Butter', '🍬 Brown Sugar', '🌿 Vanilla Bean', '🧂 Sea Salt'],
        nutrition: {
            servingSize: '100g',
            calories: '230 kcal',
            fat: '12g',
            carbs: '29g',
            protein: '3g'
        },
        availability: 'Launching December 1, 2025'
    },
    'blueberry-burst': {
        name: 'Blueberry Burst',
        icon: '🫐',
        tagline: 'Berry Explosion',
        badge: '🚀 Upcoming',
        badgeClass: 'badge-upcoming',
        mainIngredient: 'blueberry',
        story: 'Coming Soon! Packed with fresh blueberries and a hint of lemon, this flavor celebrates the vibrant taste of summer berries. Each batch contains over 30% real blueberries, making it one of our most fruit-forward creations.',
        ingredients: ['🥛 Fresh Milk', '🫐 Wild Blueberries', '🧈 Cream', '🍯 Natural Honey', '🍋 Lemon Zest', '🌸 Lavender Hint'],
        nutrition: {
            servingSize: '100g',
            calories: '185 kcal',
            fat: '8g',
            carbs: '27g',
            protein: '3g'
        },
        availability: 'Launching January 2026'
    }
};

// All Recipes Database
const allRecipesDatabase = {
    'vanilla-sundae': {
        id: 'vanilla-sundae',
        name: 'Vanilla Ice Cream Sundae',
        category: 'Desserts',
        image: '🍦',
        prepTime: '15 min',
        servings: '1',
        difficulty: 'Easy',
        description: 'Classic sundae with vanilla ice cream, chocolate sauce, and toppings',
        ingredients: [
            '3 scoops Savoy Vanilla Ice Cream',
            '1/4 cup chocolate sauce',
            '2 tablespoons caramel sauce',
            'Whipped cream',
            '2 tablespoons chopped nuts',
            'Rainbow sprinkles',
            'Cherry on top'
        ],
        instructions: [
            'Place 3 scoops of vanilla ice cream in a sundae dish',
            'Drizzle chocolate sauce generously over the ice cream',
            'Add caramel sauce in a spiral pattern',
            'Top with a large dollop of whipped cream',
            'Sprinkle chopped nuts over the whipped cream',
            'Add rainbow sprinkles for color',
            'Place a cherry on top',
            'Serve immediately with a long spoon'
        ],
        tips: 'Warm the chocolate sauce slightly for better drizzling. Use toasted nuts for extra crunch and flavor.'
    },
    'chocolate-milkshake': {
        id: 'chocolate-milkshake',
        name: 'Chocolate Milkshake',
        category: 'Shakes',
        image: '🥤',
        prepTime: '10 min',
        servings: '2',
        difficulty: 'Easy',
        description: 'Rich and creamy chocolate shake with ice cream',
        ingredients: [
            '3 cups Savoy Chocolate Ice Cream',
            '1 cup whole milk',
            '2 tablespoons chocolate syrup',
            '1 tablespoon cocoa powder',
            'Whipped cream for topping',
            'Chocolate shavings',
            'Chocolate wafer sticks'
        ],
        instructions: [
            'Add chocolate ice cream, milk, chocolate syrup, and cocoa powder to blender',
            'Blend on high speed until smooth and thick',
            'Taste and add more chocolate syrup if desired',
            'Pour into tall glasses',
            'Top with generous whipped cream',
            'Sprinkle chocolate shavings on top',
            'Add a chocolate wafer stick',
            'Serve with a thick straw'
        ],
        tips: 'For extra richness, add a tablespoon of peanut butter or Nutella before blending. Freeze glasses beforehand for an extra cold shake.'
    },
    'mango-lassi': {
        id: 'mango-lassi',
        name: 'Classic Mango Lassi',
        category: 'Beverages',
        image: '🥭',
        prepTime: '10 min',
        servings: '2',
        difficulty: 'Easy',
        description: 'A refreshing traditional yogurt-based drink blended with ripe mangoes and Savoy Mango ice cream',
        ingredients: [
            '2 cups Savoy Mango Ice Cream',
            '1 cup plain yogurt',
            '1 ripe mango, diced',
            '1/2 cup milk',
            '2 tablespoons honey',
            'Ice cubes',
            'Cardamom powder for garnish'
        ],
        instructions: [
            'Add Savoy Mango ice cream, yogurt, fresh mango, milk, and honey to a blender',
            'Blend until smooth and creamy',
            'Add ice cubes and blend again for 10 seconds',
            'Pour into glasses',
            'Garnish with a pinch of cardamom powder',
            'Serve immediately and enjoy!'
        ],
        tips: 'For a thicker consistency, use frozen mango chunks. Add more ice cream for extra creaminess.'
    },
    'chocolate-brownie': {
        id: 'chocolate-brownie',
        name: 'Chocolate Brownie Sundae',
        category: 'Desserts',
        image: '🍫',
        prepTime: '25 min',
        servings: '4',
        difficulty: 'Medium',
        description: 'Warm chocolate brownies topped with vanilla ice cream, chocolate sauce, and nuts',
        ingredients: [
            '4 chocolate brownies (homemade or store-bought)',
            '4 scoops Savoy Vanilla Ice Cream',
            '1/2 cup chocolate sauce',
            '1/4 cup chopped walnuts',
            '1/4 cup chocolate chips',
            'Whipped cream',
            'Fresh cherries for garnish'
        ],
        instructions: [
            'Warm the brownies in the oven at 350°F for 5 minutes',
            'Place each warm brownie in a serving bowl',
            'Top each brownie with a generous scoop of Savoy Vanilla ice cream',
            'Drizzle with warm chocolate sauce',
            'Sprinkle chopped walnuts and chocolate chips',
            'Add whipped cream and a cherry on top',
            'Serve immediately while brownie is warm'
        ],
        tips: 'The contrast between warm brownie and cold ice cream creates the perfect texture. Use premium chocolate sauce for best results.'
    },
    'strawberry-shake': {
        id: 'strawberry-shake',
        name: 'Strawberry Milkshake',
        category: 'Shakes',
        image: '🍓',
        prepTime: '5 min',
        servings: '2',
        difficulty: 'Easy',
        description: 'Creamy milkshake made with fresh strawberries and Savoy Strawberry ice cream',
        ingredients: [
            '3 cups Savoy Strawberry Ice Cream',
            '1 cup fresh strawberries',
            '1 cup whole milk',
            '2 tablespoons sugar',
            'Whipped cream for topping',
            'Fresh strawberry for garnish'
        ],
        instructions: [
            'Hull and slice fresh strawberries',
            'Add ice cream, strawberries, milk, and sugar to blender',
            'Blend on high speed until smooth and thick',
            'Pour into tall glasses',
            'Top with whipped cream',
            'Garnish with a fresh strawberry',
            'Serve with a straw and enjoy!'
        ],
        tips: 'For extra strawberry flavor, add a tablespoon of strawberry syrup. Freeze the glasses beforehand for an extra cold shake.'
    },
    'ice-cream-sandwich': {
        id: 'ice-cream-sandwich',
        name: 'Ice Cream Sandwich',
        category: 'Treats',
        image: '🍪',
        prepTime: '30 min',
        servings: '6',
        difficulty: 'Medium',
        description: 'Chocolate chip cookies sandwiched with your favorite Savoy ice cream flavor',
        ingredients: [
            '12 chocolate chip cookies (homemade or store-bought)',
            '3 cups Savoy Ice Cream (any flavor)',
            'Mini chocolate chips for rolling',
            'Sprinkles (optional)',
            'Cocoa powder for dusting'
        ],
        instructions: [
            'Let ice cream soften at room temperature for 5 minutes',
            'Place a generous scoop of ice cream on the flat side of one cookie',
            'Top with another cookie to create a sandwich',
            'Roll the edges in mini chocolate chips or sprinkles',
            'Wrap each sandwich in plastic wrap',
            'Freeze for at least 2 hours before serving',
            'Dust with cocoa powder before serving'
        ],
        tips: 'Make these ahead and keep frozen for easy desserts. Try different ice cream and cookie combinations!'
    },
    'banana-split': {
        id: 'banana-split',
        name: 'Classic Banana Split',
        category: 'Desserts',
        image: '🍌',
        prepTime: '15 min',
        servings: '1',
        difficulty: 'Easy',
        description: 'Split banana topped with three scoops of ice cream, chocolate sauce, and whipped cream',
        ingredients: [
            '1 ripe banana',
            '1 scoop Savoy Vanilla Ice Cream',
            '1 scoop Savoy Chocolate Ice Cream',
            '1 scoop Savoy Strawberry Ice Cream',
            'Chocolate sauce',
            'Strawberry sauce',
            'Whipped cream',
            'Chopped nuts',
            'Cherry on top'
        ],
        instructions: [
            'Peel banana and slice lengthwise',
            'Place banana halves along sides of a long dish',
            'Add three scoops of ice cream in a row between the bananas',
            'Drizzle chocolate sauce over vanilla, strawberry sauce over strawberry',
            'Add generous dollops of whipped cream',
            'Sprinkle with chopped nuts',
            'Top with a cherry',
            'Serve immediately with a long spoon'
        ],
        tips: 'Use a ripe but firm banana for best texture. Get creative with different ice cream flavor combinations!'
    },
    'affogato': {
        id: 'affogato',
        name: 'Affogato',
        category: 'Beverages',
        image: '☕',
        prepTime: '5 min',
        servings: '1',
        difficulty: 'Easy',
        description: 'Vanilla ice cream drowned in a shot of hot espresso - an Italian classic',
        ingredients: [
            '2 scoops Savoy Vanilla Ice Cream',
            '1 shot (30ml) hot espresso',
            'Cocoa powder for dusting',
            'Biscotti or amaretti cookies (optional)'
        ],
        instructions: [
            'Place vanilla ice cream scoops in a serving glass or cup',
            'Brew a fresh shot of hot espresso',
            'Pour the hot espresso over the ice cream',
            'Dust lightly with cocoa powder',
            'Serve immediately with a spoon',
            'Optional: serve with biscotti on the side'
        ],
        tips: 'The espresso should be very hot to create that perfect hot-cold contrast. Serve immediately before ice cream melts completely.'
    },
    'fruit-parfait': {
        id: 'fruit-parfait',
        name: 'Fruit Parfait',
        category: 'Desserts',
        image: '🍓',
        prepTime: '10 min',
        servings: '2',
        difficulty: 'Easy',
        description: 'Layered dessert with fresh fruits, granola, and vanilla ice cream',
        ingredients: [
            '2 cups Savoy Vanilla Ice Cream',
            '1 cup mixed berries (strawberries, blueberries, raspberries)',
            '1/2 cup granola',
            '2 tablespoons honey',
            '1/4 cup Greek yogurt',
            'Fresh mint leaves for garnish'
        ],
        instructions: [
            'In clear glasses, add a layer of granola at the bottom',
            'Add a scoop of vanilla ice cream',
            'Layer fresh berries on top',
            'Add another layer of ice cream',
            'Top with more berries and granola',
            'Drizzle honey over the top',
            'Garnish with mint leaves',
            'Serve immediately'
        ],
        tips: 'Use seasonal fruits for best flavor. Layer in clear glasses for beautiful presentation.'
    },
    'oreo-shake': {
        id: 'oreo-shake',
        name: 'Oreo Milkshake',
        category: 'Shakes',
        image: '🍪',
        prepTime: '5 min',
        servings: '2',
        difficulty: 'Easy',
        description: 'Thick and creamy shake loaded with crushed Oreos and vanilla ice cream',
        ingredients: [
            '3 cups Savoy Vanilla Ice Cream',
            '8 Oreo cookies (plus extra for topping)',
            '1 cup milk',
            'Whipped cream',
            'Chocolate syrup for drizzling'
        ],
        instructions: [
            'Crush 6 Oreo cookies into small pieces',
            'Add ice cream, crushed Oreos, and milk to blender',
            'Blend until thick and creamy',
            'Pour into glasses',
            'Top with whipped cream',
            'Crush remaining Oreos and sprinkle on top',
            'Drizzle with chocolate syrup',
            'Serve with a thick straw'
        ],
        tips: 'For extra thickness, use less milk. Save some cookie chunks for texture instead of blending them completely.'
    },
    'ice-cream-float': {
        id: 'ice-cream-float',
        name: 'Ice Cream Float',
        category: 'Beverages',
        image: '🥤',
        prepTime: '3 min',
        servings: '1',
        difficulty: 'Easy',
        description: 'Fizzy soda topped with a scoop of vanilla ice cream for a classic refreshment',
        ingredients: [
            '2 scoops Savoy Vanilla Ice Cream',
            '1 cup root beer or cola',
            'Whipped cream (optional)',
            'Cherry for garnish'
        ],
        instructions: [
            'Fill a tall glass halfway with cold soda',
            'Gently add scoops of vanilla ice cream',
            'Pour remaining soda slowly to avoid overflow',
            'Top with whipped cream if desired',
            'Add a cherry on top',
            'Serve immediately with a straw and spoon'
        ],
        tips: 'Pour soda slowly to prevent excessive foam. Try different soda flavors like orange, grape, or cream soda.'
    }
};

// Global variable to track current flavor for recipes
let currentFlavorForRecipes = null;
let currentRecipeDetail = null;

// Recipe ID mapping (numeric ID to database key)
const recipeIdMap = {
    1: 'vanilla-sundae',
    2: 'chocolate-milkshake',
    3: 'strawberry-shake',
    4: 'ice-cream-sandwich',
    5: 'banana-split',
    6: 'affogato',
    7: 'mango-lassi',
    8: 'chocolate-brownie',
    9: 'fruit-parfait'
};

/* ========================================
   NAVIGATION & SCREEN MANAGEMENT
   ======================================== */

// Navigate to different screens
function navigateTo(screenId) {
    // Hide all screens
    const screens = document.querySelectorAll('.screen');
    screens.forEach(screen => screen.classList.remove('active'));
    
    // Show target screen
    const targetScreen = document.getElementById(screenId);
    if (targetScreen) {
        targetScreen.classList.add('active');
        
        // Update page title
        updatePageTitle(screenId);
        
        // Update navigation active states
        updateNavigationState(screenId);
        
        // Scroll to top
        window.scrollTo({ top: 0, behavior: 'smooth' });
        
        // Close mobile menu if open
        closeMobileMenu();
    }
}

// Update page title based on current screen
function updatePageTitle(screenId) {
    const pageTitleElement = document.getElementById('pageTitle');
    if (!pageTitleElement) return;
    
    const titles = {
        'home': 'Home',
        'explore': 'Explore Flavors',
        'wallet': 'IceCoins Wallet',
        'challenges': 'Challenges & Engagement',
        'recipes': 'Recipe Discovery',
        'health-tracker': 'Health & Nutrition',
        'store-locator': 'Store Locator',
        'profile': 'My Profile',
        'settings': 'Settings',
        'flavor-detail': 'Flavor Details',
        'recipe-detail': 'Recipe Details',
        'scan': 'Scan QR Code'
    };
    
    pageTitleElement.textContent = titles[screenId] || 'SavoyConnect';
}

// Update navigation active states (sidebar, bottom nav)
function updateNavigationState(screenId) {
    // Update sidebar nav links
    const sidebarLinks = document.querySelectorAll('.sidebar-nav .nav-link');
    sidebarLinks.forEach(link => {
        link.classList.remove('active');
        if (link.getAttribute('onclick')?.includes(screenId)) {
            link.classList.add('active');
        }
    });
    
    // Update bottom nav items
    const bottomNavItems = document.querySelectorAll('.bottom-nav .nav-item');
    bottomNavItems.forEach(item => {
        item.classList.remove('active');
        if (item.getAttribute('onclick')?.includes(screenId)) {
            item.classList.add('active');
        }
    });
}

/* ========================================
   SIDEBAR FUNCTIONALITY (Desktop)
   ======================================== */

let sidebarHidden = false;

function toggleSidebar() {
    const sidebar = document.getElementById('sidebar');
    const mainContent = document.querySelector('.main-content');
    const overlay = document.getElementById('sidebarOverlay');
    if (!sidebar) return;
    
    sidebarHidden = !sidebarHidden;
    
    if (sidebarHidden) {
        sidebar.classList.add('hidden');
        if (overlay) overlay.classList.remove('active');
        if (mainContent) mainContent.style.marginLeft = '0';
        localStorage.setItem('sidebarHidden', 'true');
    } else {
        sidebar.classList.remove('hidden');
        if (overlay) overlay.classList.add('active');
        if (mainContent) mainContent.style.marginLeft = '';
        localStorage.setItem('sidebarHidden', 'false');
    }
}

// Restore sidebar state on load
function restoreSidebarState() {
    const savedState = localStorage.getItem('sidebarHidden');
    if (savedState === 'true') {
        const sidebar = document.getElementById('sidebar');
        const mainContent = document.querySelector('.main-content');
        const overlay = document.getElementById('sidebarOverlay');
        if (sidebar) {
            sidebar.classList.add('hidden');
            if (overlay) overlay.classList.remove('active');
            if (mainContent) mainContent.style.marginLeft = '0';
            sidebarHidden = true;
        }
    }
}

/* ========================================
   MOBILE MENU (Hamburger)
   ======================================== */

function toggleMobileMenu() {
    const menu = document.getElementById('mobileMenu');
    const overlay = document.getElementById('mobileMenuOverlay');
    
    if (!menu || !overlay) return;
    
    const isActive = menu.classList.contains('active');
    
    if (isActive) {
        closeMobileMenu();
    } else {
        openMobileMenu();
    }
}

function openMobileMenu() {
    const menu = document.getElementById('mobileMenu');
    const overlay = document.getElementById('mobileMenuOverlay');
    
    if (menu && overlay) {
        menu.classList.add('active');
        overlay.classList.add('active');
        document.body.style.overflow = 'hidden'; // Prevent scrolling
    }
}

function closeMobileMenu() {
    const menu = document.getElementById('mobileMenu');
    const overlay = document.getElementById('mobileMenuOverlay');
    
    if (menu && overlay) {
        menu.classList.remove('active');
        overlay.classList.remove('active');
        document.body.style.overflow = ''; // Restore scrolling
    }
}

/* ========================================
   NOTIFICATIONS
   ======================================== */

function openNotifications() {
    // TODO: Implement notifications panel
    console.log('Opening notifications...');
    alert('Notifications feature coming soon!');
}

/* ========================================
   SEARCH
   ======================================== */

function openSearch() {
    // TODO: Implement search modal
    console.log('Opening search...');
    alert('Search feature coming soon!');
}

/* ========================================
   FLAVOR DETAIL FUNCTIONS
   ======================================== */

// Show flavor detail
function showFlavorDetail(flavorId) {
    const flavor = flavorData[flavorId];
    if (!flavor) return;

    // Update flavor detail screen
    document.getElementById('flavorHeroImage').textContent = flavor.icon;
    document.getElementById('flavorName').textContent = flavor.name;
    document.getElementById('flavorTagline').textContent = flavor.tagline;
    
    // Update badge
    const badgeElement = document.getElementById('flavorBadge');
    badgeElement.textContent = flavor.badge;
    badgeElement.className = `badge ${flavor.badgeClass}`;
    badgeElement.style.display = flavor.badge ? 'inline-block' : 'none';

    // Update story
    document.getElementById('flavorStory').textContent = flavor.story;

    // Update ingredients
    const ingredientsList = document.getElementById('ingredientsList');
    ingredientsList.innerHTML = flavor.ingredients.map(ing => 
        `<span class="ingredient-tag">${ing}</span>`
    ).join('');

    // Update nutrition
    document.getElementById('servingSize').textContent = flavor.nutrition.servingSize;
    document.getElementById('calories').textContent = flavor.nutrition.calories;
    document.getElementById('fat').textContent = flavor.nutrition.fat;
    document.getElementById('carbs').textContent = flavor.nutrition.carbs;
    document.getElementById('protein').textContent = flavor.nutrition.protein;

    // Update availability
    document.getElementById('availabilityText').textContent = flavor.availability;

    // Set current flavor for recipes
    currentFlavorForRecipes = flavorId;

    // Navigate to detail screen
    navigateTo('flavor-detail');
}

// Share flavor
function shareFlavor() {
    const flavorName = document.getElementById('flavorName').textContent;
    alert(`Share ${flavorName} with your friends!\n\nThis would open share options on your device.`);
}

/* ========================================
   RECIPE DETAIL FUNCTIONS
   ======================================== */

// Show recipe detail
function showRecipeDetail(recipeId) {
    // Convert numeric ID to string key if needed
    const recipeKey = typeof recipeId === 'number' ? recipeIdMap[recipeId] : recipeId;
    const recipe = allRecipesDatabase[recipeKey];
    
    if (!recipe) {
        showNotification('Recipe not found', 'error');
        return;
    }

    currentRecipeDetail = recipe;

    // Update recipe detail screen
    document.getElementById('recipeDetailImage').textContent = recipe.image;
    document.getElementById('recipeDetailName').textContent = recipe.name;
    document.getElementById('recipeDetailPrepTime').textContent = recipe.prepTime;
    document.getElementById('recipeDetailServings').textContent = recipe.servings;
    document.getElementById('recipeDetailDifficulty').textContent = recipe.difficulty;
    document.getElementById('recipeDetailCategory').textContent = recipe.category;
    document.getElementById('recipeDetailDescription').textContent = recipe.description;

    // Update ingredients
    const ingredientsList = document.getElementById('recipeDetailIngredients');
    ingredientsList.innerHTML = recipe.ingredients.map(ing => 
        `<li>${ing}</li>`
    ).join('');

    // Update instructions
    const instructionsList = document.getElementById('recipeDetailInstructions');
    instructionsList.innerHTML = recipe.instructions.map((inst, index) => 
        `<li>${inst}</li>`
    ).join('');

    // Update tips
    if (recipe.tips) {
        document.getElementById('recipeDetailTips').textContent = recipe.tips;
        document.getElementById('recipeTipsSection').style.display = 'block';
    } else {
        document.getElementById('recipeTipsSection').style.display = 'none';
    }

    // Navigate to recipe detail screen
    navigateTo('recipe-detail');
}

// Save recipe
function saveRecipe() {
    if (!currentRecipeDetail) return;
    
    showNotification(`❤️ ${currentRecipeDetail.name} saved to your favorites!`, 'success');
}

// Share recipe
function shareRecipe() {
    if (!currentRecipeDetail) return;
    
    alert(`Share "${currentRecipeDetail.name}"\n\nThis would open your device's share menu to share this recipe with friends!`);
}

/* ========================================
   PLACEHOLDER FUNCTIONS
   ======================================== */

// Order Modal Constants
const PIECES_PER_BOX = 24;
const PRICE_PER_PIECE = 50;
const PRICE_PER_LITER = 800;
const DELIVERY_FEE = 200;
const FREE_DELIVERY_THRESHOLD = 5000;

// Order State
let orderCart = {};
let currentOrderType = 'pieces'; // 'pieces' or 'liters'
let currentDeliveryMethod = 'delivery'; // 'delivery' or 'pickup'

function openOrderModal() {
    const modal = document.getElementById('orderModal');
    if (!modal) return;
    
    modal.classList.add('active');
    document.body.style.overflow = 'hidden';
    
    // Reset cart and order type
    orderCart = {};
    currentOrderType = 'pieces';
    currentDeliveryMethod = 'delivery';
    updateOrderSummary();
    
    // Reset form
    const orderForm = document.getElementById('orderForm');
    if (orderForm) orderForm.reset();
    
    // Reset all quantity inputs
    const inputs = document.querySelectorAll('.qty-input');
    inputs.forEach(input => input.value = 0);
    
    // Set minimum date to tomorrow
    const tomorrow = new Date();
    tomorrow.setDate(tomorrow.getDate() + 1);
    const dateInput = document.getElementById('deliveryDate');
    if (dateInput) {
        dateInput.min = tomorrow.toISOString().split('T')[0];
    }
}

function closeOrderModal() {
    const modal = document.getElementById('orderModal');
    if (!modal) return;
    
    modal.classList.remove('active');
    document.body.style.overflow = 'auto';
}

// Delivery Method Switching
function switchDeliveryMethod(method) {
    currentDeliveryMethod = method;
    
    const deliveryTab = document.getElementById('deliveryTab');
    const pickupTab = document.getElementById('pickupTab');
    const orderForm = document.getElementById('orderForm');
    const pickupForm = document.getElementById('pickupForm');
    const deliveryFeeRow = document.getElementById('deliveryFeeRow');
    const pickupSavingsRow = document.getElementById('pickupSavingsRow');
    
    if (!deliveryTab || !pickupTab) return;
    
    if (method === 'delivery') {
        deliveryTab.classList.add('active');
        pickupTab.classList.remove('active');
        if (orderForm) orderForm.style.display = 'block';
        if (pickupForm) pickupForm.style.display = 'none';
        if (deliveryFeeRow) deliveryFeeRow.style.display = 'flex';
        if (pickupSavingsRow) pickupSavingsRow.style.display = 'none';
    } else {
        pickupTab.classList.add('active');
        deliveryTab.classList.remove('active');
        if (orderForm) orderForm.style.display = 'none';
        if (pickupForm) pickupForm.style.display = 'block';
        if (deliveryFeeRow) deliveryFeeRow.style.display = 'none';
        if (pickupSavingsRow) pickupSavingsRow.style.display = 'flex';
        
        // Set minimum date for pickup
        const tomorrow = new Date();
        tomorrow.setDate(tomorrow.getDate() + 1);
        const pickupDateInput = document.getElementById('pickupDate');
        if (pickupDateInput) {
            pickupDateInput.min = tomorrow.toISOString().split('T')[0];
        }
    }
    
    updateOrderSummary();
}

// Order Type Switching
function switchOrderType(type) {
    orderCart = {};
    currentOrderType = type;
    
    // Reset all quantity inputs
    const inputs = document.querySelectorAll('.qty-input');
    inputs.forEach(input => input.value = 0);
    
    // Update tab active state
    const piecesTab = document.getElementById('piecesTab');
    const litersTab = document.getElementById('litersTab');
    
    if (piecesTab && litersTab) {
        piecesTab.classList.toggle('active', type === 'pieces');
        litersTab.classList.toggle('active', type === 'liters');
    }
    
    // Update price labels
    const priceLabels = document.querySelectorAll('.flavor-price');
    priceLabels.forEach(label => {
        if (type === 'pieces') {
            label.textContent = '৳50/piece';
        } else {
            label.textContent = '৳800/liter';
        }
    });
    
    // Update summary labels
    const summaryUnitLabel = document.getElementById('summaryUnitLabel');
    const summaryQuantityLabel = document.getElementById('summaryQuantityLabel');
    
    if (type === 'pieces') {
        if (summaryUnitLabel) summaryUnitLabel.textContent = 'Total Boxes:';
        if (summaryQuantityLabel) summaryQuantityLabel.textContent = 'Total Pieces:';
    } else {
        if (summaryUnitLabel) summaryUnitLabel.textContent = 'Total Orders:';
        if (summaryQuantityLabel) summaryQuantityLabel.textContent = 'Total Liters:';
    }
    
    updateOrderSummary();
}

// Quantity Controls
function increaseQuantity(flavorId) {
    const input = document.getElementById(`qty-${flavorId}`);
    if (!input) return;
    
    const currentValue = parseInt(input.value) || 0;
    input.value = currentValue + 1;
    orderCart[flavorId] = input.value;
    updateOrderSummary();
}

function decreaseQuantity(flavorId) {
    const input = document.getElementById(`qty-${flavorId}`);
    if (!input) return;
    
    const currentValue = parseInt(input.value) || 0;
    
    if (currentValue > 0) {
        input.value = currentValue - 1;
        orderCart[flavorId] = input.value;
        
        if (input.value == 0) {
            delete orderCart[flavorId];
        }
        
        updateOrderSummary();
    }
}

// Update Order Summary
function updateOrderSummary() {
    let totalQuantity = 0;
    let subtotal = 0;
    
    Object.values(orderCart).forEach(qty => {
        totalQuantity += parseInt(qty) || 0;
    });
    
    if (currentOrderType === 'pieces') {
        const totalBoxes = Math.ceil(totalQuantity / PIECES_PER_BOX);
        subtotal = totalQuantity * PRICE_PER_PIECE;
        
        const totalBoxesEl = document.getElementById('totalBoxes');
        const totalPiecesEl = document.getElementById('totalPieces');
        if (totalBoxesEl) totalBoxesEl.textContent = totalBoxes;
        if (totalPiecesEl) totalPiecesEl.textContent = totalQuantity;
    } else {
        subtotal = totalQuantity * PRICE_PER_LITER;
        
        const totalBoxesEl = document.getElementById('totalBoxes');
        const totalPiecesEl = document.getElementById('totalPieces');
        if (totalBoxesEl) totalBoxesEl.textContent = Object.keys(orderCart).length;
        if (totalPiecesEl) totalPiecesEl.textContent = totalQuantity;
    }
    
    // Calculate delivery fee
    let deliveryFee = 0;
    let totalAmount = subtotal;
    
    if (currentDeliveryMethod === 'delivery') {
        deliveryFee = subtotal >= FREE_DELIVERY_THRESHOLD ? 0 : DELIVERY_FEE;
        totalAmount = subtotal + deliveryFee;
        
        const summaryDelivery = document.getElementById('summaryDelivery');
        if (summaryDelivery) {
            summaryDelivery.textContent = subtotal >= FREE_DELIVERY_THRESHOLD ? '৳0' : `৳${DELIVERY_FEE}`;
        }
        
        const freeDeliveryRow = document.getElementById('freeDeliveryRow');
        if (freeDeliveryRow) {
            freeDeliveryRow.style.display = subtotal >= FREE_DELIVERY_THRESHOLD ? 'flex' : 'none';
        }
    } else {
        totalAmount = subtotal;
    }
    
    // Update summary displays
    const totalAmountEl = document.getElementById('totalAmount');
    const summarySubtotalEl = document.getElementById('summarySubtotal');
    const summaryTotalEl = document.getElementById('summaryTotal');
    
    if (totalAmountEl) totalAmountEl.textContent = `৳${totalAmount.toLocaleString()}`;
    if (summarySubtotalEl) summarySubtotalEl.textContent = `৳${subtotal.toLocaleString()}`;
    if (summaryTotalEl) summaryTotalEl.textContent = `৳${totalAmount.toLocaleString()}`;
    
    // Enable/disable place order button
    const placeOrderBtn = document.getElementById('placeOrderBtn');
    if (placeOrderBtn) {
        if (currentOrderType === 'pieces') {
            placeOrderBtn.disabled = totalQuantity < PIECES_PER_BOX;
        } else {
            placeOrderBtn.disabled = totalQuantity < 1;
        }
    }
}

// Place Order
function placeOrder() {
    let form;
    if (currentDeliveryMethod === 'delivery') {
        form = document.getElementById('orderForm');
    } else {
        form = document.getElementById('pickupForm');
    }
    
    if (!form || !form.checkValidity()) {
        if (form) form.reportValidity();
        return;
    }
    
    const totalQuantity = Object.values(orderCart).reduce((sum, qty) => sum + parseInt(qty), 0);
    
    if (currentOrderType === 'pieces' && totalQuantity < PIECES_PER_BOX) {
        alert('⚠️ Minimum order is 24 pieces (1 box)');
        return;
    } else if (currentOrderType === 'liters' && totalQuantity < 1) {
        alert('⚠️ Minimum order is 1 liter');
        return;
    }
    
    alert(`✅ Order placed successfully!\n\nTotal: ${totalQuantity} ${currentOrderType}\nDelivery Method: ${currentDeliveryMethod}\n\nYou will receive a confirmation SMS shortly.`);
    closeOrderModal();
}

function showNotification(message, type = 'info') {
    console.log(`Notification [${type}]: ${message}`);
    // TODO: Implement toast notification system
}

/* ========================================
   EXPLORE FLAVORS FUNCTIONALITY
   ======================================== */

// Search flavors
function searchFlavors() {
    const searchInput = document.getElementById('flavorSearch');
    if (!searchInput) return;
    
    const searchTerm = searchInput.value.toLowerCase();
    const flavorCards = document.querySelectorAll('.flavor-card');
    
    flavorCards.forEach(card => {
        const flavorName = card.querySelector('.flavor-name')?.textContent.toLowerCase() || '';
        const flavorTagline = card.querySelector('.flavor-tagline')?.textContent.toLowerCase() || '';
        
        if (flavorName.includes(searchTerm) || flavorTagline.includes(searchTerm)) {
            card.style.display = 'flex';
        } else {
            card.style.display = 'none';
        }
    });
}

// Filter by category
function filterByCategory(category) {
    // Update active tab
    const tabs = document.querySelectorAll('.category-tab');
    tabs.forEach(tab => tab.classList.remove('active'));
    event.target.classList.add('active');
    
    // Filter cards
    const flavorCards = document.querySelectorAll('.flavor-card');
    
    flavorCards.forEach(card => {
        const cardCategory = card.getAttribute('data-category');
        
        if (category === 'all') {
            card.style.display = 'flex';
        } else if (cardCategory === category) {
            card.style.display = 'flex';
        } else {
            card.style.display = 'none';
        }
    });
    
    // Clear search
    const searchInput = document.getElementById('flavorSearch');
    if (searchInput) searchInput.value = '';
}

// View flavor detail (placeholder)
function viewFlavorDetail(flavorId) {
    showFlavorDetail(flavorId);
}

// Add to cart (placeholder)
function addToCart(flavorId) {
    console.log('Adding to cart:', flavorId);
    showNotification(`Added ${flavorId} to cart! 🛒`, 'success');
    // TODO: Implement cart functionality
}

/* ========================================
   WALLET FUNCTIONALITY
   ======================================== */

// Show all transactions
function showAllTransactions() {
    console.log('Showing all transactions...');
    showNotification('Transaction history feature coming soon!', 'info');
    // TODO: Implement full transaction history view
}

// Show rewards screen/modal
function showRewards() {
    console.log('Showing rewards...');
    showNotification('Opening rewards catalog...', 'info');
    // TODO: Implement rewards catalog modal
}

// Redeem reward
function redeemReward(rewardId, cost) {
    console.log(`Redeeming reward: ${rewardId} for ${cost} IceCoins`);
    
    const currentBalance = 2450; // TODO: Get from actual state management
    
    if (currentBalance >= cost) {
        if (confirm(`Redeem this reward for ${cost} IceCoins?`)) {
            showNotification(`🎉 Reward redeemed successfully! -${cost} IceCoins`, 'success');
            // TODO: Update balance and transaction history
        }
    } else {
        showNotification(`❌ Insufficient balance. You need ${cost - currentBalance} more IceCoins.`, 'error');
    }
}

/* ========================================
   ENGAGE TABS & CHALLENGES
   ======================================== */

// Switch between engage tabs
function switchEngageTab(tabName) {
    // Remove active from all tabs
    const tabs = document.querySelectorAll('.engage-tab');
    tabs.forEach(tab => tab.classList.remove('active'));
    
    // Add active to clicked tab
    event.target.closest('.engage-tab').classList.add('active');
    
    // Hide all tab contents
    const contents = document.querySelectorAll('.engage-tab-content');
    contents.forEach(content => content.classList.remove('active'));
    
    // Show selected content
    const selectedContent = document.getElementById(`${tabName}-content`);
    if (selectedContent) {
        selectedContent.classList.add('active');
    }
}

// Filter leaderboard by period
function filterLeaderboard(period) {
    // Update active button
    const buttons = document.querySelectorAll('.period-btn');
    buttons.forEach(btn => btn.classList.remove('active'));
    event.target.classList.add('active');
    
    console.log('Filtering leaderboard by:', period);
    showNotification(`Showing ${period} leaderboard`, 'info');
    // TODO: Fetch and display leaderboard data for selected period
}

// Create new post
function createPost() {
    console.log('Creating new post...');
    showNotification('Post creation feature coming soon! ✏️', 'info');
    // TODO: Implement post creation modal
}

// Like post
function likePost(button) {
    const likeCount = button.querySelector('span:last-child');
    const currentCount = parseInt(likeCount.textContent);
    
    if (button.classList.contains('liked')) {
        button.classList.remove('liked');
        likeCount.textContent = currentCount - 1;
    } else {
        button.classList.add('liked');
        likeCount.textContent = currentCount + 1;
    }
}




/* ========================================
   RESPONSIVE UTILITIES
   ======================================== */

// Detect screen size
function getScreenSize() {
    const width = window.innerWidth;
    if (width < 768) return 'mobile';
    if (width < 1024) return 'tablet';
    return 'desktop';
}

// Handle resize events
let resizeTimer;
window.addEventListener('resize', () => {
    clearTimeout(resizeTimer);
    resizeTimer = setTimeout(() => {
        const screenSize = getScreenSize();
        console.log('Screen size:', screenSize);
        
        // Close mobile menu on resize to desktop
        if (screenSize === 'desktop') {
            closeMobileMenu();
        }
    }, 250);
});

/* ========================================
   INITIALIZATION
   ======================================== */

document.addEventListener('DOMContentLoaded', () => {
    console.log('SavoyConnect Web App Initialized');
    console.log('Screen size:', getScreenSize());
    
    // Restore sidebar state
    restoreSidebarState();
    
    // Set initial navigation state
    updateNavigationState('home');
    
    // Prevent default anchor behavior for navigation
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', (e) => {
            e.preventDefault();
        });
    });
});

/* ========================================
   KEYBOARD SHORTCUTS
   ======================================== */

document.addEventListener('keydown', (e) => {
    // ESC key closes modals and menus
    if (e.key === 'Escape') {
        closeMobileMenu();
    }
    
    // Ctrl/Cmd + K for search
    if ((e.ctrlKey || e.metaKey) && e.key === 'k') {
        e.preventDefault();
        openSearch();
    }
});

/* ========================================
   PROFILE FUNCTIONS
   ======================================== */

function editProfile() {
    alert('Edit Profile functionality coming soon!');
}

function showOrderHistory() {
    alert('Order History functionality coming soon!');
}

function showFavorites() {
    alert('My Favorites functionality coming soon!');
}

function showAddresses() {
    alert('Addresses functionality coming soon!');
}

function showPaymentMethods() {
    alert('Payment Methods functionality coming soon!');
}

function shareProfile() {
    if (navigator.share) {
        navigator.share({
            title: 'SavoyConnect Profile',
            text: 'Check out my SavoyConnect profile!',
            url: window.location.href,
        }).catch(err => console.log('Share failed:', err));
    } else {
        alert('Share functionality: Copy link to clipboard (coming soon)');
    }
}

function logout() {
    if (confirm('Are you sure you want to logout?')) {
        // Clear session/storage
        localStorage.clear();
        sessionStorage.clear();
        
        // Redirect to login page
        window.location.href = 'login.html';
    }
}

/* ========================================
   HEALTH TRACKER FUNCTIONS
   ======================================== */

function addHealthEntry() {
    alert('Log Activity functionality coming soon!');
}

function manageGoals() {
    alert('Manage Goals functionality coming soon!');
}

function filterActivityLog(type) {
    const activityItems = document.querySelectorAll('.activity-item');
    
    activityItems.forEach(item => {
        if (type === 'all') {
            item.style.display = 'flex';
        } else {
            const itemType = item.getAttribute('data-type');
            if (itemType === type) {
                item.style.display = 'flex';
            } else {
                item.style.display = 'none';
            }
        }
    });
}

/* ========================================
   STORE LOCATOR FUNCTIONS
   ======================================== */

function useMyLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(
            (position) => {
                alert(`Location detected!\nLatitude: ${position.coords.latitude}\nLongitude: ${position.coords.longitude}\n\nStores will be sorted by distance.`);
            },
            (error) => {
                alert('Location access denied. Please enable location services.');
            }
        );
    } else {
        alert('Geolocation is not supported by your browser.');
    }
}

function searchStores() {
    const searchInput = document.getElementById('storeSearch');
    const searchTerm = searchInput.value.toLowerCase();
    const storeCards = document.querySelectorAll('.store-card');
    const noResults = document.getElementById('noStoresMessage');
    let visibleCount = 0;
    
    storeCards.forEach(card => {
        const storeName = card.querySelector('.store-name').textContent.toLowerCase();
        const storeAddress = card.querySelector('.store-info-item span:last-child').textContent.toLowerCase();
        
        if (storeName.includes(searchTerm) || storeAddress.includes(searchTerm)) {
            card.style.display = 'block';
            visibleCount++;
        } else {
            card.style.display = 'none';
        }
    });
    
    // Update store count
    const countInfo = document.querySelector('.store-count-info p');
    if (countInfo) {
        countInfo.innerHTML = `<strong>${visibleCount} store${visibleCount !== 1 ? 's' : ''}</strong> found`;
    }
    
    // Show/hide no results message
    if (visibleCount === 0) {
        noResults.style.display = 'block';
    } else {
        noResults.style.display = 'none';
    }
}

function filterStores(filterType) {
    const storeCards = document.querySelectorAll('.store-card');
    const filterButtons = document.querySelectorAll('.filter-chip');
    const noResults = document.getElementById('noStoresMessage');
    let visibleCount = 0;
    
    // Update active filter button
    filterButtons.forEach(btn => {
        btn.classList.remove('active');
        if (btn.textContent.toLowerCase().includes(filterType) || 
            (filterType === 'all' && btn.textContent === 'All Stores')) {
            btn.classList.add('active');
        }
    });
    
    storeCards.forEach(card => {
        const storeType = card.getAttribute('data-type');
        const storeStatus = card.getAttribute('data-status');
        
        if (filterType === 'all') {
            card.style.display = 'block';
            visibleCount++;
        } else if (filterType === 'depot' && storeType === 'depot') {
            card.style.display = 'block';
            visibleCount++;
        } else if (filterType === 'retail' && storeType === 'retail') {
            card.style.display = 'block';
            visibleCount++;
        } else if (filterType === 'open-now' && storeStatus === 'open') {
            card.style.display = 'block';
            visibleCount++;
        } else {
            card.style.display = 'none';
        }
    });
    
    // Update store count
    const countInfo = document.querySelector('.store-count-info p');
    if (countInfo) {
        countInfo.innerHTML = `<strong>${visibleCount} store${visibleCount !== 1 ? 's' : ''}</strong> found`;
    }
    
    // Show/hide no results message
    if (visibleCount === 0) {
        noResults.style.display = 'block';
    } else {
        noResults.style.display = 'none';
    }
}

function switchStoreView(viewType) {
    const mapContainer = document.getElementById('mapContainer');
    const listContainer = document.getElementById('storeListContainer');
    const toggleButtons = document.querySelectorAll('.toggle-btn');
    
    // Update active button
    toggleButtons.forEach(btn => {
        btn.classList.remove('active');
        if ((viewType === 'map' && btn.textContent.includes('Map')) || 
            (viewType === 'list' && btn.textContent.includes('List'))) {
            btn.classList.add('active');
        }
    });
    
    if (viewType === 'map') {
        mapContainer.style.display = 'block';
        listContainer.style.display = 'none';
    } else {
        mapContainer.style.display = 'none';
        listContainer.style.display = 'block';
    }
}

function getDirections(storeId) {
    alert(`Opening directions to store #${storeId}...\n\nThis would open Google Maps or your default navigation app.`);
}

function showStoreDetail(storeId) {
    alert(`Store Details #${storeId}\n\nThis would show:\n• Full store information\n• Available flavors\n• Customer reviews\n• Photo gallery\n• Special offers`);
}

/* ========================================
   EXPORT FUNCTIONS (for testing)
   ======================================== */

function useMyLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(
            (position) => {
                alert(`Location detected!\nLatitude: ${position.coords.latitude}\nLongitude: ${position.coords.longitude}\n\nStores will be sorted by distance.`);
            },
            (error) => {
                alert('Location access denied. Please enable location services.');
            }
        );
    } else {
        alert('Geolocation is not supported by your browser.');
    }
}

function searchStores() {
    const searchInput = document.getElementById('storeSearch');
    const searchTerm = searchInput.value.toLowerCase();
    const storeCards = document.querySelectorAll('.store-card');
    const noResults = document.getElementById('noStoresMessage');
    let visibleCount = 0;
    
    storeCards.forEach(card => {
        const storeName = card.querySelector('.store-name').textContent.toLowerCase();
        const storeAddress = card.querySelector('.store-info-item span:last-child').textContent.toLowerCase();
        
        if (storeName.includes(searchTerm) || storeAddress.includes(searchTerm)) {
            card.style.display = 'block';
            visibleCount++;
        } else {
            card.style.display = 'none';
        }
    });
    
    // Update store count
    const countInfo = document.querySelector('.store-count-info p');
    if (countInfo) {
        countInfo.innerHTML = `<strong>${visibleCount} store${visibleCount !== 1 ? 's' : ''}</strong> found`;
    }
    
    // Show/hide no results message
    if (visibleCount === 0) {
        noResults.style.display = 'block';
    } else {
        noResults.style.display = 'none';
    }
}

function filterStores(filterType) {
    const storeCards = document.querySelectorAll('.store-card');
    const filterButtons = document.querySelectorAll('.filter-chip');
    const noResults = document.getElementById('noStoresMessage');
    let visibleCount = 0;
    
    // Update active filter button
    filterButtons.forEach(btn => {
        btn.classList.remove('active');
        if (btn.textContent.toLowerCase().includes(filterType) || 
            (filterType === 'all' && btn.textContent === 'All Stores')) {
            btn.classList.add('active');
        }
    });
    
    storeCards.forEach(card => {
        const storeType = card.getAttribute('data-type');
        const storeStatus = card.getAttribute('data-status');
        
        if (filterType === 'all') {
            card.style.display = 'block';
            visibleCount++;
        } else if (filterType === 'depot' && storeType === 'depot') {
            card.style.display = 'block';
            visibleCount++;
        } else if (filterType === 'retail' && storeType === 'retail') {
            card.style.display = 'block';
            visibleCount++;
        } else if (filterType === 'open-now' && storeStatus === 'open') {
            card.style.display = 'block';
            visibleCount++;
        } else {
            card.style.display = 'none';
        }
    });
    
    // Update store count
    const countInfo = document.querySelector('.store-count-info p');
    if (countInfo) {
        countInfo.innerHTML = `<strong>${visibleCount} store${visibleCount !== 1 ? 's' : ''}</strong> found`;
    }
    
    // Show/hide no results message
    if (visibleCount === 0) {
        noResults.style.display = 'block';
    } else {
        noResults.style.display = 'none';
    }
}

function switchStoreView(viewType) {
    const mapContainer = document.getElementById('mapContainer');
    const listContainer = document.getElementById('storeListContainer');
    const toggleButtons = document.querySelectorAll('.toggle-btn');
    
    // Update active button
    toggleButtons.forEach(btn => {
        btn.classList.remove('active');
        if ((viewType === 'map' && btn.textContent.includes('Map')) || 
            (viewType === 'list' && btn.textContent.includes('List'))) {
            btn.classList.add('active');
        }
    });
    
    if (viewType === 'map') {
        mapContainer.style.display = 'block';
        listContainer.style.display = 'none';
    } else {
        mapContainer.style.display = 'none';
        listContainer.style.display = 'block';
    }
}

function getDirections(storeId) {
    alert(`Opening directions to store #${storeId}...\n\nThis would open Google Maps or your default navigation app.`);
}

function showStoreDetail(storeId) {
    alert(`Store Details #${storeId}\n\nThis would show:\n• Full store information\n• Available flavors\n• Customer reviews\n• Photo gallery\n• Special offers`);
}

/* ========================================
   EXPORT FUNCTIONS (for testing)
   ======================================== */

function addNewRecipe() {
    alert('Share Recipe functionality coming soon!\n\nYou will be able to:\n• Upload recipe photos\n• Add ingredients\n• Write step-by-step instructions\n• Share with the community');
}

function searchRecipes() {
    const searchInput = document.getElementById('recipeSearch');
    if (!searchInput) return;
    
    const searchTerm = searchInput.value.toLowerCase();
    const recipeCards = document.querySelectorAll('.recipe-card');
    const noResults = document.getElementById('noRecipesMessage');
    let visibleCount = 0;
    
    recipeCards.forEach(card => {
        const recipeName = card.querySelector('.recipe-name')?.textContent.toLowerCase() || '';
        const recipeDescription = card.querySelector('.recipe-description')?.textContent.toLowerCase() || '';
        
        if (recipeName.includes(searchTerm) || recipeDescription.includes(searchTerm)) {
            card.style.display = 'block';
            visibleCount++;
        } else {
            card.style.display = 'none';
        }
    });
    
    // Show/hide no results message
    if (noResults) {
        if (visibleCount === 0) {
            noResults.style.display = 'block';
        } else {
            noResults.style.display = 'none';
        }
    }
}

function filterRecipeCategory(category) {
    const recipeCards = document.querySelectorAll('.recipe-card');
    const categoryTabs = document.querySelectorAll('.category-tab');
    const noResults = document.getElementById('noRecipesMessage');
    let visibleCount = 0;
    
    // Update active category tab
    categoryTabs.forEach(tab => {
        tab.classList.remove('active');
        if ((category === 'all' && tab.textContent.includes('All')) ||
            tab.textContent.toLowerCase().includes(category)) {
            tab.classList.add('active');
        }
    });
    
    recipeCards.forEach(card => {
        const cardCategory = card.getAttribute('data-category');
        
        if (category === 'all' || cardCategory === category) {
            card.style.display = 'block';
            visibleCount++;
        } else {
            card.style.display = 'none';
        }
    });
    
    // Show/hide no results message
    if (noResults) {
        if (visibleCount === 0) {
            noResults.style.display = 'block';
        } else {
            noResults.style.display = 'none';
        }
    }
}

function toggleRecipeFavorite(recipeId) {
    const favoriteBtn = document.querySelector(`.recipe-card:nth-child(${recipeId}) .recipe-favorite-btn`);
    
    if (favoriteBtn) {
        favoriteBtn.classList.toggle('favorited');
        
        if (favoriteBtn.classList.contains('favorited')) {
            console.log(`Recipe ${recipeId} added to favorites`);
        } else {
            console.log(`Recipe ${recipeId} removed from favorites`);
        }
    }
}

function viewRecipeDetail(recipeId) {
    showRecipeDetail(recipeId);
}

/* ========================================
   SETTINGS FUNCTIONS
   ======================================== */

// Account Settings
function editAccountInfo() {
    alert('Edit Profile functionality coming soon!');
}

function changePassword() {
    alert('Change Password functionality coming soon!');
}

function managePaymentMethods() {
    alert('Payment Methods management coming soon!');
}

function manageAddresses() {
    alert('Saved Addresses management coming soon!');
}

// Preferences
function toggleDarkMode() {
    const toggle = document.getElementById('darkModeToggle');
    if (toggle && toggle.checked) {
        alert('Dark Mode is being developed! Coming soon.');
        // Future: Apply dark theme
    }
}

function changeLanguage() {
    alert('Language selection coming soon!\n\nAvailable languages:\n• English\n• বাংলা (Bengali)\n• Hindi\n• More...');
}

function changeCurrency() {
    alert('Currency selection coming soon!\n\nAvailable currencies:\n• BDT\n• USD\n• EUR\n• More...');
}

// Notifications
function toggleNotification(type) {
    console.log(`${type} notification toggled`);
}

// Privacy & Security
function toggle2FA() {
    alert('Two-Factor Authentication setup coming soon!');
}

function viewPrivacyPolicy() {
    alert('Privacy Policy\n\nOur privacy policy ensures your data is protected and used responsibly.');
}

function viewTerms() {
    alert('Terms of Service\n\nBy using SavoyConnect, you agree to our terms and conditions.');
}

function manageDataPrivacy() {
    alert('Data & Privacy Settings\n\nManage:\n• Data collection preferences\n• Cookie settings\n• Analytics opt-out\n• Data export/deletion');
}

// Support & Help
function openHelpCenter() {
    alert('Help Center\n\nBrowse FAQs and guides on:\n• Getting Started\n• Orders & Delivery\n• Rewards & Loyalty\n• Account Management');
}

function contactSupport() {
    alert('Contact Support\n\nReach us via:\n📧 Email: support@savoyconnect.com\n📞 Phone: +880 1XXX-XXXXXX\n💬 Live Chat: Available 9 AM - 9 PM');
}

function reportIssue() {
    alert('Report a Problem\n\nDescribe the issue you\'re experiencing and our team will investigate.');
}

function sendFeedback() {
    alert('Send Feedback\n\nWe\'d love to hear your suggestions to improve SavoyConnect!');
}

// About
function viewAppInfo() {
    alert('App Information\n\nSavoyConnect Web App\nVersion: 1.0.0\nBuild: 100\n\nDeveloped with ❤️ for ice cream lovers');
}

function rateApp() {
    alert('Rate SavoyConnect\n\nEnjoy using our app? Please rate us on the app store!');
}

function checkUpdates() {
    alert('Check for Updates\n\nYou\'re using the latest version!\n✔️ v1.0.0 (Build 100)');
}

// Danger Zone
function clearCache() {
    if (confirm('Clear app cache?\n\nThis will free up storage but may slow down initial loading.')) {
        alert('Cache cleared successfully!');
    }
}

function deleteAccount() {
    const confirmation = prompt('Delete Account\n\nThis action is permanent and cannot be undone.\n\nType "DELETE" to confirm:');
    
    if (confirmation === 'DELETE') {
        alert('Account deletion process initiated.\n\nYou will receive a confirmation email within 24 hours.');
    } else if (confirmation !== null) {
        alert('Account deletion cancelled.');
    }
}

if (typeof module !== 'undefined' && module.exports) {
    module.exports = {
        navigateTo,
        toggleSidebar,
        toggleMobileMenu,
        openMobileMenu,
        closeMobileMenu,
        getScreenSize
    };
}

