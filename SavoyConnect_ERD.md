# SavoyConnect Database - Entity Relationship Diagram

## Complete ER Diagram

```mermaid
erDiagram
    %% SECTION 1: USER MANAGEMENT
    users ||--o{ user_profiles : "has"
    users ||--o{ user_preferences : "has"
    users ||--o{ user_addresses : "has"
    users ||--o{ sessions : "creates"
    users ||--o{ password_resets : "requests"
    
    %% SECTION 2: PRODUCT CATALOG
    products ||--o{ product_nutrition : "has"
    products ||--o{ product_allergens : "contains"
    products ||--o{ product_images : "has"
    products }o--|| product_categories : "belongs_to"
    product_categories ||--o{ product_categories : "parent_of"
    
    %% SECTION 3: ORDER MANAGEMENT
    users ||--o{ orders : "places"
    orders ||--o{ order_items : "contains"
    orders ||--o{ order_status_history : "tracks"
    orders ||--o{ payments : "paid_by"
    products ||--o{ order_items : "included_in"
    user_addresses ||--o{ orders : "delivered_to"
    
    %% SECTION 4: PAYMENT & LOCATIONS
    users ||--o{ payment_methods : "has"
    payment_methods ||--o{ payments : "used_for"
    locations ||--o{ orders : "fulfills"
    locations ||--o{ location_inventory : "stocks"
    products ||--o{ location_inventory : "stocked_at"
    
    %% SECTION 5: DELIVERY
    locations ||--o{ delivery_personnel : "home_base"
    locations ||--o{ delivery_personnel : "current_location"
    delivery_personnel ||--o{ deliveries : "delivers"
    orders ||--|| deliveries : "shipped_as"
    locations ||--o{ deliveries : "picked_from"
    
    %% SECTION 6: LOYALTY SYSTEM
    users ||--|| icecoins_wallet : "owns"
    icecoins_wallet ||--o{ icecoins_transactions : "records"
    users ||--o{ icecoins_transactions : "performs"
    users ||--o{ reward_redemptions : "redeems"
    orders ||--o{ reward_redemptions : "uses"
    
    %% SECTION 7: CHALLENGES
    challenges ||--o{ user_challenges : "enrolled_by"
    users ||--o{ user_challenges : "participates"
    user_challenges ||--o{ challenge_progress_events : "tracks"
    
    %% SECTION 8: REVIEWS & RATINGS
    users ||--o{ reviews : "writes"
    products ||--o{ reviews : "reviewed_in"
    orders ||--o{ reviews : "verified_by"
    reviews ||--o{ review_responses : "has"
    reviews ||--o{ review_votes : "voted_on"
    users ||--o{ review_votes : "votes"
    
    %% SECTION 9: REFERRALS
    users ||--o{ referrals : "refers_as_referrer"
    users ||--o{ referrals : "referred_as"
    orders ||--o{ referrals : "first_order"
    
    %% SECTION 10: PROMOTIONS
    promotions ||--o{ promotion_usage : "used_in"
    users ||--o{ promotion_usage : "uses"
    orders ||--o{ promotion_usage : "applies_to"
    
    %% SECTION 11: NOTIFICATIONS
    users ||--o{ notifications : "receives"
    
    %% SECTION 12: RECIPES
    users ||--o{ recipes : "creates"
    recipes ||--o{ recipe_products : "uses"
    products ||--o{ recipe_products : "ingredient_in"
    recipes ||--o{ recipe_tries : "tried_by"
    users ||--o{ recipe_tries : "tries"
    recipes ||--o{ recipe_saves : "saved_by"
    users ||--o{ recipe_saves : "saves"
    recipe_collections ||--o{ recipe_saves : "contains"
    users ||--o{ recipe_collections : "creates"
    
    %% SECTION 13: SOCIAL FEATURES
    users ||--o{ user_follows : "follows_as_follower"
    users ||--o{ user_follows : "followed_as_following"
    users ||--o{ user_posts : "creates"
    recipes ||--o{ user_posts : "shared_in"
    products ||--o{ user_posts : "featured_in"
    reviews ||--o{ user_posts : "shared_in"
    user_posts ||--o{ post_likes : "liked_by"
    users ||--o{ post_likes : "likes"
    user_posts ||--o{ post_comments : "has"
    users ||--o{ post_comments : "writes"
    post_comments ||--o{ post_comments : "replies_to"
    
    %% SECTION 14: DIGITAL PASSPORT
    products ||--o{ digital_passports : "tracked_by"
    digital_passports ||--o{ passport_scans : "scanned_by"
    users ||--o{ passport_scans : "scans"
    products ||--o{ sustainability_reports : "reports"
    
    %% SECTION 15: CUSTOM BOXES
    users ||--o{ custom_boxes : "creates"
    custom_boxes ||--o{ custom_box_items : "contains"
    products ||--o{ custom_box_items : "included_in"
    
    %% SECTION 16: STOCK NOTIFICATIONS
    users ||--o{ stock_notifications : "subscribes"
    products ||--o{ stock_notifications : "notifies"
    
    %% SECTION 17: HEALTH TRACKING
    users ||--o{ health_goals : "sets"
    health_goals ||--o{ health_goal_logs : "tracks"
    users ||--o{ health_goal_logs : "logs"
    
    %% SECTION 18: GAMIFICATION
    badges ||--o{ user_badges : "earned_by"
    users ||--o{ user_badges : "earns"
    leaderboards ||--o{ leaderboard_entries : "contains"
    users ||--o{ leaderboard_entries : "ranks_in"
    
    %% SECTION 19: TRUST & VERIFICATION
    users ||--o{ user_verifications : "verified_by"
    users ||--|| trust_scores : "has"
    
    %% SECTION 20: FEEDBACK
    users ||--o{ feedback : "submits"
    orders ||--o{ feedback : "relates_to"
    products ||--o{ feedback : "about"
    feedback ||--o{ feedback_responses : "has"
    
    %% SECTION 21: ANALYTICS
    users ||--o{ page_views : "views"
    sessions ||--o{ page_views : "tracks"
    users ||--o{ user_activity_logs : "logs"
    users ||--o{ search_queries : "searches"
    sessions ||--o{ search_queries : "tracks"
    orders ||--o{ search_queries : "results_in"
    search_queries ||--o{ search_results : "returns"
    users ||--o{ click_tracking : "clicks"
    sessions ||--o{ click_tracking : "tracks"
    users ||--o{ cart_analytics : "tracked"
    sessions ||--o{ cart_analytics : "tracks"
    products ||--o{ cart_analytics : "involved"
    orders ||--o{ cart_analytics : "completed"
    users ||--o{ conversion_tracking : "converts"
    sessions ||--o{ conversion_tracking : "tracks"
    orders ||--o{ conversion_tracking : "results_in"
    
    %% SECTION 22: ADMINISTRATION
    admin_roles ||--o{ admin_users : "assigned_to"
    admin_users ||--o{ admin_activity_logs : "performs"
    
    %% SECTION 23: API & SYSTEM
    users ||--o{ api_keys : "owns"
    admin_users ||--o{ api_keys : "manages"
    api_keys ||--o{ api_logs : "logs"
    users ||--o{ webhooks : "creates"
    admin_users ||--o{ webhooks : "manages"
    webhooks ||--o{ webhook_logs : "triggers"
    
    %% SECTION 24: FILE MANAGEMENT
    users ||--o{ file_uploads : "uploads"
    admin_users ||--o{ file_uploads : "manages"
    
    %% SECTION 25: ERROR TRACKING
    users ||--o{ error_logs : "encounters"
    admin_users ||--o{ error_logs : "encounters"

    users {
        bigint id PK
        varchar email UK
        varchar phone UK
        varchar password_hash
        varchar first_name
        varchar last_name
        date date_of_birth
        enum gender
        varchar profile_picture_url
        boolean email_verified
        boolean phone_verified
        enum status
        timestamp last_login_at
        timestamp created_at
        timestamp updated_at
        timestamp deleted_at
    }

    user_profiles {
        bigint id PK
        bigint user_id FK
        text bio
        varchar occupation
        varchar company
        varchar website
        varchar location
        json social_links
        json interests
        json dietary_preferences
        varchar language_preference
        timestamp created_at
        timestamp updated_at
    }

    user_preferences {
        bigint id PK
        bigint user_id FK
        boolean email_notifications
        boolean sms_notifications
        boolean push_notifications
        boolean marketing_emails
        enum theme
        varchar currency
        varchar timezone
        timestamp created_at
        timestamp updated_at
    }

    user_addresses {
        bigint id PK
        bigint user_id FK
        enum address_type
        varchar label
        varchar recipient_name
        varchar street_address
        varchar city
        varchar country
        decimal latitude
        decimal longitude
        boolean is_default
        timestamp created_at
        timestamp updated_at
        timestamp deleted_at
    }

    products {
        bigint id PK
        varchar product_code UK
        varchar barcode
        varchar name
        varchar slug UK
        text description
        bigint category_id FK
        varchar brand
        varchar unit
        decimal unit_value
        decimal price
        decimal compare_price
        varchar currency
        decimal tax_percentage
        int stock_quantity
        boolean is_available
        enum status
        boolean featured
        json tags
        timestamp created_at
        timestamp updated_at
        timestamp deleted_at
    }

    product_categories {
        bigint id PK
        bigint parent_id FK
        varchar name
        varchar slug UK
        text description
        varchar icon_url
        int display_order
        int level
        boolean is_active
        boolean is_featured
        int product_count
        timestamp created_at
        timestamp updated_at
    }

    product_nutrition {
        bigint id PK
        bigint product_id FK
        varchar serving_size
        decimal calories
        decimal total_fat
        decimal protein
        decimal total_carbohydrates
        text ingredients
        json nutritional_claims
        decimal health_score
        timestamp created_at
        timestamp updated_at
    }

    product_allergens {
        bigint id PK
        bigint product_id FK
        enum allergen_type
        enum severity
        text notes
        timestamp created_at
    }

    product_images {
        bigint id PK
        bigint product_id FK
        varchar image_url
        varchar thumbnail_url
        enum image_type
        varchar alt_text
        int display_order
        boolean is_primary
        timestamp created_at
        timestamp updated_at
    }

    orders {
        bigint id PK
        varchar order_number UK
        bigint user_id FK
        enum status
        enum payment_status
        decimal subtotal
        decimal tax_amount
        decimal delivery_fee
        decimal discount_amount
        int icecoins_used
        decimal total_amount
        bigint delivery_address_id FK
        bigint location_id FK
        varchar promotion_code
        date delivery_date
        timestamp confirmed_at
        timestamp cancelled_at
        timestamp delivered_at
        timestamp created_at
        timestamp updated_at
    }

    order_items {
        bigint id PK
        bigint order_id FK
        bigint product_id FK
        varchar product_name
        int quantity
        decimal unit_price
        decimal subtotal
        decimal total_amount
        json product_snapshot
        timestamp created_at
    }

    order_status_history {
        bigint id PK
        bigint order_id FK
        varchar old_status
        varchar new_status
        bigint changed_by
        enum changed_by_type
        text notes
        timestamp created_at
    }

    payments {
        bigint id PK
        bigint order_id FK
        bigint user_id FK
        bigint payment_method_id FK
        enum payment_method
        varchar transaction_id
        decimal amount
        enum status
        timestamp payment_date
        decimal refund_amount
        timestamp refund_date
        timestamp created_at
        timestamp updated_at
    }

    payment_methods {
        bigint id PK
        bigint user_id FK
        enum method_type
        varchar provider
        varchar account_number
        boolean is_default
        boolean is_verified
        timestamp created_at
        timestamp updated_at
        timestamp deleted_at
    }

    locations {
        bigint id PK
        varchar location_code UK
        varchar name
        enum type
        varchar street_address
        varchar city
        varchar country
        decimal latitude
        decimal longitude
        varchar phone
        json operating_hours
        json service_areas
        boolean is_active
        boolean accepts_orders
        timestamp created_at
        timestamp updated_at
    }

    location_inventory {
        bigint id PK
        bigint location_id FK
        bigint product_id FK
        int quantity
        int reserved_quantity
        int available_quantity
        int reorder_point
        timestamp last_restocked_at
        timestamp created_at
        timestamp updated_at
    }

    delivery_personnel {
        bigint id PK
        varchar employee_id UK
        varchar first_name
        varchar last_name
        varchar phone UK
        enum vehicle_type
        varchar vehicle_number
        bigint home_location_id FK
        bigint current_location_id FK
        enum status
        decimal rating
        int total_deliveries
        boolean is_active
        timestamp created_at
        timestamp updated_at
    }

    deliveries {
        bigint id PK
        bigint order_id FK
        bigint delivery_person_id FK
        varchar tracking_number UK
        enum status
        bigint pickup_location_id FK
        json delivery_address
        timestamp estimated_delivery_time
        timestamp actual_delivery_time
        decimal delivery_fee
        timestamp created_at
        timestamp updated_at
    }

    icecoins_wallet {
        bigint id PK
        bigint user_id FK
        int balance
        int total_earned
        int total_spent
        enum tier
        int tier_points
        decimal multiplier
        timestamp created_at
        timestamp updated_at
    }

    icecoins_transactions {
        bigint id PK
        bigint user_id FK
        bigint wallet_id FK
        enum transaction_type
        int amount
        int balance_before
        int balance_after
        enum source
        bigint source_id
        varchar description
        timestamp created_at
    }

    reviews {
        bigint id PK
        bigint user_id FK
        bigint product_id FK
        bigint order_id FK
        decimal rating
        varchar title
        text comment
        json photos
        boolean verified_purchase
        boolean is_featured
        int helpful_count
        enum status
        timestamp created_at
        timestamp updated_at
        timestamp deleted_at
    }

    recipes {
        bigint id PK
        bigint creator_id FK
        varchar title
        varchar slug UK
        text description
        int prep_time
        int cook_time
        int servings
        enum difficulty
        enum meal_type
        json dietary_tags
        json ingredients
        json instructions
        varchar featured_image
        enum status
        int views_count
        int tries_count
        decimal rating
        boolean is_featured
        timestamp published_at
        timestamp created_at
        timestamp updated_at
        timestamp deleted_at
    }

    challenges {
        bigint id PK
        varchar challenge_key UK
        varchar title
        text description
        enum challenge_type
        enum difficulty
        varchar goal_type
        decimal goal_value
        int reward_icecoins
        boolean is_recurring
        timestamp start_date
        timestamp end_date
        boolean is_active
        timestamp created_at
        timestamp updated_at
    }

    digital_passports {
        bigint id PK
        bigint product_id FK
        varchar batch_number
        varchar serial_number
        varchar qr_code UK
        varchar blockchain_hash
        date manufacturing_date
        date expiry_date
        json origin_location
        json certifications
        json supply_chain_stages
        decimal sustainability_score
        boolean is_verified
        int total_scans
        enum status
        timestamp created_at
        timestamp updated_at
    }

    leaderboards {
        bigint id PK
        varchar leaderboard_key UK
        varchar title
        enum category
        varchar metric_type
        enum ranking_period
        boolean is_active
        boolean is_featured
        timestamp created_at
        timestamp updated_at
    }

    admin_users {
        bigint id PK
        varchar username UK
        varchar email UK
        varchar password_hash
        varchar full_name
        bigint role_id FK
        enum status
        boolean two_factor_enabled
        timestamp last_login_at
        timestamp created_at
        timestamp updated_at
        timestamp deleted_at
    }

    admin_roles {
        bigint id PK
        varchar role_name
        varchar role_key UK
        text description
        int level
        json permissions
        boolean can_manage_users
        boolean can_manage_products
        boolean can_manage_orders
        timestamp created_at
        timestamp updated_at
    }
```

## Database Statistics

- **Total Tables**: 80
- **Total Relationships**: 100+
- **Database Engine**: MySQL 8.0+
- **Character Set**: utf8mb4

## Key Features

### Core Modules
1. **User Management** - Complete user lifecycle management
2. **Product Catalog** - Comprehensive product information with nutrition & allergens
3. **Order Management** - Full order processing pipeline
4. **Delivery System** - Real-time delivery tracking
5. **Loyalty Program** - IceCoins rewards system

### Advanced Features
6. **Social Network** - User posts, follows, likes, comments
7. **Recipe Platform** - User-generated recipes with products
8. **Challenges & Gamification** - Badges, leaderboards, achievements
9. **Digital Passport** - Blockchain-verified product tracking
10. **Health Tracking** - Personal health goals and nutrition tracking

### Business Intelligence
11. **Analytics** - Comprehensive tracking (page views, search, cart, conversion)
12. **Trust System** - User verification and trust scores
13. **Feedback System** - Customer feedback management
14. **Promotions** - Flexible promotion and discount engine

### Technical Infrastructure
15. **API Management** - API keys and logging
16. **Webhooks** - Event-driven integrations
17. **File Management** - Centralized file storage
18. **Error Tracking** - Comprehensive error logging
19. **Job Scheduling** - Background task management
20. **Administration** - Role-based access control

---

## How to View This Diagram

1. **In VS Code**: Open this file and the diagram will render automatically
2. **Preview Mode**: Press `Ctrl+Shift+V` (Windows) or `Cmd+Shift+V` (Mac)
3. **Side-by-Side**: Right-click and select "Open Preview to the Side"

---

*Generated: November 11, 2025*  
*Database: SavoyConnect - Phase 1-5 Complete (80 Tables)*
