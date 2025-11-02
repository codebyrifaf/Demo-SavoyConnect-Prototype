// Navigation function
function navigateTo(screenId) {
    // Hide all screens
    const screens = document.querySelectorAll('.screen');
    screens.forEach(screen => {
        screen.classList.remove('active');
    });

    // Show target screen
    const targetScreen = document.getElementById(screenId);
    if (targetScreen) {
        targetScreen.classList.add('active');
        
        // Update bottom nav active state if applicable
        updateBottomNav(screenId);
        
        // Update recipe suggestions when navigating to home
        if (screenId === 'home') {
            updateRecipeSuggestions();
        }
        
        // Scroll to top of content
        const content = targetScreen.querySelector('.content');
        if (content) {
            content.scrollTop = 0;
        }
    }
}

// Update bottom navigation active state
function updateBottomNav(screenId) {
    // Map screen IDs to nav items
    const navMapping = {
        'home': 0,
        'wallet': 1,
        'rewards': 1,
        'challenges': 2,
        'community': 2,
        'ar-hunt': 2,
        'profile': 3,
        'settings': 3
    };

    // Get all bottom nav instances
    const bottomNavs = document.querySelectorAll('.bottom-nav');
    bottomNavs.forEach(nav => {
        const navItems = nav.querySelectorAll('.nav-item');
        navItems.forEach((item, index) => {
            item.classList.remove('active');
            if (navMapping[screenId] === index) {
                item.classList.add('active');
            }
        });
    });
}

// Carousel functionality
let currentSlide = 0;
let carouselInterval;

function goToSlide(index) {
    const slides = document.querySelectorAll('.carousel-item');
    const dots = document.querySelectorAll('.dot');
    
    slides.forEach((slide, i) => {
        slide.classList.remove('active');
        if (i === index) {
            slide.classList.add('active');
        }
    });
    
    dots.forEach((dot, i) => {
        dot.classList.remove('active');
        if (i === index) {
            dot.classList.add('active');
        }
    });
    
    currentSlide = index;
}

function nextSlide() {
    const slides = document.querySelectorAll('.carousel-item');
    if (slides.length > 0) {
        currentSlide = (currentSlide + 1) % slides.length;
        goToSlide(currentSlide);
    }
}

function startCarousel() {
    const slides = document.querySelectorAll('.carousel-item');
    if (slides.length > 1) {
        carouselInterval = setInterval(nextSlide, 3000);
    }
}

function stopCarousel() {
    clearInterval(carouselInterval);
}

// Simulate QR code scan
function simulateScan() {
    alert('QR Code scanned successfully! +50 IceCoins earned');
    navigateTo('wallet');
}

// ========================================
// ANIMATED WALLET FUNCTIONS
// ========================================

// Shake coins animation
function shakeCoins() {
    const walletCard = document.querySelector('.wallet-card-animated');
    if (walletCard) {
        walletCard.style.animation = 'none';
        setTimeout(() => {
            walletCard.style.animation = 'shake 0.5s ease';
        }, 10);
    }
}

// Animate counter numbers
function animateValue(element, start, end, duration) {
    let startTimestamp = null;
    const step = (timestamp) => {
        if (!startTimestamp) startTimestamp = timestamp;
        const progress = Math.min((timestamp - startTimestamp) / duration, 1);
        const value = Math.floor(progress * (end - start) + start);
        element.textContent = value;
        if (progress < 1) {
            window.requestAnimationFrame(step);
        }
    };
    window.requestAnimationFrame(step);
}

// Initialize wallet animations when screen is shown
function initWalletAnimations() {
    // Animate stat numbers
    const statNumbers = document.querySelectorAll('.stat-number');
    statNumbers.forEach((stat) => {
        const target = parseInt(stat.getAttribute('data-target'));
        if (target) {
            animateValue(stat, 0, target, 2000);
        }
    });
    
    // Animate balance number
    const balanceElement = document.getElementById('walletBalance');
    if (balanceElement) {
        const balanceValue = parseInt(balanceElement.textContent.replace(/,/g, ''));
        animateValue(balanceElement, 0, balanceValue, 2500);
    }
}

// Initialize challenge animations
function initChallengeAnimations() {
    animateChallengeStats();
    animateChallengeProgress();
}

// Animate challenge stats counters
function animateChallengeStats() {
    const stats = [
        { id: 'stat-active', value: 12 },
        { id: 'stat-completed', value: 8 },
        { id: 'stat-earned', value: 800 }
    ];
    
    stats.forEach(stat => {
        const element = document.getElementById(stat.id);
        if (element) {
            animateValue(element, 0, stat.value, 1500);
        }
    });
}

// Animate challenge progress bars
function animateChallengeProgress() {
    const progressFills = document.querySelectorAll('.progress-fill-animated');
    progressFills.forEach(fill => {
        const targetWidth = fill.getAttribute('data-progress') + '%';
        fill.style.width = '0%';
        setTimeout(() => {
            fill.style.width = targetWidth;
        }, 100);
    });
}

// Expand challenge card for more details
function expandChallenge(card) {
    // Add a subtle scale animation on click
    card.style.transform = 'scale(0.98)';
    setTimeout(() => {
        card.style.transform = '';
    }, 150);
}

// Initialize leaderboard animations
function initLeaderboardAnimations() {
    animateLeaderboardStats();
    animateLeaderboardProgress();
}

// Animate leaderboard stats counters
function animateLeaderboardStats() {
    const userCoins = document.getElementById('user-coins');
    if (userCoins) {
        animateValue(userCoins, 0, 2450, 1500);
    }
    
    const rankCoins = [
        { id: 'rank-1-coins', value: 5640 },
        { id: 'rank-2-coins', value: 4280 },
        { id: 'rank-3-coins', value: 3850 }
    ];
    
    rankCoins.forEach(coin => {
        const element = document.getElementById(coin.id);
        if (element) {
            animateValue(element, 0, coin.value, 1800);
        }
    });
}

// Animate leaderboard progress bar
function animateLeaderboardProgress() {
    const progressFill = document.querySelector('.progress-fill-glow');
    if (progressFill) {
        const targetWidth = progressFill.getAttribute('data-progress') + '%';
        progressFill.style.width = '0%';
        setTimeout(() => {
            progressFill.style.width = targetWidth;
        }, 200);
    }
}

// Switch leaderboard period with animation
function switchLeaderboardPeriod(period) {
    // Remove active class from all buttons
    const buttons = document.querySelectorAll('.period-btn-animated');
    buttons.forEach(btn => btn.classList.remove('active'));
    
    // Add active class to clicked button
    event.target.closest('.period-btn-animated').classList.add('active');
    
    // Trigger animation refresh
    setTimeout(initLeaderboardAnimations, 200);
}

// Call wallet, challenge, and leaderboard animations when navigating
const originalNavigateTo = navigateTo;
navigateTo = function(screenId) {
    originalNavigateTo(screenId);
    if (screenId === 'wallet') {
        setTimeout(initWalletAnimations, 300);
    } else if (screenId === 'challenges') {
        setTimeout(initChallengeAnimations, 300);
    }
};

// Initialize leaderboard animations when switching to leaderboard tab
function switchEngageTab(tabName) {
    // Remove active from all tabs
    const tabs = document.querySelectorAll('.engage-tab');
    tabs.forEach(tab => tab.classList.remove('active'));
    event.target.closest('.engage-tab').classList.add('active');
    
    // Hide all content
    const contents = document.querySelectorAll('.engage-tab-content');
    contents.forEach(content => content.classList.remove('active'));
    
    // Show selected content
    const selectedContent = document.getElementById('engage' + tabName.charAt(0).toUpperCase() + tabName.slice(1));
    if (selectedContent) {
        selectedContent.classList.add('active');
        
        // Trigger animations based on tab
        if (tabName === 'challenges') {
            setTimeout(initChallengeAnimations, 100);
        } else if (tabName === 'leaderboard') {
            setTimeout(initLeaderboardAnimations, 100);
        } else if (tabName === 'community') {
            setTimeout(initCommunityAnimations, 100);
        } else if (tabName === 'games') {
            setTimeout(initGamesAnimations, 100);
        }
    }
}

// Initialize community animations
function initCommunityAnimations() {
    animateCommunityStats();
}

// Animate community stats counters
function animateCommunityStats() {
    const stats = [
        { id: 'community-members', value: 2847 },
        { id: 'community-posts', value: 156 },
        { id: 'community-trending', value: 24 }
    ];
    
    stats.forEach(stat => {
        const element = document.getElementById(stat.id);
        if (element) {
            animateValue(element, 0, stat.value, 1500);
        }
    });
}

// Like post function
function likePost(button) {
    const isLiked = button.classList.contains('liked');
    const countElement = button.querySelector('.action-count-animated');
    const currentCount = parseInt(countElement.textContent) || 0;
    
    if (isLiked) {
        // Unlike
        button.classList.remove('liked');
        countElement.textContent = currentCount - 1;
    } else {
        // Like
        button.classList.add('liked');
        countElement.textContent = currentCount + 1;
        
        // Trigger heart animation
        const icon = button.querySelector('.action-icon-animated');
        icon.style.animation = 'none';
        setTimeout(() => {
            icon.style.animation = 'likeHeart 0.6s ease';
        }, 10);
    }
}

// Initialize games animations
function initGamesAnimations() {
    animateGamesStats();
}

// Animate games stats counters
function animateGamesStats() {
    const stats = [
        { id: 'game-rank', value: 247 },
        { id: 'game-coins-won', value: 1450 },
        { id: 'game-achievements', value: 12 },
        { id: 'game-challenges-won', value: 8 }
    ];
    
    stats.forEach(stat => {
        const element = document.getElementById(stat.id);
        if (element) {
            animateValue(element, 0, stat.value, 1500);
        }
    });
}

// Add interaction feedback
document.addEventListener('DOMContentLoaded', () => {
    // Initialize recipe history
    loadRecipeHistory();
    updateRecipeSuggestions();
    
    // FOR TESTING: Simulate recipe viewing history (REMOVE THIS IN PRODUCTION)
    // Uncomment the lines below to see the suggestions immediately
    recipeViewHistory.ingredients['mango'] = {
        count: 5,
        lastViewed: new Date().toISOString(),
        viewedRecipes: ['mango-smoothie', 'mango-salsa']
    };
    saveRecipeHistory();
    updateRecipeSuggestions();
    
    // Add click animation to all buttons
    const buttons = document.querySelectorAll('button, .action-card, .flavor-card, .reward-card');
    buttons.forEach(button => {
        button.addEventListener('click', function(e) {
            this.style.transform = 'scale(0.95)';
            setTimeout(() => {
                this.style.transform = '';
            }, 150);
        });
    });

    // Simulate loading state for splash screen
    const splash = document.getElementById('splash');
    if (splash) {
        setTimeout(() => {
            splash.classList.add('loaded');
        }, 500);
    }

    // Handle form submissions
    const forms = document.querySelectorAll('form');
    forms.forEach(form => {
        form.addEventListener('submit', (e) => {
            e.preventDefault();
        });
    });
});

// Handle sign-up form validation
function handleSignUp() {
    const password = document.getElementById('signup-password').value;
    const confirmPassword = document.getElementById('signup-confirm-password').value;
    const termsCheckbox = document.getElementById('terms-checkbox');
    
    // Validate password length
    if (password.length < 8) {
        showNotification('Password must be at least 8 characters long', 'error');
        return;
    }
    
    // Validate passwords match
    if (password !== confirmPassword) {
        showNotification('Passwords do not match!', 'error');
        return;
    }
    
    // Validate terms acceptance
    if (!termsCheckbox.checked) {
        showNotification('Please accept the Terms & Conditions', 'error');
        return;
    }
    
    // Success
    showNotification('Account created successfully! 🎉', 'success');
    setTimeout(() => {
        navigateTo('home');
    }, 1000);
}

// Simulate real-time updates
function updateIceCoins() {
    const coinElements = document.querySelectorAll('.wallet-balance h1');
    coinElements.forEach(element => {
        // This could be connected to a real backend
        const currentCoins = parseInt(element.textContent.replace(',', ''));
        // Just for demonstration - in real app, this would come from server
    });
}

// Handle reward redemption
function redeemReward(rewardName, cost) {
    const confirmed = confirm(`Redeem ${rewardName} for ${cost} IceCoins?`);
    if (confirmed) {
        alert(`Success! You've redeemed ${rewardName}. Check your wallet for the redemption code.`);
        navigateTo('wallet');
    }
}

// Add event listeners for reward redemption
document.addEventListener('DOMContentLoaded', () => {
    const redeemButtons = document.querySelectorAll('.btn-small-primary');
    redeemButtons.forEach((button, index) => {
        button.addEventListener('click', (e) => {
            e.stopPropagation();
            const rewardCard = button.closest('.reward-detail-card');
            const rewardName = rewardCard.querySelector('h3').textContent;
            const rewardCost = rewardCard.querySelector('.reward-price').textContent;
            redeemReward(rewardName, rewardCost);
        });
    });
});

// Handle social interactions
function likePost(postElement) {
    const likeButton = postElement.querySelector('.post-actions button:first-child');
    const currentLikes = parseInt(likeButton.textContent.match(/\d+/)[0]);
    likeButton.textContent = `❤️ ${currentLikes + 1}`;
    likeButton.style.color = '#EF4444';
}

// Add post interaction listeners
document.addEventListener('DOMContentLoaded', () => {
    const posts = document.querySelectorAll('.post-card');
    posts.forEach(post => {
        const likeButton = post.querySelector('.post-actions button:first-child');
        if (likeButton) {
            likeButton.addEventListener('click', () => {
                likePost(post);
            });
        }
    });
});

// Challenge progress animation
function updateChallengeProgress(challengeId, newProgress) {
    const progressBar = document.querySelector(`#${challengeId} .progress-fill`);
    if (progressBar) {
        progressBar.style.width = `${newProgress}%`;
    }
}

// Notification system
function showNotification(message, type = 'info') {
    // Create notification element
    const notification = document.createElement('div');
    notification.className = `notification notification-${type}`;
    notification.textContent = message;
    
    // Set background color based on type
    let bgColor;
    switch(type) {
        case 'success':
            bgColor = '#10B981';
            break;
        case 'error':
            bgColor = '#EF4444';
            break;
        case 'warning':
            bgColor = '#F59E0B';
            break;
        default:
            bgColor = '#0B5FFF';
    }
    
    notification.style.cssText = `
        position: fixed;
        top: 20px;
        left: 50%;
        transform: translateX(-50%);
        background: ${bgColor};
        color: white;
        padding: 16px 24px;
        border-radius: 12px;
        box-shadow: 0 8px 16px rgba(0,0,0,0.2);
        z-index: 1000;
        font-weight: 600;
        animation: slideDown 0.3s ease;
    `;

    document.body.appendChild(notification);

    // Remove after 3 seconds
    setTimeout(() => {
        notification.style.animation = 'slideUp 0.3s ease';
        setTimeout(() => {
            document.body.removeChild(notification);
        }, 300);
    }, 3000);
}

// Add CSS animations for notifications
const style = document.createElement('style');
style.textContent = `
    @keyframes slideDown {
        from {
            opacity: 0;
            transform: translateX(-50%) translateY(-20px);
        }
        to {
            opacity: 1;
            transform: translateX(-50%) translateY(0);
        }
    }
    @keyframes slideUp {
        from {
            opacity: 1;
            transform: translateX(-50%) translateY(0);
        }
        to {
            opacity: 0;
            transform: translateX(-50%) translateY(-20px);
        }
    }
`;
document.head.appendChild(style);

// Initialize app
document.addEventListener('DOMContentLoaded', () => {
    console.log('SavoyConnect App Initialized');
    
    // Check if user is logged in (for demo purposes, always start at splash)
    const currentScreen = 'splash';
    navigateTo(currentScreen);
    
    // Start carousel auto-play after initialization
    setTimeout(() => {
        startCarousel();
        
        // Pause carousel on hover
        const carousel = document.querySelector('.hero-carousel');
        if (carousel) {
            carousel.addEventListener('mouseenter', stopCarousel);
            carousel.addEventListener('mouseleave', startCarousel);
        }
    }, 2000);
});

// ========================================
// STORE LOCATOR FUNCTIONS
// ========================================

// Store data
const storeData = {
    'depot-1': {
        name: 'Savoy Main Depot',
        type: 'depot',
        icon: '🏭',
        address: '123 Main Street, Downtown, Dhaka',
        phone: '+880 1234-567890',
        distance: '0.5 km',
        stockStatus: 'full',
        stockText: 'Always Stocked',
        flavorCount: '20+',
        hours: 'Mon-Sun: 9:00 AM - 10:00 PM',
        route: {
            driveTime: '3 min',
            walkTime: '8 min',
            routeDistance: '0.5 km'
        }
    },
    'store-1': {
        name: 'Sweet Corner Retailer',
        type: 'retailer',
        icon: '🏪',
        address: '456 Park Avenue, Central, Dhaka',
        phone: '+880 1234-567891',
        distance: '1.2 km',
        stockStatus: 'available',
        stockText: 'In Stock',
        flavorCount: '15',
        hours: 'Mon-Sun: 10:00 AM - 9:00 PM',
        route: {
            driveTime: '8 min',
            walkTime: '18 min',
            routeDistance: '1.2 km'
        }
    },
    'store-2': {
        name: 'Ice Dream Shop',
        type: 'retailer',
        icon: '🏪',
        address: '789 Lake Road, Westside, Dhaka',
        phone: '+880 1234-567892',
        distance: '1.8 km',
        stockStatus: 'available',
        stockText: 'In Stock',
        flavorCount: '12',
        hours: 'Mon-Sun: 11:00 AM - 8:00 PM',
        route: {
            driveTime: '12 min',
            walkTime: '28 min',
            routeDistance: '1.8 km'
        }
    },
    'store-3': {
        name: 'Frozen Treats Plaza',
        type: 'retailer',
        icon: '🏪',
        address: '321 Market Street, Eastside, Dhaka',
        phone: '+880 1234-567893',
        distance: '2.3 km',
        stockStatus: 'low',
        stockText: 'Low Stock',
        flavorCount: '3',
        hours: 'Mon-Sun: 9:00 AM - 7:00 PM',
        route: {
            driveTime: '16 min',
            walkTime: '35 min',
            routeDistance: '2.3 km'
        }
    },
    'store-4': {
        name: 'Chill Zone Mart',
        type: 'retailer',
        icon: '🏪',
        address: '555 North Avenue, Uptown, Dhaka',
        phone: '+880 1234-567894',
        distance: '3.1 km',
        stockStatus: 'out',
        stockText: 'Out of Stock',
        flavorCount: '0',
        hours: 'Mon-Sun: 10:00 AM - 9:00 PM',
        route: {
            driveTime: '22 min',
            walkTime: '45 min',
            routeDistance: '3.1 km'
        }
    }
};

// Show store detail
function showStoreDetail(storeId) {
    const store = storeData[storeId];
    if (!store) return;

    // Update store detail screen
    document.getElementById('storeDetailName').textContent = store.name;
    document.getElementById('storeAddress').textContent = store.address;
    document.getElementById('storePhone').textContent = store.phone;
    document.getElementById('storeDistance').textContent = `${store.distance} from your location`;
    document.getElementById('flavorCount').textContent = store.flavorCount;
    
    // Update icon
    const iconElement = document.querySelector('.store-detail-icon');
    if (iconElement) iconElement.textContent = store.icon;

    // Update type badge
    const typeBadge = document.getElementById('storeTypeBadge');
    if (store.type === 'depot') {
        typeBadge.textContent = '🏭 Official Depot - Always Stocked';
        typeBadge.style.background = 'var(--color-primary)';
    } else {
        typeBadge.textContent = '🏪 Authorized Retailer';
        typeBadge.style.background = 'var(--color-secondary)';
    }

    // Update route information
    if (store.route) {
        document.getElementById('routeDriveTime').textContent = store.route.driveTime;
        document.getElementById('routeDistance').textContent = store.route.routeDistance;
        document.getElementById('routeWalkTime').textContent = store.route.walkTime;
    }

    // Update end marker icon on map
    const endMarker = document.querySelector('.end-marker .marker-icon-large');
    if (endMarker) {
        endMarker.textContent = store.icon;
    }

    // Update stock status
    const stockStatusLarge = document.getElementById('stockStatusLarge');
    const stockIcon = stockStatusLarge.querySelector('.stock-icon');
    const stockTitle = stockStatusLarge.querySelector('h3');
    const stockDesc = stockStatusLarge.querySelector('p');

    switch(store.stockStatus) {
        case 'full':
            stockIcon.textContent = '✅';
            stockTitle.textContent = 'Fully Stocked';
            stockTitle.style.color = 'var(--color-primary)';
            stockDesc.textContent = 'All flavors available';
            break;
        case 'available':
            stockIcon.textContent = '✅';
            stockTitle.textContent = 'In Stock';
            stockTitle.style.color = 'var(--color-success)';
            stockDesc.textContent = `${store.flavorCount} flavors available`;
            break;
        case 'low':
            stockIcon.textContent = '⚠️';
            stockTitle.textContent = 'Low Stock';
            stockTitle.style.color = 'var(--color-warning)';
            stockDesc.textContent = `Only ${store.flavorCount} flavors left`;
            break;
        case 'out':
            stockIcon.textContent = '❌';
            stockTitle.textContent = 'Out of Stock';
            stockTitle.style.color = 'var(--color-error)';
            stockDesc.textContent = 'No flavors available currently';
            break;
    }

    // Navigate to detail screen
    navigateTo('store-detail');
    
    // Show notification
    showNotification(`Viewing ${store.name}`, 'info');
}

// Filter stores
function filterStores(filterType) {
    // Update button states
    const filterButtons = document.querySelectorAll('.filter-btn');
    filterButtons.forEach(btn => {
        btn.classList.remove('active');
    });
    event.target.classList.add('active');

    // Get all store cards
    const storeCards = document.querySelectorAll('.store-card');
    
    storeCards.forEach(card => {
        switch(filterType) {
            case 'all':
                card.style.display = 'flex';
                break;
            case 'depot':
                if (card.classList.contains('depot-card')) {
                    card.style.display = 'flex';
                } else {
                    card.style.display = 'none';
                }
                break;
            case 'stock':
                const stockBadge = card.querySelector('.stock-badge');
                if (stockBadge && (stockBadge.classList.contains('stock-full') || 
                    stockBadge.classList.contains('stock-available'))) {
                    card.style.display = 'flex';
                } else {
                    card.style.display = 'none';
                }
                break;
        }
    });

    // Show notification
    const filterText = filterType === 'all' ? 'All Stores' : 
                      filterType === 'depot' ? 'Savoy Depots' : 
                      'Stores with Stock';
    showNotification(`Showing: ${filterText}`, 'info');
}

// Toggle map view
function toggleMapView() {
    const mapView = document.getElementById('mapView');
    const listView = document.getElementById('listView');
    
    if (mapView.style.display === 'none') {
        mapView.style.display = 'block';
        listView.style.display = 'none';
        showNotification('Switched to Map View', 'info');
    } else {
        mapView.style.display = 'none';
        listView.style.display = 'block';
        showNotification('Switched to List View', 'info');
    }
}

// Use my location
function useMyLocation() {
    showNotification('📍 Using your current location...', 'info');
    // In a real app, this would use geolocation API
    setTimeout(() => {
        showNotification('Location found! Showing nearby stores', 'success');
    }, 1500);
}

// Get directions to store
function getDirections() {
    const storeName = document.getElementById('storeDetailName').textContent;
    const address = document.getElementById('storeAddress').textContent;
    
    // In a real app, this would open Google Maps or similar
    showNotification(`Opening directions to ${storeName}...`, 'info');
    
    // Simulate opening maps
    setTimeout(() => {
        alert(`Directions to:\n${storeName}\n${address}\n\nThis would open in your maps app.`);
    }, 500);
}

// Call store
function callStore() {
    const phone = document.getElementById('storePhone').textContent;
    const storeName = document.getElementById('storeDetailName').textContent;
    
    // In a real app, this would trigger phone call
    if (confirm(`Call ${storeName}?\n${phone}`)) {
        showNotification(`Calling ${phone}...`, 'info');
        // window.location.href = `tel:${phone}`;
    }
}

// Share store
function shareStore() {
    const storeName = document.getElementById('storeDetailName').textContent;
    const address = document.getElementById('storeAddress').textContent;
    
    // In a real app, this would use Web Share API
    showNotification('Sharing store information...', 'info');
    
    setTimeout(() => {
        alert(`Share:\n${storeName}\n${address}\n\nThis would open share options on your device.`);
    }, 500);
}

// ========================================
// REVIEW & RATING SYSTEM FUNCTIONS
// ========================================

let selectedRating = 0;

// Open review modal
function openReviewModal() {
    const modal = document.getElementById('reviewModal');
    modal.classList.add('active');
    selectedRating = 0;
    
    // Reset form
    document.getElementById('reviewForm').reset();
    document.getElementById('ratingValue').value = '';
    
    // Reset stars
    const stars = document.querySelectorAll('.star-input');
    stars.forEach(star => star.classList.remove('active'));
    
    // Reset character count
    document.getElementById('charCount').textContent = '0';
}

// Close review modal
function closeReviewModal() {
    const modal = document.getElementById('reviewModal');
    modal.classList.remove('active');
}

// Set rating
function setRating(rating) {
    selectedRating = rating;
    document.getElementById('ratingValue').value = rating;
    
    // Update star display
    const stars = document.querySelectorAll('.star-input');
    stars.forEach((star, index) => {
        if (index < rating) {
            star.classList.add('active');
        } else {
            star.classList.remove('active');
        }
    });
}

// Character count for review text
document.addEventListener('DOMContentLoaded', () => {
    const reviewTextArea = document.getElementById('reviewText');
    if (reviewTextArea) {
        reviewTextArea.addEventListener('input', (e) => {
            const count = e.target.value.length;
            document.getElementById('charCount').textContent = count;
            
            if (count > 500) {
                e.target.value = e.target.value.substring(0, 500);
                document.getElementById('charCount').textContent = '500';
            }
        });
    }
});

// Submit review
function submitReview(event) {
    event.preventDefault();
    
    const rating = document.getElementById('ratingValue').value;
    const title = document.getElementById('reviewTitle').value;
    const reviewText = document.getElementById('reviewText').value;
    const visitDate = document.getElementById('visitDate').value;
    const recommend = document.getElementById('wouldRecommend').checked;
    
    if (!rating || rating < 1 || rating > 5) {
        showNotification('Please select a rating', 'error');
        return;
    }
    
    if (!title || !reviewText) {
        showNotification('Please fill in all required fields', 'error');
        return;
    }
    
    // In a real app, this would send to backend
    console.log('Review submitted:', {
        rating,
        title,
        reviewText,
        visitDate,
        recommend
    });
    
    showNotification('Thank you! Your review has been submitted 🎉', 'success');
    closeReviewModal();
    
    // Add review to the list (demo purposes)
    addNewReviewToList(rating, title, reviewText);
}

// Add new review to the list (demo)
function addNewReviewToList(rating, title, reviewText) {
    const reviewsList = document.getElementById('reviewsList');
    
    const stars = Array.from({length: 5}, (_, i) => {
        return `<span class="star ${i < rating ? 'filled' : 'empty'}">★</span>`;
    }).join('');
    
    const newReview = document.createElement('div');
    newReview.className = 'review-card';
    newReview.setAttribute('data-rating', rating);
    newReview.innerHTML = `
        <div class="review-header">
            <div class="reviewer-info">
                <div class="reviewer-avatar">👤</div>
                <div>
                    <h4 class="reviewer-name">You</h4>
                    <div class="review-stars">${stars}</div>
                </div>
            </div>
            <span class="review-date">Just now</span>
        </div>
        <p class="review-text"><strong>${title}</strong><br>${reviewText}</p>
        <div class="review-footer">
            <button class="review-action" onclick="likeReview(this)">
                <span>👍</span> Helpful (0)
            </button>
        </div>
    `;
    
    reviewsList.insertBefore(newReview, reviewsList.firstChild);
    
    // Update review count
    const reviewCount = document.getElementById('reviewCount');
    const currentCount = parseInt(reviewCount.textContent.split(' ')[0]);
    reviewCount.textContent = `${currentCount + 1} reviews`;
}

// Filter reviews
function filterReviews(filterType) {
    // Update button states
    const filterButtons = document.querySelectorAll('.filter-chip');
    filterButtons.forEach(btn => {
        btn.classList.remove('active');
    });
    event.target.classList.add('active');
    
    // Get all review cards
    const reviewCards = document.querySelectorAll('.review-card');
    
    reviewCards.forEach(card => {
        const rating = card.getAttribute('data-rating');
        let shouldShow = false;
        
        switch(filterType) {
            case 'all':
                shouldShow = true;
                break;
            case '5':
            case '4':
            case '3':
                shouldShow = rating === filterType;
                break;
            case 'positive':
                shouldShow = rating >= 4;
                break;
            case 'recent':
                shouldShow = true; // In real app, would sort by date
                break;
        }
        
        card.style.display = shouldShow ? 'block' : 'none';
    });
    
    showNotification(`Filtered: ${filterType === 'all' ? 'All Reviews' : filterType + ' Stars'}`, 'info');
}

// Like review
function likeReview(button) {
    if (button.classList.contains('liked')) {
        button.classList.remove('liked');
        const currentCount = parseInt(button.textContent.match(/\d+/)[0]);
        button.innerHTML = `<span>👍</span> Helpful (${currentCount - 1})`;
    } else {
        button.classList.add('liked');
        const currentCount = parseInt(button.textContent.match(/\d+/)[0]);
        button.innerHTML = `<span>👍</span> Helpful (${currentCount + 1})`;
    }
}

// Load more reviews
function loadMoreReviews() {
    showNotification('Loading more reviews...', 'info');
    
    // In a real app, this would load more reviews from backend
    setTimeout(() => {
        showNotification('All reviews loaded!', 'success');
    }, 1000);
}

// Close modal when clicking outside
document.addEventListener('click', (e) => {
    const modal = document.getElementById('reviewModal');
    if (modal && e.target === modal) {
        closeReviewModal();
    }
});

// ========================================
// EXPLORE FLAVORS & FLAVOR DETAIL FUNCTIONS
// ========================================

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
    },
    'lychee-rose': {
        name: 'Lychee Rose',
        icon: '🌸',
        tagline: 'Floral & Exotic',
        badge: '🚀 Upcoming',
        badgeClass: 'badge-upcoming',
        mainIngredient: 'lychee',
        story: 'An exotic fusion coming this winter! Delicate rose water meets sweet lychee fruit in this sophisticated flavor. Inspired by Asian dessert traditions, this unique combination offers a refreshing and elegant ice cream experience.',
        ingredients: ['🥛 Coconut Milk', '🌸 Rose Water', '🍈 Fresh Lychee', '🍯 Honey', '🌺 Rose Petals', '💧 Natural Essence'],
        nutrition: {
            servingSize: '100g',
            calories: '175 kcal',
            fat: '7g',
            carbs: '26g',
            protein: '2g'
        },
        availability: 'Launching February 2026'
    },
    'coconut-dream': {
        name: 'Coconut Dream',
        icon: '🥥',
        tagline: 'Creamy & Tropical',
        badge: '',
        badgeClass: '',
        mainIngredient: 'coconut',
        story: 'Transport yourself to a tropical island with every scoop of Coconut Dream. Made with real coconut milk and shredded coconut, this dairy-free option delivers authentic coconut flavor while maintaining a creamy, indulgent texture.',
        ingredients: ['🥥 Coconut Milk', '🌴 Shredded Coconut', '🍯 Agave Nectar', '🌿 Vanilla', '🧂 Sea Salt'],
        nutrition: {
            servingSize: '100g',
            calories: '195 kcal',
            fat: '10g',
            carbs: '24g',
            protein: '2g'
        },
        availability: 'In stock at 10 stores near you'
    },
    'lemon-sorbet': {
        name: 'Lemon Sorbet',
        icon: '🍋',
        tagline: 'Tangy & Light',
        badge: '',
        badgeClass: '',
        mainIngredient: 'lemon',
        story: 'A refreshing palate cleanser, our Lemon Sorbet is made with fresh lemon juice and zest. This dairy-free option is perfect for hot days, offering a bright, citrusy flavor that is both tart and sweet.',
        ingredients: ['🍋 Fresh Lemon Juice', '💧 Filtered Water', '🍬 Cane Sugar', '🍋 Lemon Zest', '🌿 Mint Extract'],
        nutrition: {
            servingSize: '100g',
            calories: '120 kcal',
            fat: '0g',
            carbs: '30g',
            protein: '0g'
        },
        availability: 'In stock at 13 stores near you'
    },
    'cherry-garcia': {
        name: 'Cherry Garcia',
        icon: '🍒',
        tagline: 'Fruity Delight',
        badge: '',
        badgeClass: '',
        mainIngredient: 'cherry',
        story: 'Named after the legendary musician, Cherry Garcia combines sweet cherries with dark chocolate chunks in a rich vanilla base. This flavor has been a fan favorite since the 1990s, offering a perfect blend of fruit and chocolate.',
        ingredients: ['🥛 Fresh Milk', '🍒 Dark Cherries', '🍫 Chocolate Chunks', '🧈 Cream', '🍬 Sugar', '🌿 Vanilla'],
        nutrition: {
            servingSize: '100g',
            calories: '215 kcal',
            fat: '11g',
            carbs: '27g',
            protein: '4g'
        },
        availability: 'In stock at 11 stores near you'
    },
    'coffee-crunch': {
        name: 'Coffee Crunch',
        icon: '☕',
        tagline: 'Bold & Energizing',
        badge: '',
        badgeClass: '',
        mainIngredient: 'coffee',
        story: 'For coffee lovers, Coffee Crunch delivers a rich espresso flavor with crunchy toffee bits. Made with premium Arabica coffee beans, this flavor provides the perfect pick-me-up in ice cream form.',
        ingredients: ['🥛 Fresh Milk', '☕ Espresso', '🍬 Toffee Bits', '🧈 Cream', '🍫 Cocoa', '🌿 Coffee Extract'],
        nutrition: {
            servingSize: '100g',
            calories: '225 kcal',
            fat: '12g',
            carbs: '26g',
            protein: '4g'
        },
        availability: 'In stock at 14 stores near you'
    }
};

// Switch explore category tabs
function switchExploreCategory(category) {
    // Update tab buttons
    const tabs = document.querySelectorAll('.explore-tab');
    tabs.forEach(tab => tab.classList.remove('active'));
    event.target.classList.add('active');

    // Show corresponding category
    const categories = document.querySelectorAll('.explore-category');
    categories.forEach(cat => cat.classList.remove('active'));
    
    document.getElementById(`explore-${category}`).classList.add('active');
    
    showNotification(`Showing ${category === 'all' ? 'All Flavors' : category.charAt(0).toUpperCase() + category.slice(1)} flavors`, 'info');
}

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
    
    // Update recipe inspiration section
    if (flavor && flavor.mainIngredient && typeof recipeDatabase !== 'undefined') {
        const recipes = recipeDatabase[flavor.mainIngredient];
        if (recipes && recipes.length > 0) {
            // Show recipe section
            const recipeSection = document.getElementById('recipeInspirationSection');
            if (recipeSection) {
                recipeSection.style.display = 'block';
                
                // Update ingredient name
                const ingredientName = flavor.mainIngredient.charAt(0).toUpperCase() + flavor.mainIngredient.slice(1);
                const mainIngredientNameEl = document.getElementById('mainIngredientName');
                if (mainIngredientNameEl) {
                    mainIngredientNameEl.textContent = ingredientName;
                }
                
                // Update recipe inspiration text
                const inspirationText = document.getElementById('recipeInspirationText');
                if (inspirationText) {
                    inspirationText.innerHTML = `Explore <strong>${recipes.length}</strong> delicious recipes you can make with <strong>${ingredientName}</strong>`;
                }
            }
        } else {
            // Hide recipe section if no recipes available
            const recipeSection = document.getElementById('recipeInspirationSection');
            if (recipeSection) {
                recipeSection.style.display = 'none';
            }
        }
    } else {
        // Hide recipe section if no main ingredient
        const recipeSection = document.getElementById('recipeInspirationSection');
        if (recipeSection) {
            recipeSection.style.display = 'none';
        }
    }

    // Navigate to detail screen
    navigateTo('flavor-detail');
    
    showNotification(`Viewing ${flavor.name}`, 'info');
}

// Search flavors
function searchFlavors() {
    showNotification('🔍 Search feature coming soon!', 'info');
}

// Share flavor
function shareFlavor() {
    const flavorName = document.getElementById('flavorName').textContent;
    showNotification(`Sharing ${flavorName}...`, 'info');
    
    setTimeout(() => {
        alert(`Share ${flavorName} with your friends!\n\nThis would open share options on your device.`);
    }, 500);
}

// ========================================
// NEWS & CAMPAIGNS FUNCTIONS
// ========================================

// Switch campaign tab
function switchCampaignTab(category) {
    // Update tab buttons
    const tabs = document.querySelectorAll('.campaign-tab');
    tabs.forEach(tab => tab.classList.remove('active'));
    event.target.classList.add('active');

    // Filter campaign cards
    const cards = document.querySelectorAll('.campaign-card');
    cards.forEach(card => {
        const cardCategory = card.getAttribute('data-category');
        if (category === 'all' || cardCategory === category) {
            card.style.display = 'block';
        } else {
            card.style.display = 'none';
        }
    });

    const categoryText = category === 'all' ? 'All Campaigns' :
                        category === 'launches' ? 'New Launches' :
                        category === 'csr' ? 'CSR Initiatives' :
                        'Special Offers';
    
    showNotification(`Showing: ${categoryText}`, 'info');
}

// Show campaign detail
function showCampaignDetail(campaignId) {
    // In a real app, this would show detailed campaign information
    showNotification(`Opening campaign details...`, 'info');
    
    setTimeout(() => {
        alert(`Campaign Details:\n\nThis would show more information about the campaign, including:\n• Full description\n• How to participate\n• Terms & conditions\n• Impact statistics\n• Share options`);
    }, 500);
}

// Filter campaigns (notifications toggle)
function filterCampaigns() {
    showNotification('Campaign notifications enabled!', 'success');
}

// ========================================
// RECIPE INSPIRATION FUNCTIONS
// ========================================

// Global variable to track current flavor for recipes
let currentFlavorForRecipes = null;
let currentRecipeDetail = null;

// Comprehensive All Recipes Database
const allRecipesDatabase = {
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
    },
    'waffle-sundae': {
        id: 'waffle-sundae',
        name: 'Waffle Cone Sundae',
        category: 'Treats',
        image: '🧇',
        prepTime: '20 min',
        servings: '2',
        difficulty: 'Medium',
        description: 'Crispy waffle cone bowl filled with ice cream, toppings, and drizzles',
        ingredients: [
            '2 waffle cone bowls',
            '4 scoops Savoy Ice Cream (mixed flavors)',
            'Chocolate sauce',
            'Caramel sauce',
            'Whipped cream',
            'Sprinkles',
            'Chopped nuts',
            'Fresh fruit'
        ],
        instructions: [
            'Warm waffle cone bowls slightly for extra crispness',
            'Place bowls on serving plates',
            'Add 2 scoops of ice cream to each bowl',
            'Drizzle with chocolate and caramel sauce',
            'Top with whipped cream',
            'Add sprinkles, nuts, and fresh fruit',
            'Serve immediately before waffle softens'
        ],
        tips: 'Prepare all toppings in advance. Serve quickly as waffle bowls can become soggy.'
    },
    'smoothie-bowl': {
        id: 'smoothie-bowl',
        name: 'Mango Smoothie Bowl',
        category: 'Desserts',
        image: '🥭',
        prepTime: '15 min',
        servings: '2',
        difficulty: 'Easy',
        description: 'Thick mango smoothie bowl topped with fresh fruits, granola, and coconut',
        ingredients: [
            '2 cups Savoy Mango Ice Cream',
            '1 frozen banana',
            '1 cup frozen mango chunks',
            '1/2 cup coconut milk',
            'Granola for topping',
            'Fresh fruits (berries, kiwi, banana slices)',
            'Shredded coconut',
            'Chia seeds',
            'Honey drizzle'
        ],
        instructions: [
            'Blend ice cream, frozen banana, mango, and coconut milk until thick',
            'Pour into bowls',
            'Arrange fresh fruit slices on top',
            'Add granola clusters',
            'Sprinkle with shredded coconut and chia seeds',
            'Drizzle with honey',
            'Serve immediately with a spoon'
        ],
        tips: 'Keep smoothie thick - add liquid sparingly. Get creative with toppings for Instagram-worthy bowls!'
    },
    'lava-cake': {
        id: 'lava-cake',
        name: 'Chocolate Lava Cake',
        category: 'Desserts',
        image: '🍫',
        prepTime: '35 min',
        servings: '4',
        difficulty: 'Hard',
        description: 'Warm molten chocolate cake served with a scoop of vanilla ice cream',
        ingredients: [
            '1/2 cup butter',
            '4 oz dark chocolate',
            '2 eggs',
            '2 egg yolks',
            '1/4 cup sugar',
            '2 tablespoons flour',
            '4 scoops Savoy Vanilla Ice Cream',
            'Powdered sugar for dusting',
            'Fresh berries'
        ],
        instructions: [
            'Preheat oven to 425°F. Grease ramekins',
            'Melt butter and chocolate together',
            'Whisk eggs, yolks, and sugar until thick',
            'Fold in chocolate mixture and flour',
            'Pour batter into ramekins',
            'Bake for 12-14 minutes until edges are firm but center jiggles',
            'Let cool 1 minute, then invert onto plates',
            'Add a scoop of vanilla ice cream',
            'Dust with powdered sugar and garnish with berries',
            'Serve immediately'
        ],
        tips: 'Timing is crucial - underbake slightly for molten center. The ice cream melting into the warm cake is the magic!'
    }
};

// Recipe viewing history tracker
let recipeViewHistory = {
    ingredients: {},  // Track views per ingredient
    recipes: []       // Track individual recipe views
};

// Load recipe history from localStorage
function loadRecipeHistory() {
    const saved = localStorage.getItem('recipeViewHistory');
    if (saved) {
        recipeViewHistory = JSON.parse(saved);
    }
}

// Save recipe history to localStorage
function saveRecipeHistory() {
    localStorage.setItem('recipeViewHistory', JSON.stringify(recipeViewHistory));
}

// Track recipe view
function trackRecipeView(ingredient, recipeId) {
    // Track ingredient views
    if (!recipeViewHistory.ingredients[ingredient]) {
        recipeViewHistory.ingredients[ingredient] = {
            count: 0,
            lastViewed: null,
            viewedRecipes: []
        };
    }
    
    recipeViewHistory.ingredients[ingredient].count++;
    recipeViewHistory.ingredients[ingredient].lastViewed = new Date().toISOString();
    
    if (!recipeViewHistory.ingredients[ingredient].viewedRecipes.includes(recipeId)) {
        recipeViewHistory.ingredients[ingredient].viewedRecipes.push(recipeId);
    }
    
    // Track individual recipe views
    const existingView = recipeViewHistory.recipes.find(r => r.id === recipeId);
    if (existingView) {
        existingView.count++;
        existingView.lastViewed = new Date().toISOString();
    } else {
        recipeViewHistory.recipes.push({
            id: recipeId,
            ingredient: ingredient,
            count: 1,
            lastViewed: new Date().toISOString()
        });
    }
    
    saveRecipeHistory();
}

// Get recipe suggestions based on viewing history
function getRecipeSuggestions() {
    const suggestions = [];
    
    // Find most viewed ingredient
    let mostViewedIngredient = null;
    let maxViews = 0;
    
    for (const [ingredient, data] of Object.entries(recipeViewHistory.ingredients)) {
        if (data.count > maxViews) {
            maxViews = data.count;
            mostViewedIngredient = ingredient;
        }
    }
    
    if (mostViewedIngredient && maxViews >= 2) {
        const allRecipes = recipeDatabase[mostViewedIngredient] || [];
        const viewedRecipes = recipeViewHistory.ingredients[mostViewedIngredient].viewedRecipes;
        
        // Get recipes not yet viewed
        const newRecipes = allRecipes.filter(recipe => !viewedRecipes.includes(recipe.id));
        
        if (newRecipes.length > 0) {
            suggestions.push({
                ingredient: mostViewedIngredient,
                viewCount: maxViews,
                newRecipes: newRecipes.slice(0, 3) // Show up to 3 suggestions
            });
        }
    }
    
    return suggestions;
}

// Update recipe suggestions on home screen
function updateRecipeSuggestions() {
    const suggestions = getRecipeSuggestions();
    const container = document.getElementById('recipeSuggestionsContainer');
    
    if (!container) return;
    
    if (suggestions.length === 0) {
        container.style.display = 'none';
        return;
    }
    
    const suggestion = suggestions[0]; // Show first suggestion
    container.style.display = 'block';
    
    // Update suggestion content
    const ingredientName = suggestion.ingredient.charAt(0).toUpperCase() + suggestion.ingredient.slice(1);
    document.getElementById('suggestionIngredientName').textContent = ingredientName;
    document.getElementById('suggestionViewCount').textContent = suggestion.viewCount;
    
    // Populate suggestion cards
    const cardsContainer = document.getElementById('recipeSuggestionCards');
    cardsContainer.innerHTML = '';
    
    suggestion.newRecipes.forEach(recipe => {
        const card = document.createElement('div');
        card.className = 'recipe-suggestion-card';
        card.onclick = () => {
            currentFlavorForRecipes = Object.keys(flavorData).find(key => 
                flavorData[key].mainIngredient === suggestion.ingredient
            );
            showRecipeDetail(recipe.id, suggestion.ingredient);
        };
        
        card.innerHTML = `
            <div class="suggestion-card-image">${recipe.image}</div>
            <div class="suggestion-card-content">
                <h4>${recipe.name}</h4>
                <p>${recipe.category}</p>
                <div class="suggestion-card-meta">
                    <span>⏱️ ${recipe.prepTime}</span>
                    <span class="badge-new">New!</span>
                </div>
            </div>
        `;
        
        cardsContainer.appendChild(card);
    });
}

// Show flavor recipes - triggered from flavor detail screen
function showFlavorRecipes() {
    if (!currentFlavorForRecipes) {
        showNotification('No flavor selected', 'error');
        return;
    }

    const flavor = flavorData[currentFlavorForRecipes];
    if (!flavor || !flavor.mainIngredient) {
        showNotification('No recipes available for this flavor', 'info');
        return;
    }

    const ingredient = flavor.mainIngredient;
    const recipes = recipeDatabase[ingredient] || [];

    if (recipes.length === 0) {
        showNotification('No recipes available yet', 'info');
        return;
    }

    // Update recipe exploration screen
    document.getElementById('recipeHeaderIcon').textContent = flavor.icon;
    document.getElementById('recipeIngredientName').textContent = `${ingredient.charAt(0).toUpperCase() + ingredient.slice(1)} Recipes`;
    document.getElementById('recipeDescription').textContent = `Delicious recipes inspired by ${flavor.name}`;
    document.getElementById('recipeCount').textContent = recipes.length;

    // Clear and populate recipe cards
    const recipeCardsGrid = document.getElementById('recipeCardsGrid');
    recipeCardsGrid.innerHTML = '';

    recipes.forEach(recipe => {
        const recipeCard = document.createElement('div');
        recipeCard.className = 'recipe-card';
        recipeCard.onclick = () => showRecipeDetail(recipe.id, ingredient);
        
        recipeCard.innerHTML = `
            <div class="recipe-card-image">${recipe.image}</div>
            <div class="recipe-card-content">
                <h3>${recipe.name}</h3>
                <p>${recipe.description}</p>
                <div class="recipe-card-meta">
                    <span class="recipe-meta-badge">⏱️ ${recipe.prepTime}</span>
                    <span class="recipe-meta-badge">🍽️ ${recipe.servings}</span>
                    <span class="recipe-meta-badge difficulty-${recipe.difficulty.toLowerCase()}">${recipe.difficulty}</span>
                </div>
                <span class="recipe-category-tag">${recipe.category}</span>
            </div>
        `;
        
        recipeCardsGrid.appendChild(recipeCard);
    });

    // Navigate to recipe exploration screen
    navigateTo('recipe-exploration');
    showNotification(`Found ${recipes.length} ${ingredient} recipes!`, 'success');
}

// Show recipe detail
function showRecipeDetail(recipeId, ingredient) {
    const recipes = recipeDatabase[ingredient] || [];
    const recipe = recipes.find(r => r.id === recipeId);
    
    if (!recipe) {
        showNotification('Recipe not found', 'error');
        return;
    }

    currentRecipeDetail = recipe;
    
    // Track recipe view for personalized suggestions
    trackRecipeView(ingredient, recipeId);

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

    // Update pairing info
    if (currentFlavorForRecipes && flavorData[currentFlavorForRecipes]) {
        document.getElementById('pairingFlavorName').textContent = flavorData[currentFlavorForRecipes].name;
    }

    // Navigate to recipe detail screen
    navigateTo('recipe-detail');
    showNotification(`Viewing: ${recipe.name}`, 'info');
}

// Back to flavor detail from recipe screens
function backToFlavorDetail() {
    if (currentFlavorForRecipes) {
        navigateTo('flavor-detail');
    } else {
        navigateTo('explore');
    }
}

// Save recipe
function saveRecipe() {
    if (!currentRecipeDetail) return;
    
    showNotification(`❤️ ${currentRecipeDetail.name} saved to your favorites!`, 'success');
}

// Share recipe
function shareRecipe() {
    if (!currentRecipeDetail) return;
    
    showNotification(`Sharing ${currentRecipeDetail.name}...`, 'info');
    setTimeout(() => {
        alert(`Share "${currentRecipeDetail.name}"\n\nThis would open your device's share menu to share this recipe with friends!`);
    }, 500);
}

// Share all recipes
function shareRecipes() {
    showNotification('Sharing recipes...', 'info');
    setTimeout(() => {
        alert('This would let you share this recipe collection with friends!');
    }, 500);
}

// Filter recipes by category in All Recipes screen
function filterRecipeCategory(category) {
    const cards = document.querySelectorAll('.full-recipe-card');
    const chips = document.querySelectorAll('.category-chip');
    
    // Update active chip
    chips.forEach(chip => chip.classList.remove('active'));
    event.target.classList.add('active');
    
    // Filter cards
    cards.forEach(card => {
        if (category === 'all') {
            card.style.display = 'block';
        } else {
            if (card.getAttribute('data-category') === category) {
                card.style.display = 'block';
            } else {
                card.style.display = 'none';
            }
        }
    });
}

// Open recipe from All Recipes list
function openRecipeFromList(recipeId) {
    const recipe = allRecipesDatabase[recipeId];
    
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
    showNotification(`Loading ${recipe.name}...`, 'info');
    setTimeout(() => {
        navigateTo('recipe-detail');
    }, 300);
}

// Open recipe search
function openRecipeSearch() {
    showNotification('Recipe search coming soon!', 'info');
}

// ========================================
// HEALTH & NUTRITION TRACKER FUNCTIONS
// ========================================

// Health profile data
let healthProfile = {
    name: '',
    age: 0,
    gender: '',
    weight: 0,
    height: 0,
    activityLevel: 'moderate',
    healthGoal: 'maintain',
    dietary: [],
    allergies: [],
    dailyCalories: 2000,
    consumedCalories: 0
};

// Open health profile modal
function openHealthProfileModal() {
    const modal = document.getElementById('healthProfileModal');
    modal.classList.add('active');
    
    // Populate existing data if available
    if (healthProfile.name) {
        document.getElementById('userName').value = healthProfile.name;
        document.getElementById('userAge').value = healthProfile.age;
        document.getElementById('userGender').value = healthProfile.gender;
        document.getElementById('userWeight').value = healthProfile.weight;
        document.getElementById('userHeight').value = healthProfile.height;
        document.getElementById('activityLevel').value = healthProfile.activityLevel;
        document.getElementById('healthGoal').value = healthProfile.healthGoal;
        
        // Check dietary preferences
        healthProfile.dietary.forEach(pref => {
            const checkbox = document.querySelector(`input[name="dietary"][value="${pref}"]`);
            if (checkbox) checkbox.checked = true;
        });
        
        // Check allergies
        healthProfile.allergies.forEach(allergy => {
            const checkbox = document.querySelector(`input[name="allergies"][value="${allergy}"]`);
            if (checkbox) checkbox.checked = true;
        });
    }
}

// Close health profile modal
function closeHealthProfileModal() {
    const modal = document.getElementById('healthProfileModal');
    modal.classList.remove('active');
}

// Calculate BMI
function calculateBMI(weight, height) {
    const heightInMeters = height / 100;
    return (weight / (heightInMeters * heightInMeters)).toFixed(1);
}

// BMI Calculator Interface Function
function calculateBMIFromInputs() {
    const weight = parseFloat(document.getElementById('bmiWeight').value);
    const height = parseFloat(document.getElementById('bmiHeight').value);
    
    // Validate inputs
    if (!weight || !height || weight <= 0 || height <= 0) {
        showNotification('⚠️ Please enter valid weight and height');
        return;
    }
    
    // Calculate BMI
    const bmi = calculateBMI(weight, height);
    
    // Determine category
    let category, categoryClass, message, recommendations;
    
    if (bmi < 18.5) {
        category = 'Underweight';
        categoryClass = 'underweight';
        message = 'You are below the healthy weight range';
        recommendations = [
            'Increase calorie intake with nutrient-dense foods',
            'Include protein-rich foods in your diet',
            'Consult a healthcare professional for personalized advice',
            'Enjoy ice cream as a healthy calorie supplement in moderation'
        ];
    } else if (bmi >= 18.5 && bmi < 25) {
        category = 'Normal Weight';
        categoryClass = 'normal';
        message = 'You\'re in a healthy weight range!';
        recommendations = [
            'Maintain a balanced diet with proper nutrition',
            'Stay active with regular physical exercise',
            'Keep up your healthy lifestyle',
            'Enjoy ice cream in moderation as part of a balanced diet'
        ];
    } else if (bmi >= 25 && bmi < 30) {
        category = 'Overweight';
        categoryClass = 'overweight';
        message = 'You are above the healthy weight range';
        recommendations = [
            'Focus on portion control and balanced meals',
            'Increase physical activity to at least 150 minutes per week',
            'Choose lower-calorie ice cream options like sorbets',
            'Consult a nutritionist for a personalized plan'
        ];
    } else {
        category = 'Obese';
        categoryClass = 'obese';
        message = 'You are significantly above the healthy weight range';
        recommendations = [
            'Consult a healthcare professional for medical advice',
            'Consider a structured weight management program',
            'Opt for low-fat, low-sugar ice cream alternatives',
            'Focus on gradual, sustainable lifestyle changes'
        ];
    }
    
    // Display results
    document.getElementById('bmiScore').textContent = bmi;
    document.getElementById('bmiCategory').querySelector('.category-badge').textContent = category;
    document.getElementById('bmiCategory').querySelector('.category-badge').className = `category-badge ${categoryClass}`;
    document.getElementById('categoryMessage').textContent = message;
    
    // Update recommendations
    const recommendationList = document.getElementById('bmiRecommendationList');
    recommendationList.innerHTML = recommendations.map(rec => `<li>${rec}</li>`).join('');
    
    // Position indicator on scale
    const indicator = document.getElementById('bmiIndicator');
    let position;
    if (bmi < 18.5) {
        position = (bmi / 18.5) * 25; // 0-25% for underweight
    } else if (bmi < 25) {
        position = 25 + ((bmi - 18.5) / (25 - 18.5)) * 25; // 25-50% for normal
    } else if (bmi < 30) {
        position = 50 + ((bmi - 25) / (30 - 25)) * 25; // 50-75% for overweight
    } else {
        position = 75 + Math.min((bmi - 30) / 10, 1) * 25; // 75-100% for obese
    }
    indicator.style.left = `${Math.min(position, 98)}%`;
    
    // Show result section with animation
    const resultSection = document.getElementById('bmiResultSection');
    resultSection.style.display = 'flex';
    setTimeout(() => {
        resultSection.style.opacity = '1';
    }, 10);
    
    // Scroll to results
    resultSection.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
}

// Calculate daily calorie needs
function calculateDailyCalories(weight, height, age, gender, activityLevel, goal) {
    let bmr;
    
    // Calculate BMR (Basal Metabolic Rate)
    if (gender === 'male') {
        bmr = 10 * weight + 6.25 * height - 5 * age + 5;
    } else {
        bmr = 10 * weight + 6.25 * height - 5 * age - 161;
    }
    
    // Activity multiplier
    const activityMultipliers = {
        'sedentary': 1.2,
        'light': 1.375,
        'moderate': 1.55,
        'active': 1.725,
        'very-active': 1.9
    };
    
    let calories = bmr * activityMultipliers[activityLevel];
    
    // Adjust for goal
    if (goal === 'lose') {
        calories -= 500; // 500 calorie deficit for weight loss
    } else if (goal === 'gain') {
        calories += 500; // 500 calorie surplus for weight gain
    }
    
    return Math.round(calories);
}

// Save health profile
function saveHealthProfile(event) {
    event.preventDefault();
    
    // Get form values
    healthProfile.name = document.getElementById('userName').value;
    healthProfile.age = parseInt(document.getElementById('userAge').value);
    healthProfile.gender = document.getElementById('userGender').value;
    healthProfile.weight = parseFloat(document.getElementById('userWeight').value);
    healthProfile.height = parseFloat(document.getElementById('userHeight').value);
    healthProfile.activityLevel = document.getElementById('activityLevel').value;
    healthProfile.healthGoal = document.getElementById('healthGoal').value;
    
    // Get dietary preferences
    healthProfile.dietary = Array.from(
        document.querySelectorAll('input[name="dietary"]:checked')
    ).map(cb => cb.value);
    
    // Get allergies
    healthProfile.allergies = Array.from(
        document.querySelectorAll('input[name="allergies"]:checked')
    ).map(cb => cb.value);
    
    // Calculate BMI and daily calories
    healthProfile.bmi = calculateBMI(healthProfile.weight, healthProfile.height);
    healthProfile.dailyCalories = calculateDailyCalories(
        healthProfile.weight,
        healthProfile.height,
        healthProfile.age,
        healthProfile.gender,
        healthProfile.activityLevel,
        healthProfile.healthGoal
    );
    
    // Update display
    updateHealthProfileDisplay();
    
    // Update recommendations
    updateRecommendations();
    
    // Close modal
    closeHealthProfileModal();
    
    showNotification('Health profile saved successfully!', 'success');
}

// Update health profile display
function updateHealthProfileDisplay() {
    document.getElementById('profileName').textContent = healthProfile.name || 'Your Name';
    document.getElementById('profileAge').textContent = healthProfile.age ? `Age: ${healthProfile.age}` : 'Age: Not set';
    document.getElementById('profileWeight').textContent = healthProfile.weight ? `${healthProfile.weight} kg` : '-- kg';
    document.getElementById('profileHeight').textContent = healthProfile.height ? `${healthProfile.height} cm` : '-- cm';
    document.getElementById('profileBMI').textContent = healthProfile.bmi || '--';
    document.getElementById('calorieGoal').textContent = `${healthProfile.dailyCalories} kcal`;
    document.getElementById('calorieConsumed').textContent = `${healthProfile.consumedCalories} / ${healthProfile.dailyCalories} kcal consumed`;
    
    // Update calorie progress
    const progress = (healthProfile.consumedCalories / healthProfile.dailyCalories) * 100;
    document.getElementById('calorieProgress').style.width = Math.min(progress, 100) + '%';
    
    // Update dietary tags
    const tagsList = document.getElementById('dietaryTags');
    tagsList.innerHTML = '';
    
    if (healthProfile.dietary.length > 0 || healthProfile.allergies.length > 0) {
        healthProfile.dietary.forEach(pref => {
            const tag = document.createElement('span');
            tag.className = 'health-tag';
            tag.textContent = pref.charAt(0).toUpperCase() + pref.slice(1).replace('-', ' ');
            tagsList.appendChild(tag);
        });
        
        healthProfile.allergies.forEach(allergy => {
            const tag = document.createElement('span');
            tag.className = 'health-tag allergy';
            tag.textContent = `⚠️ ${allergy.charAt(0).toUpperCase() + allergy.slice(1)} Allergy`;
            tagsList.appendChild(tag);
        });
    } else {
        const tag = document.createElement('span');
        tag.className = 'health-tag';
        tag.textContent = 'Click "Edit Profile" to add';
        tagsList.appendChild(tag);
    }
}

// Update recommendations based on health profile
function updateRecommendations() {
    // This would use the health profile to show personalized recommendations
    // For now, we'll keep the default recommendations
    showNotification('Recommendations updated based on your profile!', 'info');
}

// Nutrition comparison
function updateComparison() {
    const flavor1 = document.getElementById('compareSelect1').value;
    const flavor2 = document.getElementById('compareSelect2').value;
    
    if (flavor1 && flavor2) {
        const result = document.getElementById('comparisonResult');
        result.style.display = 'grid';
        
        // Get nutrition data
        const data1 = flavorData[flavor1];
        const data2 = flavorData[flavor2];
        
        // Update flavor 1
        document.getElementById('compareIcon1').textContent = data1.icon;
        document.getElementById('compareName1').textContent = data1.name;
        document.getElementById('compareCal1').textContent = data1.nutrition.calories;
        document.getElementById('compareFat1').textContent = data1.nutrition.fat;
        document.getElementById('compareCarbs1').textContent = data1.nutrition.carbs;
        document.getElementById('compareProtein1').textContent = data1.nutrition.protein;
        document.getElementById('compareSugar1').textContent = extractSugar(data1.nutrition.carbs);
        
        // Update flavor 2
        document.getElementById('compareIcon2').textContent = data2.icon;
        document.getElementById('compareName2').textContent = data2.name;
        document.getElementById('compareCal2').textContent = data2.nutrition.calories;
        document.getElementById('compareFat2').textContent = data2.nutrition.fat;
        document.getElementById('compareCarbs2').textContent = data2.nutrition.carbs;
        document.getElementById('compareProtein2').textContent = data2.nutrition.protein;
        document.getElementById('compareSugar2').textContent = extractSugar(data2.nutrition.carbs);
        
        showNotification('Comparing nutrition values...', 'info');
    }
}

// Extract sugar estimate (simplified - in real app would come from API)
function extractSugar(carbs) {
    const carbValue = parseInt(carbs);
    return `${Math.round(carbValue * 0.6)}g`;
}

// ========================================
// HEALTH CHATBOT FUNCTIONS
// ========================================

// Open chatbot
function openHealthChatbot() {
    const modal = document.getElementById('healthChatbot');
    modal.classList.add('active');
}

// Close chatbot
function closeHealthChatbot() {
    const modal = document.getElementById('healthChatbot');
    modal.classList.remove('active');
}

// Send chat message
function sendChatMessage() {
    const input = document.getElementById('chatInput');
    const message = input.value.trim();
    
    if (message) {
        addChatMessage(message, 'user');
        input.value = '';
        
        // Simulate bot response
        setTimeout(() => {
            const response = generateBotResponse(message);
            addChatMessage(response, 'bot');
        }, 1000);
    }
}

// Send quick message
function sendQuickMessage(message) {
    addChatMessage(message, 'user');
    
    // Hide quick actions after first use
    const quickActions = document.querySelector('.chat-quick-actions');
    if (quickActions) {
        quickActions.style.display = 'none';
    }
    
    // Simulate bot response
    setTimeout(() => {
        const response = generateBotResponse(message);
        addChatMessage(response, 'bot');
    }, 1000);
}

// Handle enter key in chat
function handleChatKeyPress(event) {
    if (event.key === 'Enter') {
        sendChatMessage();
    }
}

// Add chat message to display
function addChatMessage(message, sender) {
    const chatBody = document.getElementById('chatbotMessages');
    
    const messageDiv = document.createElement('div');
    messageDiv.className = `chat-message ${sender}`;
    
    const avatar = document.createElement('div');
    avatar.className = 'chat-avatar';
    avatar.textContent = sender === 'user' ? '👤' : '🤖';
    
    const bubble = document.createElement('div');
    bubble.className = 'chat-bubble';
    bubble.innerHTML = `<p>${message}</p>`;
    
    messageDiv.appendChild(avatar);
    messageDiv.appendChild(bubble);
    
    chatBody.appendChild(messageDiv);
    
    // Scroll to bottom
    chatBody.scrollTop = chatBody.scrollHeight;
}

// Generate bot response (simplified AI simulation)
function generateBotResponse(userMessage) {
    const msg = userMessage.toLowerCase();
    
    // Calorie-related queries
    if (msg.includes('lowest') && msg.includes('calorie')) {
        return 'The lowest calorie option is <strong>Lemon Sorbet</strong> with only 120 kcal per 100g! It\'s dairy-free and perfect for weight management. <strong>Coconut Dream</strong> (195 kcal) and <strong>Strawberry Bliss</strong> (180 kcal) are also great low-calorie choices.';
    }
    
    // Dairy-free queries
    if (msg.includes('dairy') && (msg.includes('free') || msg.includes('allergy'))) {
        return 'We have several dairy-free options:\n• <strong>Lemon Sorbet</strong> - 100% dairy-free, only 120 kcal\n• <strong>Coconut Dream</strong> - Made with coconut milk\n• <strong>Mango Tango</strong> - Coconut milk based\n\nAll are perfect for lactose intolerance or vegan diets!';
    }
    
    // Sugar content queries
    if (msg.includes('sugar')) {
        if (msg.includes('chocolate')) {
            return '<strong>Chocolate Delight</strong> contains approximately 14g of sugar per 100g serving. If you\'re looking for lower sugar options, try <strong>Lemon Sorbet</strong> (18g natural fruit sugar) or ask about our sugar-free alternatives!';

// ========================================
// COMMUNITY - CREATE POST
// ========================================

let selectedPostEmoji = '';

function openCreatePostModal() {
    const modal = document.getElementById('createPostModal');
    modal.style.display = 'flex';
    document.body.style.overflow = 'hidden';
    
    // Reset form
    document.getElementById('createPostForm').reset();
    selectedPostEmoji = '';
    document.getElementById('emojiPreview').textContent = '';
    document.getElementById('postCharCount').textContent = '0';
    
    // Remove selected states
    document.querySelectorAll('.emoji-btn').forEach(btn => btn.classList.remove('selected'));
    document.querySelectorAll('.hashtag-btn').forEach(btn => btn.classList.remove('added'));
}

function closeCreatePostModal() {
    const modal = document.getElementById('createPostModal');
    modal.style.display = 'none';
    document.body.style.overflow = 'auto';
}

function selectEmoji(emoji) {
    selectedPostEmoji = emoji;
    document.getElementById('emojiPreview').textContent = emoji;
    
    // Toggle selected state
    document.querySelectorAll('.emoji-btn').forEach(btn => {
        if (btn.textContent.trim() === emoji) {
            btn.classList.add('selected');
        } else {
            btn.classList.remove('selected');
        }
    });
}

function addHashtag(hashtag) {
    const textarea = document.getElementById('postContent');
    const currentText = textarea.value;
    
    // Check if hashtag already exists
    if (currentText.includes(hashtag)) {
        // Remove hashtag
        textarea.value = currentText.replace(hashtag + ' ', '').replace(hashtag, '');
        // Toggle button state
        event.target.classList.remove('added');
    } else {
        // Add hashtag at the end
        textarea.value = currentText + (currentText ? ' ' : '') + hashtag;
        // Toggle button state
        event.target.classList.add('added');
    }
    
    // Update character count
    updateCharCount();
}

function updateCharCount() {
    const textarea = document.getElementById('postContent');
    const charCount = document.getElementById('postCharCount');
    const currentLength = textarea.value.length;
    
    charCount.textContent = currentLength;
    
    if (currentLength > 500) {
        charCount.classList.add('over-limit');
    } else {
        charCount.classList.remove('over-limit');
    }
}

function submitPost(event) {
    event.preventDefault();
    
    const content = document.getElementById('postContent').value.trim();
    const category = document.getElementById('postCategory').value;
    
    // Validate character limit
    if (content.length > 500) {
        alert('Post exceeds 500 characters. Please shorten your message.');
        return;
    }
    
    if (!content) {
        alert('Please enter some content for your post.');
        return;
    }
    
    // Create post object
    const newPost = {
        id: Date.now(),
        author: 'You',
        avatar: '👤',
        content: content,
        emoji: selectedPostEmoji,
        category: category,
        timestamp: 'Just now',
        likes: 0,
        comments: 0
    };
    
    // Add post to feed
    addPostToFeed(newPost);
    
    // Close modal and show success
    closeCreatePostModal();
    showNotification('Post shared successfully! 🎉');
}

function addPostToFeed(postData) {
    const feedContainer = document.querySelector('.posts-feed');
    
    // Create category badge
    const categoryBadges = {
        review: '🍦 Flavor Review',
        challenge: '🎯 Challenge Completed',
        recipe: '🍴 Recipe',
        photo: '📸 Photo',
        question: '❓ Question',
        general: '💬 General'
    };
    
    const categoryBadge = categoryBadges[postData.category] || '💬 General';
    
    // Create post HTML
    const postHTML = `
        <div class="post-card" data-post-id="${postData.id}">
            <div class="post-header">
                <div class="post-user-info">
                    <div class="post-user-avatar">${postData.avatar}</div>
                    <div>
                        <div class="post-user-name">${postData.author}</div>
                        <div class="post-timestamp">${postData.timestamp}</div>
                    </div>
                </div>
                <span class="post-category-badge">${categoryBadge}</span>
            </div>
            <div class="post-content">
                ${postData.emoji ? `<div class="post-emoji">${postData.emoji}</div>` : ''}
                <p>${postData.content}</p>
            </div>
            <div class="post-actions">
                <button class="post-action-btn" onclick="likePost(${postData.id})">
                    <span class="action-icon">❤️</span>
                    <span class="action-count">${postData.likes}</span>
                </button>
                <button class="post-action-btn">
                    <span class="action-icon">💬</span>
                    <span class="action-count">${postData.comments}</span>
                </button>
                <button class="post-action-btn">
                    <span class="action-icon">🔗</span>
                    Share
                </button>
            </div>
        </div>
    `;
    
    // Insert at the beginning of the feed
    feedContainer.insertAdjacentHTML('afterbegin', postHTML);
    
    // Add animation
    const newPostElement = feedContainer.querySelector('.post-card');
    newPostElement.style.animation = 'slideInUp 0.5s ease-out';
}

function likePost(postId) {
    const postCard = document.querySelector(`[data-post-id="${postId}"]`);
    const likeBtn = postCard.querySelector('.post-action-btn');
    const likeCount = likeBtn.querySelector('.action-count');
    
    let currentCount = parseInt(likeCount.textContent);
    currentCount++;
    likeCount.textContent = currentCount;
    
    // Add animation effect
    likeBtn.style.transform = 'scale(1.2)';
    setTimeout(() => {
        likeBtn.style.transform = 'scale(1)';
    }, 200);
}

// Character counter for textarea
document.addEventListener('DOMContentLoaded', function() {
    const postContent = document.getElementById('postContent');
    if (postContent) {
        postContent.addEventListener('input', updateCharCount);
    }
});

        }
        return 'Sugar content varies by flavor. Generally:\n• Fruit-based: 16-20g (natural fruit sugars)\n• Cream-based: 14-18g\n• Sorbet: 18-22g\n\nWhich specific flavor would you like to know about?';
    }
    
    // Weight loss queries
    if (msg.includes('weight') && msg.includes('loss')) {
        return 'For weight loss, I recommend:\n1. <strong>Lemon Sorbet</strong> - Only 120 kcal, fat-free\n2. <strong>Strawberry Bliss</strong> - 180 kcal, natural ingredients\n3. Portion control - stick to 100g servings\n4. Enjoy after exercise for maximum satisfaction!\n\nRemember: moderation is key! 🎯';
    }
    
    // Allergen queries
    if (msg.includes('allergen') || msg.includes('allergy')) {
        return 'I can help with allergen information! Our flavors may contain:\n🥛 Dairy - most cream-based flavors\n🥜 Nuts - Pistachio, some with nut toppings\n🥚 Eggs - traditional ice cream recipes\n🌾 Gluten - cookies & cream, cake pieces\n\nWhich allergen are you concerned about?';
    }
    
    // Vegan queries
    if (msg.includes('vegan')) {
        return 'Our vegan-friendly options include:\n• <strong>Lemon Sorbet</strong> - 100% plant-based\n• <strong>Coconut Dream</strong> - Coconut milk base\n• <strong>Mango Tango</strong> - Made with coconut milk\n\nAll are free from dairy, eggs, and animal products! 🌱';
    }
    
    // Nutrition info
    if (msg.includes('nutrition') || msg.includes('calories') || msg.includes('fat')) {
        return 'I can provide detailed nutrition information for any flavor! Each serving (100g) typically contains:\n• Calories: 120-250 kcal\n• Fat: 0-15g\n• Carbs: 22-30g\n• Protein: 2-6g\n\nWhich flavor would you like to know about?';
    }
    
    // Healthy choices
    if (msg.includes('healthy') || msg.includes('health')) {
        return 'Our healthiest options depend on your goals:\n\n<strong>Low Calorie:</strong> Lemon Sorbet (120 kcal)\n<strong>High Protein:</strong> Pistachio Dream (6g protein)\n<strong>Natural Ingredients:</strong> Strawberry Bliss, Mango Tango\n<strong>Dairy-Free:</strong> All sorbets and coconut-based\n\nWould you like me to recommend based on your health profile?';
    }
    
    // Default response
    return 'I\'m here to help with nutrition and health questions! You can ask me about:\n• Calorie and nutrition information\n• Allergens and dietary restrictions\n• Recommendations for your health goals\n• Ingredients and nutritional values\n• Best options for specific diets\n\nWhat would you like to know?';
}

// ========================================
// ENGAGE TABS SYSTEM
// ========================================

function switchEngageTab(tabName) {
    // Hide all tab contents
    document.querySelectorAll('.engage-tab-content').forEach(content => {
        content.classList.remove('active');
    });
    
    // Remove active class from all tabs
    document.querySelectorAll('.engage-tab').forEach(tab => {
        tab.classList.remove('active');
    });
    
    // Show selected tab content
    const contentMap = {
        'challenges': 'engageChallenges',
        'leaderboard': 'engageLeaderboard',
        'community': 'engageCommunity',
        'games': 'engageGames'
    };
    
    const contentId = contentMap[tabName];
    if (contentId) {
        document.getElementById(contentId).classList.add('active');
    }
    
    // Add active class to clicked tab
    event.target.closest('.engage-tab').classList.add('active');
}

// Leaderboard period switching
function switchLeaderboardPeriod(period) {
    // Remove active class from all period buttons
    document.querySelectorAll('.period-btn').forEach(btn => {
        btn.classList.remove('active');
    });
    
    // Add active class to clicked button
    event.target.classList.add('active');
    
    // In a real app, this would fetch data for the selected period
    // For now, show notification
    const periodNames = {
        'weekly': 'Weekly',
        'monthly': 'Monthly',
        'alltime': 'All-Time'
    };
    
    showNotification(`📊 Showing ${periodNames[period]} Rankings`);
    
    // Simulate data update with animation
    const leaderboardList = document.querySelector('.leaderboard-list');
    if (leaderboardList) {
        leaderboardList.style.opacity = '0.5';
        setTimeout(() => {
            leaderboardList.style.opacity = '1';
        }, 300);
    }
}

// ========================================
// GAMING FUNCTIONS
// ========================================

function playGame(gameId) {
    const gameNames = {
        'halloween-hunt': 'Halloween Ice Cream Hunt',
        'ice-cream-maker': 'Ice Cream Maker',
        'flavor-match': 'Flavor Match 3',
        'ice-cream-runner': 'Ice Cream Runner',
        'trivia-champion': 'Savoy Trivia',
        'scratch-card': 'Scratch & Reveal',
        'memory-game': 'Memory Match',
        'puzzle': 'Ice Cream Puzzle'
    };
    
    const gameName = gameNames[gameId] || 'Game';
    
    // Show game launch message
    showNotification(`🎮 Launching ${gameName}...`);
    
    // In a real app, this would launch the actual game
    // For now, simulate a game session with reward
    setTimeout(() => {
        const rewards = [
            { coins: 50, message: '🎉 You won 50 IceCoins!' },
            { coins: 100, message: '🏆 Amazing! You won 100 IceCoins!' },
            { coins: 25, message: '⭐ Great job! You earned 25 IceCoins!' },
            { coins: 75, message: '🔥 Excellent! You gained 75 IceCoins!' }
        ];
        
        const reward = rewards[Math.floor(Math.random() * rewards.length)];
        showGameReward(gameName, reward);
    }, 2000);
}

function showGameReward(gameName, reward) {
    // Create reward notification
    const rewardModal = document.createElement('div');
    rewardModal.className = 'game-reward-modal';
    rewardModal.innerHTML = `
        <div class="game-reward-content">
            <div class="reward-icon">🎮</div>
            <h3>${gameName}</h3>
            <p class="reward-message">${reward.message}</p>
            <div class="reward-coins">
                <span class="coin-icon">💎</span>
                <span class="coin-amount">+${reward.coins}</span>
            </div>
            <button class="btn-primary" onclick="closeGameReward()">Collect Reward</button>
        </div>
    `;
    
    document.body.appendChild(rewardModal);
    
    // Add to gaming stats
    updateGamingStats(reward.coins);
    
    // Auto-close after 5 seconds
    setTimeout(() => {
        if (document.body.contains(rewardModal)) {
            closeGameReward();
        }
    }, 5000);
}

function closeGameReward() {
    const rewardModal = document.querySelector('.game-reward-modal');
    if (rewardModal) {
        rewardModal.style.animation = 'fadeOut 0.3s ease-out';
        setTimeout(() => {
            rewardModal.remove();
        }, 300);
    }
}

function updateGamingStats(coinsEarned) {
    // Update IceCoins Won stat
    const coinsStatElement = document.querySelector('.gaming-stats-card .stat-item:first-child .stat-value');
    if (coinsStatElement) {
        const currentCoins = parseInt(coinsStatElement.textContent.replace(',', ''));
        const newCoins = currentCoins + coinsEarned;
        coinsStatElement.textContent = newCoins.toLocaleString();
        
        // Animate the update
        coinsStatElement.style.transform = 'scale(1.2)';
        coinsStatElement.style.color = 'var(--color-success)';
        setTimeout(() => {
            coinsStatElement.style.transform = 'scale(1)';
            coinsStatElement.style.color = 'var(--color-primary)';
        }, 500);
    }
}

// ========================================
// DIGITAL ICE CREAM PASSPORT
// ========================================

function openPassportModal() {
    const modal = document.getElementById('passportModal');
    modal.style.display = 'flex';
    document.body.style.overflow = 'hidden';
    
    // Reset to flavors tab
    switchPassportTab('flavors');
}

function closePassportModal() {
    const modal = document.getElementById('passportModal');
    modal.style.display = 'none';
    document.body.style.overflow = 'auto';
}

function switchPassportTab(tabName) {
    // Hide all tab contents
    document.querySelectorAll('.passport-tab-content').forEach(content => {
        content.classList.remove('active');
    });
    
    // Remove active class from all tabs
    document.querySelectorAll('.passport-tab').forEach(tab => {
        tab.classList.remove('active');
    });
    
    // Show selected tab content
    const contentMap = {
        'flavors': 'passportFlavors',
        'badges': 'passportBadges',
        'journey': 'passportJourney'
    };
    
    const contentId = contentMap[tabName];
    if (contentId) {
        document.getElementById(contentId).classList.add('active');
    }
    
    // Add active class to clicked tab
    if (event && event.target) {
        event.target.classList.add('active');
    } else {
        // If called programmatically, activate first tab
        document.querySelector('.passport-tab').classList.add('active');
    }
}

function sharePassport() {
    const message = `🍦 Check out my Ice Cream Passport!\n\n` +
                   `✅ 8 Flavors Tried\n` +
                   `🏆 5 Badges Earned\n` +
                   `⭐ 27% Collection Complete\n\n` +
                   `Join me in exploring Savoy's delicious flavors! #SavoyConnect #IceCreamPassport`;
    
    // Try to use Web Share API if available
    if (navigator.share) {
        navigator.share({
            title: 'My Ice Cream Passport',
            text: message
        }).then(() => {
            showNotification('Passport shared successfully! 🎉');
        }).catch(() => {
            // Fallback to copy to clipboard
            copyToClipboard(message);
        });
    } else {
        // Fallback to copy to clipboard
        copyToClipboard(message);
    }
}

function copyToClipboard(text) {
    if (navigator.clipboard) {
        navigator.clipboard.writeText(text).then(() => {
            showNotification('Passport details copied to clipboard! 📋');
        }).catch(() => {
            showNotification('Unable to share passport');
        });
    } else {
        // Older fallback method
        const textArea = document.createElement('textarea');
        textArea.value = text;
        textArea.style.position = 'fixed';
        textArea.style.left = '-999999px';
        document.body.appendChild(textArea);
        textArea.select();
        try {
            document.execCommand('copy');
            showNotification('Passport details copied to clipboard! 📋');
        } catch (err) {
            showNotification('Unable to share passport');
        }
        document.body.removeChild(textArea);
    }
}

// ========================================
// ORDER SYSTEM
// ========================================

let orderCart = {};
let currentOrderType = 'pieces'; // 'pieces' or 'liters'
const PRICE_PER_PIECE = 50;
const PIECES_PER_BOX = 24;
const PRICE_PER_LITER = 800;
const DELIVERY_FEE = 200;
const FREE_DELIVERY_THRESHOLD = 5000;

function openOrderModal() {
    const modal = document.getElementById('orderModal');
    modal.style.display = 'flex';
    document.body.style.overflow = 'hidden';
    
    // Reset cart and order type
    orderCart = {};
    currentOrderType = 'pieces';
    updateOrderSummary();
    
    // Reset form
    document.getElementById('orderForm').reset();
    
    // Set minimum date to tomorrow
    const tomorrow = new Date();
    tomorrow.setDate(tomorrow.getDate() + 1);
    document.getElementById('deliveryDate').min = tomorrow.toISOString().split('T')[0];
}

function closeOrderModal() {
    const modal = document.getElementById('orderModal');
    modal.style.display = 'none';
    document.body.style.overflow = 'auto';
}

// Delivery Method Switching
let currentDeliveryMethod = 'delivery'; // 'delivery' or 'pickup'

function switchDeliveryMethod(method) {
    currentDeliveryMethod = method;
    
    // Update tabs
    const deliveryTab = document.getElementById('deliveryTab');
    const pickupTab = document.getElementById('pickupTab');
    
    if (method === 'delivery') {
        deliveryTab.classList.add('active');
        pickupTab.classList.remove('active');
        
        // Show delivery form, hide pickup form
        document.getElementById('orderForm').style.display = 'block';
        document.getElementById('pickupForm').style.display = 'none';
        
        // Update summary
        document.getElementById('deliveryFeeLabel').textContent = 'Delivery Fee:';
        document.getElementById('deliveryFeeRow').style.display = 'flex';
        document.getElementById('pickupSavingsRow').style.display = 'none';
        document.getElementById('summaryMethodBadge').innerHTML = '🏍️ Home Delivery';
        
    } else {
        pickupTab.classList.add('active');
        deliveryTab.classList.remove('active');
        
        // Show pickup form, hide delivery form
        document.getElementById('orderForm').style.display = 'none';
        document.getElementById('pickupForm').style.display = 'block';
        
        // Update summary - no delivery fee for pickup
        document.getElementById('deliveryFeeRow').style.display = 'none';
        document.getElementById('pickupSavingsRow').style.display = 'flex';
        document.getElementById('summaryMethodBadge').innerHTML = '🏪 Store Pickup';
        
        // Set minimum date to tomorrow for pickup
        const tomorrow = new Date();
        tomorrow.setDate(tomorrow.getDate() + 1);
        document.getElementById('pickupDate').min = tomorrow.toISOString().split('T')[0];
    }
    
    // Recalculate order summary
    updateOrderSummary();
}

// Pickup Store Selection Handler
document.addEventListener('DOMContentLoaded', function() {
    const pickupStoreSelect = document.getElementById('pickupStore');
    if (pickupStoreSelect) {
        pickupStoreSelect.addEventListener('change', function() {
            const storeValue = this.value;
            const storeInfo = document.getElementById('pickupStoreInfo');
            
            if (storeValue) {
                // Show store info
                storeInfo.style.display = 'block';
                
                // Store data (in production, this would come from API)
                const storeData = {
                    'depot-main': {
                        icon: '🏭',
                        name: 'Savoy Main Depot',
                        address: '123 Main Street, Dhaka 1205',
                        distance: '0.5 km',
                        hours: '9:00 AM - 9:00 PM',
                        phone: '+880 1712-345678'
                    },
                    'retailer-dhanmondi': {
                        icon: '🏪',
                        name: 'Sweet Corner Retailer',
                        address: '45 Dhanmondi Road, Dhaka',
                        distance: '1.2 km',
                        hours: '10:00 AM - 10:00 PM',
                        phone: '+880 1812-345679'
                    },
                    'retailer-gulshan': {
                        icon: '🏪',
                        name: 'Ice Cream Paradise',
                        address: '78 Gulshan Avenue, Dhaka',
                        distance: '2.3 km',
                        hours: '10:00 AM - 11:00 PM',
                        phone: '+880 1912-345680'
                    },
                    'retailer-banani': {
                        icon: '🏪',
                        name: 'Frozen Treats',
                        address: '12 Banani Road, Dhaka',
                        distance: '3.1 km',
                        hours: '11:00 AM - 10:00 PM',
                        phone: '+880 1612-345681'
                    },
                    'depot-uttara': {
                        icon: '🏭',
                        name: 'Savoy Uttara Depot',
                        address: '56 Uttara Sector 7, Dhaka',
                        distance: '5.8 km',
                        hours: '9:00 AM - 9:00 PM',
                        phone: '+880 1512-345682'
                    },
                    'freezer-mirpur': {
                        icon: '❄️',
                        name: 'Savoy Freezer - Mirpur',
                        address: '34 Mirpur Road, Dhaka',
                        distance: '4.2 km',
                        hours: '8:00 AM - 8:00 PM',
                        phone: '+880 1412-345683'
                    }
                };
                
                const store = storeData[storeValue];
                if (store) {
                    document.getElementById('selectedStoreIcon').textContent = store.icon;
                    document.getElementById('selectedStoreName').textContent = store.name;
                    document.getElementById('selectedStoreAddress').textContent = store.address;
                    document.getElementById('selectedStoreDistance').textContent = store.distance;
                    document.getElementById('selectedStoreHours').textContent = store.hours;
                    document.getElementById('selectedStorePhone').textContent = store.phone;
                }
            } else {
                storeInfo.style.display = 'none';
            }
        });
    }
});

function viewStoreOnMap() {
    showNotification('📍 Opening store location on map...');
    // In production, this would open the map view with store location
    navigateTo('store-locator');
    closeOrderModal();
}

// Order History Modal Functions
function openOrderHistoryModal() {
    const modal = document.getElementById('orderHistoryModal');
    modal.style.display = 'flex';
    document.body.style.overflow = 'hidden';
}

function closeOrderHistoryModal() {
    const modal = document.getElementById('orderHistoryModal');
    modal.style.display = 'none';
    document.body.style.overflow = 'auto';
}

function filterOrders(status) {
    const tabs = document.querySelectorAll('.order-filter-tab');
    const orders = document.querySelectorAll('.order-history-card');
    const emptyState = document.getElementById('emptyOrdersState');
    
    // Update active tab
    tabs.forEach(tab => tab.classList.remove('active'));
    event.target.classList.add('active');
    
    // Filter orders
    let visibleCount = 0;
    orders.forEach(order => {
        const orderStatus = order.getAttribute('data-status');
        if (status === 'all' || orderStatus === status) {
            order.style.display = 'block';
            visibleCount++;
        } else {
            order.style.display = 'none';
        }
    });
    
    // Show/hide empty state
    if (visibleCount === 0) {
        emptyState.style.display = 'flex';
    } else {
        emptyState.style.display = 'none';
    }
}

function viewOrderDetail(orderId) {
    alert(`Viewing details for order ${orderId}`);
    // You can expand this to show a detailed order view
}

function reorderItems(orderId) {
    alert(`Reordering items from ${orderId}`);
    closeOrderHistoryModal();
    openOrderModal();
    // You can expand this to auto-fill the order form with previous order items
}

// Customer Care Modal Functions
function openCustomerCareModal() {
    const modal = document.getElementById('customerCareModal');
    modal.style.display = 'flex';
    document.body.style.overflow = 'hidden';
}

function closeCustomerCareModal() {
    const modal = document.getElementById('customerCareModal');
    modal.style.display = 'none';
    document.body.style.overflow = 'auto';
}

function initiateCall() {
    window.location.href = 'tel:+8801234567890';
}

function initiateWhatsApp() {
    window.open('https://wa.me/8801234567890', '_blank');
}

function initiateEmail() {
    window.location.href = 'mailto:support@savoy.com';
}

function openLiveChat() {
    alert('Live chat feature coming soon! For now, please use WhatsApp or call us.');
}

function showHelpTopic(topic) {
    alert(`Opening help for: ${topic}`);
}

function toggleFAQ(element) {
    const faqItem = element.parentElement;
    const answer = faqItem.querySelector('.faq-answer');
    const icon = element.querySelector('.faq-icon');
    
    // Close all other FAQs
    document.querySelectorAll('.faq-item').forEach(item => {
        if (item !== faqItem) {
            item.classList.remove('active');
            item.querySelector('.faq-icon').textContent = '+';
        }
    });
    
    // Toggle current FAQ
    faqItem.classList.toggle('active');
    icon.textContent = faqItem.classList.contains('active') ? '−' : '+';
}

function openSocial(platform) {
    const urls = {
        facebook: 'https://facebook.com/savoyicecream',
        instagram: 'https://instagram.com/savoyicecream',
        twitter: 'https://twitter.com/savoyicecream',
        youtube: 'https://youtube.com/savoyicecream'
    };
    window.open(urls[platform], '_blank');
}

// Terms & Conditions Modal Functions
function openTermsModal() {
    const modal = document.getElementById('termsModal');
    modal.style.display = 'flex';
    document.body.style.overflow = 'hidden';
}

function closeTermsModal() {
    const modal = document.getElementById('termsModal');
    modal.style.display = 'none';
    document.body.style.overflow = 'auto';
}

// About Modal Functions
function openAboutModal() {
    const modal = document.getElementById('aboutModal');
    modal.style.display = 'flex';
    document.body.style.overflow = 'hidden';
}

function closeAboutModal() {
    const modal = document.getElementById('aboutModal');
    modal.style.display = 'none';
    document.body.style.overflow = 'auto';
}

// Payment Methods Modal Functions
function openPaymentMethodsModal() {
    const modal = document.getElementById('paymentMethodsModal');
    modal.style.display = 'flex';
    document.body.style.overflow = 'hidden';
}

function closePaymentMethodsModal() {
    const modal = document.getElementById('paymentMethodsModal');
    modal.style.display = 'none';
    document.body.style.overflow = 'auto';
}

function openAddCardForm() {
    const modal = document.getElementById('addCardModal');
    modal.style.display = 'flex';
    document.body.style.overflow = 'hidden';
}

function closeAddCardForm() {
    const modal = document.getElementById('addCardModal');
    modal.style.display = 'none';
    document.body.style.overflow = 'auto';
    // Reset form
    document.getElementById('addCardForm').reset();
}

function saveNewCard(event) {
    event.preventDefault();
    alert('Card added successfully!');
    closeAddCardForm();
    // In a real app, this would save the card details securely
}

function editCard(cardId) {
    alert(`Editing card: ${cardId}`);
    // Open edit form with card details
}

function deleteCard(cardId) {
    if (confirm('Are you sure you want to delete this card?')) {
        alert(`Card ${cardId} deleted`);
        // Remove card from list
    }
}

function setDefaultCard(cardId) {
    alert(`Card ${cardId} set as default`);
    // Update UI to show new default card
}

function togglePaymentMethod(method) {
    console.log(`Payment method ${method} toggled`);
}

function connectMobileBanking(provider) {
    alert(`Opening ${provider} connection...`);
    // Open provider-specific connection flow
}

// Flavor Review Functions
function openFlavorReviewModal() {
    const modal = document.getElementById('flavorReviewModal');
    modal.style.display = 'flex';
    document.body.style.overflow = 'hidden';
}

function closeFlavorReviewModal() {
    const modal = document.getElementById('flavorReviewModal');
    modal.style.display = 'none';
    document.body.style.overflow = 'auto';
    // Reset form
    document.getElementById('flavorReviewForm').reset();
    // Reset star rating
    const stars = document.querySelectorAll('#flavorStarRatingInput .star-input');
    stars.forEach(star => star.classList.remove('selected'));
}

function setFlavorRating(rating) {
    document.getElementById('flavorRatingValue').value = rating;
    const stars = document.querySelectorAll('#flavorStarRatingInput .star-input');
    stars.forEach((star, index) => {
        if (index < rating) {
            star.classList.add('selected');
        } else {
            star.classList.remove('selected');
        }
    });
}

function submitFlavorReview(event) {
    event.preventDefault();
    const rating = document.getElementById('flavorRatingValue').value;
    const title = document.getElementById('flavorReviewTitle').value;
    const review = document.getElementById('flavorReviewText').value;
    
    if (!rating) {
        alert('Please select a rating');
        return;
    }
    
    alert(`Review submitted!\nRating: ${rating} stars\nTitle: ${title}\nReview: ${review}`);
    closeFlavorReviewModal();
    
    // In a real app, this would send the review to a server
}

function filterFlavorReviews(filter) {
    const reviews = document.querySelectorAll('.flavor-review-card');
    const filterBtns = document.querySelectorAll('.review-filters .filter-chip');
    
    // Update active filter button
    filterBtns.forEach(btn => btn.classList.remove('active'));
    event.target.classList.add('active');
    
    // Filter reviews
    reviews.forEach(review => {
        const rating = review.getAttribute('data-rating');
        
        if (filter === 'all') {
            review.style.display = 'block';
        } else if (filter === 'with-photos') {
            // Show reviews with photos (implement photo feature)
            review.style.display = 'none';
        } else if (filter === 'recent') {
            // Show recent reviews (first 3)
            review.style.display = 'block';
        } else if (rating === filter) {
            review.style.display = 'block';
        } else {
            review.style.display = 'none';
        }
    });
}

function likeReview(reviewId) {
    const btn = event.currentTarget;
    const countSpan = btn.querySelector('.action-count');
    let count = parseInt(countSpan.textContent);
    
    if (btn.classList.contains('liked')) {
        btn.classList.remove('liked');
        count--;
    } else {
        btn.classList.add('liked');
        count++;
    }
    
    countSpan.textContent = count;
}

function reportReview(reviewId) {
    if (confirm('Are you sure you want to report this review?')) {
        alert(`Review ${reviewId} reported. Thank you for helping us maintain quality.`);
    }
}

function toggleReviewMenu(btn) {
    alert('Review menu options: Edit, Delete, Share');
}

function loadMoreFlavorReviews() {
    alert('Loading more reviews...');
    // In a real app, this would load more reviews from the server
}

// Character counter for flavor review
document.addEventListener('DOMContentLoaded', function() {
    const flavorReviewText = document.getElementById('flavorReviewText');
    if (flavorReviewText) {
        flavorReviewText.addEventListener('input', function() {
            const charCount = document.getElementById('flavorCharCount');
            if (charCount) {
                charCount.textContent = this.value.length;
            }
        });
    }
});

// Daily Spin-the-Wheel feature removed

function switchOrderType(type) {
    // Reset cart when switching types
    orderCart = {};
    currentOrderType = type;
    
    // Reset all quantity inputs
    const inputs = document.querySelectorAll('.qty-input');
    inputs.forEach(input => input.value = 0);
    
    // Update tab active state
    document.getElementById('piecesTab').classList.toggle('active', type === 'pieces');
    document.getElementById('litersTab').classList.toggle('active', type === 'liters');
    
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
    if (type === 'pieces') {
        document.getElementById('summaryUnitLabel').textContent = 'Total Boxes:';
        document.getElementById('summaryQuantityLabel').textContent = 'Total Pieces:';
    } else {
        document.getElementById('summaryUnitLabel').textContent = 'Total Orders:';
        document.getElementById('summaryQuantityLabel').textContent = 'Total Liters:';
    }
    
    updateOrderSummary();
}

function increaseQuantity(flavorId) {
    const input = document.getElementById(`qty-${flavorId}`);
    const currentValue = parseInt(input.value) || 0;
    input.value = currentValue + 1;
    
    orderCart[flavorId] = input.value;
    updateOrderSummary();
}

function decreaseQuantity(flavorId) {
    const input = document.getElementById(`qty-${flavorId}`);
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

function updateOrderSummary() {
    let totalQuantity = 0;
    let subtotal = 0;
    
    Object.values(orderCart).forEach(qty => {
        totalQuantity += parseInt(qty) || 0;
    });
    
    if (currentOrderType === 'pieces') {
        // Calculate for pieces/boxes
        const totalBoxes = Math.ceil(totalQuantity / PIECES_PER_BOX);
        subtotal = totalQuantity * PRICE_PER_PIECE;
        
        document.getElementById('totalBoxes').textContent = totalBoxes;
        document.getElementById('totalPieces').textContent = totalQuantity;
    } else {
        // Calculate for liters
        subtotal = totalQuantity * PRICE_PER_LITER;
        
        document.getElementById('totalBoxes').textContent = Object.keys(orderCart).length; // Number of different flavors
        document.getElementById('totalPieces').textContent = totalQuantity; // Total liters
    }
    
    // Calculate delivery fee based on method
    let deliveryFee = 0;
    let totalAmount = subtotal;
    
    if (currentDeliveryMethod === 'delivery') {
        // Home delivery - check if free delivery threshold met
        deliveryFee = subtotal >= FREE_DELIVERY_THRESHOLD ? 0 : DELIVERY_FEE;
        totalAmount = subtotal + deliveryFee;
        
        // Update delivery fee display
        document.getElementById('summaryDelivery').textContent = subtotal >= FREE_DELIVERY_THRESHOLD ? '৳0' : `৳${DELIVERY_FEE}`;
        
        // Show/hide free delivery message
        const freeDeliveryRow = document.getElementById('freeDeliveryRow');
        if (subtotal >= FREE_DELIVERY_THRESHOLD) {
            freeDeliveryRow.style.display = 'flex';
        } else {
            freeDeliveryRow.style.display = 'none';
        }
    } else {
        // Store pickup - no delivery fee
        totalAmount = subtotal;
    }
    
    // Update summary header
    document.getElementById('totalAmount').textContent = `৳${totalAmount.toLocaleString()}`;
    
    // Update final summary
    document.getElementById('summarySubtotal').textContent = `৳${subtotal.toLocaleString()}`;
    document.getElementById('summaryTotal').textContent = `৳${totalAmount.toLocaleString()}`;
    
    // Enable/disable place order button based on order type
    const placeOrderBtn = document.getElementById('placeOrderBtn');
    if (currentOrderType === 'pieces') {
        // Minimum 24 pieces (1 box)
        if (totalQuantity >= PIECES_PER_BOX) {
            placeOrderBtn.disabled = false;
        } else {
            placeOrderBtn.disabled = true;
        }
    } else {
        // Minimum 1 liter
        if (totalQuantity >= 1) {
            placeOrderBtn.disabled = false;
        } else {
            placeOrderBtn.disabled = true;
        }
    }
}

function placeOrder() {
    // Validate appropriate form based on delivery method
    let form;
    if (currentDeliveryMethod === 'delivery') {
        form = document.getElementById('orderForm');
    } else {
        form = document.getElementById('pickupForm');
    }
    
    if (!form.checkValidity()) {
        form.reportValidity();
        return;
    }
    
    // Get order details
    const totalQuantity = Object.values(orderCart).reduce((sum, qty) => sum + parseInt(qty), 0);
    
    // Validate minimum order based on type
    if (currentOrderType === 'pieces' && totalQuantity < PIECES_PER_BOX) {
        showNotification('⚠️ Minimum order is 24 pieces (1 box)', 'error');
        return;
    } else if (currentOrderType === 'liters' && totalQuantity < 1) {
        showNotification('⚠️ Minimum order is 1 liter', 'error');
        return;
    }
    
    // Get form data based on delivery method
    let deliveryInfo = '';
    let contactName, contactPhone, orderDate, timeSlot, notes;
    
    if (currentDeliveryMethod === 'delivery') {
        const deliveryAddress = document.getElementById('deliveryAddress').value;
        contactName = document.getElementById('contactName').value;
        contactPhone = document.getElementById('contactPhone').value;
        orderDate = document.getElementById('deliveryDate').value;
        timeSlot = document.getElementById('deliveryTime').value;
        notes = document.getElementById('orderNotes').value;
        
        deliveryInfo = `📍 Delivery To:
${contactName}
${deliveryAddress}
${contactPhone}

📅 Delivery: ${orderDate} (${timeSlot})`;
    } else {
        const pickupStore = document.getElementById('pickupStore');
        const selectedStoreText = pickupStore.options[pickupStore.selectedIndex].text;
        contactName = document.getElementById('pickupName').value;
        contactPhone = document.getElementById('pickupPhone').value;
        orderDate = document.getElementById('pickupDate').value;
        timeSlot = document.getElementById('pickupTime').value;
        notes = document.getElementById('pickupNotes').value;
        
        deliveryInfo = `🏪 Pickup From:
${selectedStoreText}

👤 Pickup By:
${contactName}
${contactPhone}

📅 Pickup: ${orderDate} (${timeSlot})

ℹ️ Remember to bring ID for verification`;
    }
    
    // Calculate totals
    let subtotal = 0;
    let orderTypeLabel = '';
    
    if (currentOrderType === 'pieces') {
        const totalBoxes = Math.ceil(totalQuantity / PIECES_PER_BOX);
        subtotal = totalQuantity * PRICE_PER_PIECE;
        orderTypeLabel = `${totalBoxes} box(es), ${totalQuantity} pieces`;
    } else {
        subtotal = totalQuantity * PRICE_PER_LITER;
        orderTypeLabel = `${totalQuantity} liter(s)`;
    }
    
    // Calculate total based on delivery method
    let deliveryFee = 0;
    let feeInfo = '';
    if (currentDeliveryMethod === 'delivery') {
        deliveryFee = subtotal >= FREE_DELIVERY_THRESHOLD ? 0 : DELIVERY_FEE;
        if (deliveryFee === 0) {
            feeInfo = `\n🎉 Free Delivery Applied!`;
        } else {
            feeInfo = `\n🏍️ Delivery Fee: ৳${deliveryFee}`;
        }
    } else {
        feeInfo = `\n💰 No Delivery Fee (Store Pickup)`;
    }
    
    const totalAmount = subtotal + deliveryFee;
    
    // Create order summary
    let flavorsSummary = '';
    Object.keys(orderCart).forEach(flavorId => {
        const qty = orderCart[flavorId];
        const flavorName = flavorId.split('-').map(word => 
            word.charAt(0).toUpperCase() + word.slice(1)
        ).join(' ');
        const unit = currentOrderType === 'pieces' ? 'pieces' : 'liter(s)';
        flavorsSummary += `${flavorName}: ${qty} ${unit}\n`;
    });
    
    // Show confirmation
    const methodIcon = currentDeliveryMethod === 'delivery' ? '🏍️' : '🏪';
    const methodText = currentDeliveryMethod === 'delivery' ? 'Home Delivery' : 'Store Pickup';
    
    const orderSummary = `
🎉 Order Placed Successfully!

${methodIcon} ${methodText}

📦 Order Details:
${flavorsSummary}
Total: ${orderTypeLabel}

💰 Subtotal: ৳${subtotal.toLocaleString()}${feeInfo}
💳 Total Amount: ৳${totalAmount.toLocaleString()}

📍 Delivery To:
${contactName}
${deliveryAddress}
${contactPhone}

📅 Delivery: ${deliveryDate} (${deliveryTime})

${orderNotes ? `📝 Notes: ${orderNotes}` : ''}

We'll contact you shortly to confirm your order!
    `;
    
    // In a real app, this would send to backend
    console.log('Order placed:', {
        orderType: currentOrderType,
        cart: orderCart,
        deliveryAddress,
        contactName,
        contactPhone,
        deliveryDate,
        deliveryTime,
        orderNotes,
        orderTypeLabel,
        totalQuantity,
        subtotal,
        deliveryFee,
        totalAmount
    });
    
    // Show success message
    alert(orderSummary);
    
    // Close modal and reset
    closeOrderModal();
    showNotification('✅ Order placed successfully!');
    
    // Reset all quantities
    document.querySelectorAll('.qty-input').forEach(input => {
        input.value = 0;
    });
}

// ========================================
// REFERRAL REWARD SYSTEM
// ========================================

let referralData = {
    code: 'SAVOY2025',
    referralsCount: 2,
    targetCount: 4,
    coinsEarned: 150,
    pendingInvites: 1,
    referrals: [
        { name: 'Rafiq Ahmed', status: 'joined', days: 3, coins: 50 },
        { name: 'Nusrat Khan', status: 'joined', days: 5, coins: 100 },
        { name: 'Invited via WhatsApp', status: 'pending', hours: 2 }
    ]
};

function openReferralModal() {
    const modal = document.getElementById('referralModal');
    modal.style.display = 'flex';
    document.body.style.overflow = 'hidden';
    
    updateReferralProgress();
}

function closeReferralModal() {
    const modal = document.getElementById('referralModal');
    modal.style.display = 'none';
    document.body.style.overflow = 'auto';
}

function updateReferralProgress() {
    const progress = (referralData.referralsCount / referralData.targetCount) * 100;
    
    // Update progress bar
    document.getElementById('rewardProgressFill').style.width = `${progress}%`;
    
    // Update count
    document.getElementById('referralCount').textContent = referralData.referralsCount;
    
    // Update message
    const remaining = referralData.targetCount - referralData.referralsCount;
    let message = '';
    
    if (remaining === 0) {
        message = '🎉 Congratulations! You earned a FREE ice cream box!';
    } else if (remaining === 1) {
        message = '🎯 Just 1 more friend to get your FREE ice cream box!';
    } else {
        message = `🎯 ${remaining} more friends to get your FREE ice cream box!`;
    }
    
    document.getElementById('rewardMessage').textContent = message;
}

function copyReferralCode() {
    const code = referralData.code;
    
    // Copy to clipboard
    navigator.clipboard.writeText(code).then(() => {
        // Change button text temporarily
        const btn = event.target.closest('.btn-copy');
        const icon = btn.querySelector('#copyIcon');
        const originalHTML = btn.innerHTML;
        
        icon.textContent = '✅';
        btn.innerHTML = btn.innerHTML.replace('Copy', 'Copied!');
        
        showNotification('✅ Referral code copied!');
        
        setTimeout(() => {
            icon.textContent = '📋';
            btn.innerHTML = originalHTML;
        }, 2000);
    }).catch(err => {
        showNotification('⚠️ Failed to copy code');
    });
}

function copyReferralLink() {
    const link = `https://savoyconnect.app/join?ref=${referralData.code}`;
    
    navigator.clipboard.writeText(link).then(() => {
        showNotification('✅ Referral link copied!');
    }).catch(err => {
        showNotification('⚠️ Failed to copy link');
    });
}

function shareViaWhatsApp() {
    const message = `🍦 Join me on SavoyConnect! 
    
Get premium ice cream delivered to your door. Use my referral code: ${referralData.code}

Download: https://savoyconnect.app/join?ref=${referralData.code}

Let's enjoy delicious ice cream together! 🎉`;
    
    const url = `https://wa.me/?text=${encodeURIComponent(message)}`;
    window.open(url, '_blank');
    
    // Track invite (in real app, this would update backend)
    showNotification('📤 Opening WhatsApp...');
}

function shareViaFacebook() {
    const url = `https://savoyconnect.app/join?ref=${referralData.code}`;
    const shareUrl = `https://www.facebook.com/sharer/sharer.php?u=${encodeURIComponent(url)}`;
    
    window.open(shareUrl, '_blank', 'width=600,height=400');
    showNotification('📤 Opening Facebook...');
}

function shareViaMessenger() {
    const url = `https://savoyconnect.app/join?ref=${referralData.code}`;
    const shareUrl = `fb-messenger://share/?link=${encodeURIComponent(url)}`;
    
    window.open(shareUrl, '_blank');
    showNotification('📤 Opening Messenger...');
}

function shareViaEmail() {
    const subject = 'Join me on SavoyConnect! 🍦';
    const body = `Hi!

I've been using SavoyConnect to order premium ice cream and it's amazing! 

Join me using my referral code: ${referralData.code}

Download the app: https://savoyconnect.app/join?ref=${referralData.code}

Let's enjoy delicious ice cream together!

Cheers! 🎉`;
    
    const mailtoUrl = `mailto:?subject=${encodeURIComponent(subject)}&body=${encodeURIComponent(body)}`;
    window.location.href = mailtoUrl;
    
    showNotification('📤 Opening email...');
}

function shareMore() {
    const shareData = {
        title: 'Join SavoyConnect',
        text: `Join me on SavoyConnect! Use my code: ${referralData.code}`,
        url: `https://savoyconnect.app/join?ref=${referralData.code}`
    };
    
    if (navigator.share) {
        navigator.share(shareData)
            .then(() => showNotification('✅ Shared successfully!'))
            .catch(() => showNotification('⚠️ Share cancelled'));
    } else {
        copyReferralLink();
    }
}

// ========================================
// SUSTAINABILITY IMPACT TRACKER
// ========================================

function openEcoImpactModal() {
    const modal = document.getElementById('ecoImpactModal');
    modal.style.display = 'flex';
    document.body.style.overflow = 'hidden';
}

function closeEcoImpactModal() {
    const modal = document.getElementById('ecoImpactModal');
    modal.style.display = 'none';
    document.body.style.overflow = 'auto';
}

function showImpactDetail(type) {
    // Open the full modal to show detailed info
    openEcoImpactModal();
    
    // Optionally scroll to the specific metric section
    setTimeout(() => {
        const metricCards = document.querySelectorAll('.detailed-metric-card');
        const typeMap = {
            'co2': 0,
            'plastic': 1,
            'trees': 2,
            'water': 3
        };
        
        const index = typeMap[type];
        if (index !== undefined && metricCards[index]) {
            metricCards[index].scrollIntoView({ behavior: 'smooth', block: 'center' });
            
            // Highlight the card temporarily
            metricCards[index].style.border = '3px solid var(--color-success)';
            metricCards[index].style.transform = 'scale(1.02)';
            
            setTimeout(() => {
                metricCards[index].style.border = '2px solid var(--color-neutral-300)';
                metricCards[index].style.transform = 'scale(1)';
            }, 2000);
        }
    }, 300);
}

// ========================================
// LEGACY MODAL
// ========================================

function openLegacyModal() {
    const modal = document.getElementById('legacyModal');
    modal.style.display = 'flex';
    document.body.style.overflow = 'hidden';
}

function closeLegacyModal() {
    const modal = document.getElementById('legacyModal');
    modal.style.display = 'none';
    document.body.style.overflow = 'auto';
}

// ========================================
// CUSTOM BOX FEATURE
// ========================================

let customBox = {
    flavors: [],
    maxFlavors: 6,
    minFlavors: 4,
    recipientName: '',
    giftMessage: '',
    boxDesign: 'classic',
    selectedStore: 'depot-1',
    pickupDate: '',
    pickupTime: ''
};

function openCustomBoxModal() {
    const modal = document.getElementById('customBoxModal');
    modal.style.display = 'flex';
    document.body.style.overflow = 'hidden';
    
    // Reset custom box
    customBox.flavors = [];
    updateBoxPreview();
    
    // Set minimum pickup date to tomorrow
    const tomorrow = new Date();
    tomorrow.setDate(tomorrow.getDate() + 1);
    document.getElementById('pickupDate').min = tomorrow.toISOString().split('T')[0];
    
    // Add character count listeners
    document.getElementById('recipientName').addEventListener('input', function(e) {
        document.getElementById('nameCharCount').textContent = e.target.value.length;
    });
    
    document.getElementById('giftMessage').addEventListener('input', function(e) {
        document.getElementById('messageCharCount').textContent = e.target.value.length;
    });
}

function closeCustomBoxModal() {
    const modal = document.getElementById('customBoxModal');
    modal.style.display = 'none';
    document.body.style.overflow = 'auto';
}

function addFlavorToBox(flavorId, icon, name) {
    // Check if already added
    const existingIndex = customBox.flavors.findIndex(f => f.id === flavorId);
    
    if (existingIndex !== -1) {
        // Remove if already added
        customBox.flavors.splice(existingIndex, 1);
        showNotification('🗑️ Flavor removed');
    } else {
        // Check if box is full
        if (customBox.flavors.length >= customBox.maxFlavors) {
            showNotification('⚠️ Maximum 6 flavors allowed');
            return;
        }
        
        // Add flavor
        customBox.flavors.push({ id: flavorId, icon: icon, name: name });
        showNotification(`✅ ${name} added!`);
    }
    
    updateBoxPreview();
}

function removeFlavorFromBox(index) {
    const removed = customBox.flavors.splice(index, 1);
    showNotification(`🗑️ ${removed[0].name} removed`);
    updateBoxPreview();
}

function updateBoxPreview() {
    const slots = document.querySelectorAll('.preview-slot');
    
    // Update each slot
    slots.forEach((slot, index) => {
        const flavor = customBox.flavors[index];
        
        if (flavor) {
            // Fill slot
            slot.classList.remove('empty');
            slot.classList.add('filled');
            slot.querySelector('.slot-icon').textContent = flavor.icon;
            
            // Add remove button if not already there
            if (!slot.querySelector('.slot-remove')) {
                const removeBtn = document.createElement('span');
                removeBtn.className = 'slot-remove';
                removeBtn.textContent = '×';
                removeBtn.onclick = (e) => {
                    e.stopPropagation();
                    removeFlavorFromBox(index);
                };
                slot.appendChild(removeBtn);
            }
        } else {
            // Empty slot
            slot.classList.remove('filled');
            slot.classList.add('empty');
            slot.querySelector('.slot-icon').textContent = '+';
            
            // Remove remove button
            const removeBtn = slot.querySelector('.slot-remove');
            if (removeBtn) {
                removeBtn.remove();
            }
        }
    });
    
    // Update count
    document.getElementById('selectedCount').textContent = customBox.flavors.length;
    
    // Update flavor cards selection state
    document.querySelectorAll('.custom-flavor-card').forEach(card => {
        const flavorId = card.getAttribute('onclick').match(/'([^']+)'/)[1];
        const isSelected = customBox.flavors.some(f => f.id === flavorId);
        
        if (isSelected) {
            card.classList.add('selected');
        } else {
            card.classList.remove('selected');
        }
        
        // Disable if max reached and not selected
        if (customBox.flavors.length >= customBox.maxFlavors && !isSelected) {
            card.classList.add('disabled');
        } else {
            card.classList.remove('disabled');
        }
    });
    
    // Enable/disable pre-order button
    const preOrderBtn = document.getElementById('preOrderBtn');
    if (customBox.flavors.length >= customBox.minFlavors) {
        preOrderBtn.disabled = false;
    } else {
        preOrderBtn.disabled = true;
    }
}

function selectBoxDesign(design) {
    customBox.boxDesign = design;
    
    // Update UI
    document.querySelectorAll('.design-option').forEach(option => {
        if (option.getAttribute('data-design') === design) {
            option.classList.add('active');
        } else {
            option.classList.remove('active');
        }
    });
}

function selectStore(storeId) {
    customBox.selectedStore = storeId;
    
    // Update UI
    document.querySelectorAll('.store-option').forEach(option => {
        if (option.getAttribute('data-store') === storeId) {
            option.classList.add('active');
        } else {
            option.classList.remove('active');
        }
    });
}

function preOrderCustomBox() {
    // Validate flavors
    if (customBox.flavors.length < customBox.minFlavors) {
        showNotification(`⚠️ Please select at least ${customBox.minFlavors} flavors`);
        return;
    }
    
    // Get personalization details
    customBox.recipientName = document.getElementById('recipientName').value;
    customBox.giftMessage = document.getElementById('giftMessage').value;
    customBox.pickupDate = document.getElementById('pickupDate').value;
    customBox.pickupTime = document.getElementById('pickupTime').value;
    
    // Validate pickup details
    if (!customBox.pickupDate || !customBox.pickupTime) {
        showNotification('⚠️ Please select pickup date and time');
        return;
    }
    
    // Get store name
    const storeNames = {
        'depot-1': 'Savoy Main Depot',
        'store-1': 'Sweet Corner Retailer',
        'store-2': 'Ice Dream Parlor'
    };
    
    const storeName = storeNames[customBox.selectedStore];
    
    // Create order summary
    let flavorsList = customBox.flavors.map(f => f.name).join('\n• ');
    
    const orderSummary = `
🎨 Custom Box Pre-Order Confirmed!

📦 Your Box:
• ${flavorsList}

${customBox.recipientName ? `🎁 For: ${customBox.recipientName}` : ''}
${customBox.giftMessage ? `💌 Message: "${customBox.giftMessage}"` : ''}

📍 Pickup From: ${storeName}
📅 Date: ${customBox.pickupDate}
⏰ Time: ${customBox.pickupTime}

💰 Total: ৳800

We'll have your personalized box ready for pickup!
    `;
    
    // Log to console (in real app, send to backend)
    console.log('Custom Box Order:', customBox);
    
    // Show confirmation
    alert(orderSummary);
    
    // Close modal and show notification
    closeCustomBoxModal();
    showNotification('✅ Custom box pre-ordered successfully!');
    
    // Reset form
    document.getElementById('recipientName').value = '';
    document.getElementById('giftMessage').value = '';
    document.getElementById('pickupDate').value = '';
    document.getElementById('pickupTime').value = '';
    document.getElementById('nameCharCount').textContent = '0';
    document.getElementById('messageCharCount').textContent = '0';
}

// Export functions for testing
if (typeof module !== 'undefined' && module.exports) {
    module.exports = {
        navigateTo,
        updateBottomNav,
        redeemReward,
        showNotification,
        showStoreDetail,
        filterStores,
        toggleMapView,
        useMyLocation,
        getDirections,
        callStore,
        shareStore,
        openReviewModal,
        closeReviewModal,
        setRating,
        submitReview,
        filterReviews,
        likeReview,
        loadMoreReviews,
        switchExploreCategory,
        showFlavorDetail,
        searchFlavors,
        shareFlavor,
        switchCampaignTab,
        showCampaignDetail,
        filterCampaigns,
        openHealthProfileModal,
        closeHealthProfileModal,
        saveHealthProfile,
        calculateBMIFromInputs,
        updateComparison,
        openHealthChatbot,
        closeHealthChatbot,
        sendChatMessage,
        sendQuickMessage,
        handleChatKeyPress,
        openCreatePostModal,
        closeCreatePostModal,
        submitPost,
        selectEmoji,
        addHashtag,
        switchEngageTab,
        playGame,
        closeGameReward,
        openPassportModal,
        closePassportModal,
        switchPassportTab,
        sharePassport,
        openOrderModal,
        closeOrderModal,
        switchOrderType,
        increaseQuantity,
        decreaseQuantity,
        placeOrder,
        openReferralModal,
        closeReferralModal,
        copyReferralCode,
        copyReferralLink,
        shareViaWhatsApp,
        shareViaFacebook,
        shareViaMessenger,
        shareViaEmail,
        shareMore,
        openEcoImpactModal,
        closeEcoImpactModal,
        showImpactDetail,
        openLegacyModal,
        closeLegacyModal,
        openCustomBoxModal,
        closeCustomBoxModal,
        addFlavorToBox,
        selectBoxDesign,
        selectStore,
        preOrderCustomBox
    };
}

// ========================================
// FEEDBACK FUNCTIONS
// ========================================

let selectedFeedbackType = 'suggestion';
let feedbackRating = 0;

// Open feedback modal
function openFeedbackModal() {
    const modal = document.getElementById('feedbackModal');
    if (modal) {
        modal.classList.add('active');
        document.body.style.overflow = 'hidden';
        
        // Reset form
        resetFeedbackForm();
    }
}

// Close feedback modal
function closeFeedbackModal() {
    const modal = document.getElementById('feedbackModal');
    if (modal) {
        modal.classList.remove('active');
        document.body.style.overflow = 'auto';
    }
}

// Select feedback type
function selectFeedbackType(type) {
    selectedFeedbackType = type;
    
    // Update button states
    const buttons = document.querySelectorAll('.feedback-type-btn');
    buttons.forEach(btn => {
        btn.classList.remove('active');
        if (btn.getAttribute('data-type') === type) {
            btn.classList.add('active');
        }
    });
}

// Set feedback rating
function setFeedbackRating(rating) {
    feedbackRating = rating;
    
    // Update star display
    const stars = document.querySelectorAll('.feedback-star');
    stars.forEach((star, index) => {
        if (index < rating) {
            star.classList.add('active');
            star.textContent = '⭐';
        } else {
            star.classList.remove('active');
            star.textContent = '⭐';
        }
    });
    
    // Update rating text
    const ratingTexts = ['', 'Poor', 'Fair', 'Good', 'Very Good', 'Excellent'];
    document.getElementById('feedbackRatingText').textContent = ratingTexts[rating] || 'Tap to rate';
}

// Character counter for feedback message
document.addEventListener('DOMContentLoaded', () => {
    const feedbackMessage = document.getElementById('feedbackMessage');
    if (feedbackMessage) {
        feedbackMessage.addEventListener('input', (e) => {
            const count = e.target.value.length;
            const counter = document.getElementById('feedbackCharCount');
            if (counter) {
                counter.textContent = count;
                if (count > 500) {
                    counter.style.color = 'var(--color-error)';
                } else {
                    counter.style.color = 'var(--color-neutral-600)';
                }
            }
        });
    }
});

// Submit feedback
function submitFeedback() {
    const subject = document.getElementById('feedbackSubject').value.trim();
    const message = document.getElementById('feedbackMessage').value.trim();
    const email = document.getElementById('feedbackEmail').value.trim();
    const followUp = document.getElementById('feedbackFollowUp').checked;
    
    // Validation
    if (!subject) {
        showNotification('Please enter a subject', 'error');
        return;
    }
    
    if (!message) {
        showNotification('Please enter your feedback', 'error');
        return;
    }
    
    if (message.length > 500) {
        showNotification('Message is too long (max 500 characters)', 'error');
        return;
    }
    
    if (feedbackRating === 0) {
        showNotification('Please rate your experience', 'error');
        return;
    }
    
    // Simulate submission
    showNotification('Submitting feedback...', 'info');
    
    setTimeout(() => {
        closeFeedbackModal();
        showNotification('✅ Thank you for your feedback!', 'success');
        
        // Show a follow-up message
        setTimeout(() => {
            alert(`Thank you for sharing your feedback!\n\nType: ${selectedFeedbackType}\nRating: ${feedbackRating} stars\nSubject: ${subject}\n\nWe truly appreciate your input and will review it carefully. ${followUp ? 'We\'ll follow up with you soon!' : ''}`);
        }, 1000);
        
        // Reset form for next use
        resetFeedbackForm();
    }, 1500);
}

// Reset feedback form
function resetFeedbackForm() {
    // Reset type selection
    selectedFeedbackType = 'suggestion';
    const buttons = document.querySelectorAll('.feedback-type-btn');
    buttons.forEach(btn => {
        btn.classList.remove('active');
        if (btn.getAttribute('data-type') === 'suggestion') {
            btn.classList.add('active');
        }
    });
    
    // Reset rating
    feedbackRating = 0;
    const stars = document.querySelectorAll('.feedback-star');
    stars.forEach(star => {
        star.classList.remove('active');
        star.textContent = '⭐';
    });
    document.getElementById('feedbackRatingText').textContent = 'Tap to rate';
    
    // Reset form fields
    document.getElementById('feedbackSubject').value = '';
    document.getElementById('feedbackMessage').value = '';
    document.getElementById('feedbackCharCount').textContent = '0';
    document.getElementById('feedbackFollowUp').checked = true;
}

// Make functions globally accessible for inline onclick handlers
window.navigateTo = navigateTo;
window.updateBottomNav = updateBottomNav;
window.redeemReward = redeemReward;
window.showNotification = showNotification;
window.showStoreDetail = showStoreDetail;
window.filterStores = filterStores;
window.toggleMapView = toggleMapView;
window.useMyLocation = useMyLocation;
window.getDirections = getDirections;
window.callStore = callStore;
window.shareStore = shareStore;
window.openReviewModal = openReviewModal;
window.closeReviewModal = closeReviewModal;
window.setRating = setRating;
window.submitReview = submitReview;
window.filterReviews = filterReviews;
window.likeReview = likeReview;
window.loadMoreReviews = loadMoreReviews;
window.switchExploreCategory = switchExploreCategory;
window.showFlavorDetail = showFlavorDetail;
window.searchFlavors = searchFlavors;
window.shareFlavor = shareFlavor;
window.switchCampaignTab = switchCampaignTab;
window.showCampaignDetail = showCampaignDetail;
window.filterCampaigns = filterCampaigns;
window.openHealthProfileModal = openHealthProfileModal;
window.closeHealthProfileModal = closeHealthProfileModal;
window.saveHealthProfile = saveHealthProfile;
window.calculateBMI = calculateBMIFromInputs;
window.updateComparison = updateComparison;
window.openHealthChatbot = openHealthChatbot;
window.closeHealthChatbot = closeHealthChatbot;
window.sendChatMessage = sendChatMessage;
window.sendQuickMessage = sendQuickMessage;
window.handleChatKeyPress = handleChatKeyPress;
window.openCreatePostModal = openCreatePostModal;
window.closeCreatePostModal = closeCreatePostModal;
window.submitPost = submitPost;
window.selectEmoji = selectEmoji;
window.addHashtag = addHashtag;
window.switchEngageTab = switchEngageTab;
window.switchLeaderboardPeriod = switchLeaderboardPeriod;
window.playGame = playGame;
window.closeGameReward = closeGameReward;
window.openPassportModal = openPassportModal;
window.closePassportModal = closePassportModal;
window.switchPassportTab = switchPassportTab;
window.sharePassport = sharePassport;
window.openOrderModal = openOrderModal;
window.closeOrderModal = closeOrderModal;
window.switchOrderType = switchOrderType;
window.increaseQuantity = increaseQuantity;
window.decreaseQuantity = decreaseQuantity;
window.placeOrder = placeOrder;
window.openReferralModal = openReferralModal;
window.closeReferralModal = closeReferralModal;
window.copyReferralCode = copyReferralCode;
window.copyReferralLink = copyReferralLink;
window.shareViaWhatsApp = shareViaWhatsApp;
window.shareViaFacebook = shareViaFacebook;
window.shareViaMessenger = shareViaMessenger;
window.shareViaEmail = shareViaEmail;
window.shareMore = shareMore;
window.openEcoImpactModal = openEcoImpactModal;
window.closeEcoImpactModal = closeEcoImpactModal;
window.showImpactDetail = showImpactDetail;
window.openLegacyModal = openLegacyModal;
window.closeLegacyModal = closeLegacyModal;
window.openCustomBoxModal = openCustomBoxModal;
window.closeCustomBoxModal = closeCustomBoxModal;
window.addFlavorToBox = addFlavorToBox;
window.selectBoxDesign = selectBoxDesign;
window.selectStore = selectStore;
window.preOrderCustomBox = preOrderCustomBox;
// Recipe functions
window.showFlavorRecipes = showFlavorRecipes;
window.showRecipeDetail = showRecipeDetail;
window.backToFlavorDetail = backToFlavorDetail;
window.saveRecipe = saveRecipe;
window.shareRecipe = shareRecipe;
window.shareRecipes = shareRecipes;
window.filterRecipeCategory = filterRecipeCategory;
window.openRecipeFromList = openRecipeFromList;
window.openRecipeSearch = openRecipeSearch;
// Feedback functions
window.openFeedbackModal = openFeedbackModal;
window.closeFeedbackModal = closeFeedbackModal;
window.selectFeedbackType = selectFeedbackType;
window.setFeedbackRating = setFeedbackRating;
window.submitFeedback = submitFeedback;
