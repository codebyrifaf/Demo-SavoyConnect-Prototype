# SavoyConnect Database - Detailed ER Diagrams by Section

## Table of Contents
1. [User Management](#user-management)
2. [Product Catalog](#product-catalog)
3. [Order & Payment](#order--payment)
4. [Delivery System](#delivery-system)
5. [Loyalty & Rewards](#loyalty--rewards)
6. [Reviews & Ratings](#reviews--ratings)
7. [Recipes Platform](#recipes-platform)
8. [Social Features](#social-features)
9. [Gamification](#gamification)
10. [Analytics](#analytics)

---

## User Management

```mermaid
erDiagram
    users ||--|| user_profiles : has
    users ||--|| user_preferences : has
    users ||--o{ user_addresses : has
    users ||--o{ sessions : creates
    users ||--o{ password_resets : requests
    users ||--|| trust_scores : has
    users ||--o{ user_verifications : undergoes

    users {
        bigint id PK "Primary Key"
        varchar email UK "Unique Email"
        varchar phone UK "Unique Phone"
        varchar password_hash "Encrypted"
        varchar first_name
        varchar last_name
        date date_of_birth
        enum gender "male/female/other"
        enum status "active/inactive/suspended"
        timestamp created_at
    }

    user_profiles {
        bigint id PK
        bigint user_id FK "→ users.id"
        text bio
        varchar occupation
        varchar company
        json social_links
        json interests
        json dietary_preferences
    }

    user_addresses {
        bigint id PK
        bigint user_id FK "→ users.id"
        enum address_type "home/work/other"
        varchar street_address
        varchar city
        varchar country
        boolean is_default
        decimal latitude
        decimal longitude
    }

    sessions {
        bigint id PK
        bigint user_id FK "→ users.id"
        varchar session_token UK
        enum device_type
        timestamp expires_at
        boolean is_active
    }
```

---

## Product Catalog

```mermaid
erDiagram
    product_categories ||--o{ product_categories : "parent of"
    product_categories ||--o{ products : contains
    products ||--|| product_nutrition : has
    products ||--o{ product_allergens : contains
    products ||--o{ product_images : has

    products {
        bigint id PK
        varchar product_code UK
        varchar barcode
        varchar name
        varchar slug UK
        bigint category_id FK "→ categories.id"
        varchar brand
        varchar unit "kg/liter/piece"
        decimal price
        decimal compare_price
        int stock_quantity
        enum status "active/inactive"
        boolean featured
        timestamp created_at
    }

    product_categories {
        bigint id PK
        bigint parent_id FK "→ self.id"
        varchar name
        varchar slug UK
        int level "0=root, 1=child"
        int display_order
        boolean is_active
        boolean is_featured
    }

    product_nutrition {
        bigint id PK
        bigint product_id FK "→ products.id"
        decimal calories
        decimal protein
        decimal total_fat
        decimal carbohydrates
        text ingredients
        decimal health_score "0-5"
    }

    product_allergens {
        bigint id PK
        bigint product_id FK
        enum allergen_type "milk/eggs/nuts"
        enum severity "contains/may_contain"
    }

    product_images {
        bigint id PK
        bigint product_id FK
        varchar image_url
        enum image_type "main/gallery"
        boolean is_primary
        int display_order
    }
```

---

## Order & Payment

```mermaid
erDiagram
    users ||--o{ orders : places
    orders ||--o{ order_items : contains
    products ||--o{ order_items : "included in"
    orders ||--|| deliveries : "shipped as"
    orders ||--o{ payments : "paid via"
    users ||--o{ payment_methods : owns
    payment_methods ||--o{ payments : "used for"
    orders ||--o{ order_status_history : tracks

    orders {
        bigint id PK
        varchar order_number UK
        bigint user_id FK "→ users.id"
        enum status "pending/confirmed/delivered"
        enum payment_status "pending/paid/failed"
        decimal subtotal
        decimal tax_amount
        decimal delivery_fee
        decimal total_amount
        int icecoins_used
        date delivery_date
        timestamp created_at
    }

    order_items {
        bigint id PK
        bigint order_id FK "→ orders.id"
        bigint product_id FK "→ products.id"
        int quantity
        decimal unit_price
        decimal total_amount
        json product_snapshot
    }

    payments {
        bigint id PK
        bigint order_id FK "→ orders.id"
        bigint user_id FK "→ users.id"
        enum payment_method "cash/card/bkash"
        varchar transaction_id
        decimal amount
        enum status "pending/completed/failed"
        timestamp payment_date
    }

    payment_methods {
        bigint id PK
        bigint user_id FK
        enum method_type "card/bank/mobile"
        varchar provider "visa/bkash"
        boolean is_default
        boolean is_verified
    }
```

---

## Delivery System

```mermaid
erDiagram
    locations ||--o{ delivery_personnel : "home base"
    locations ||--o{ location_inventory : stocks
    products ||--o{ location_inventory : "stocked at"
    delivery_personnel ||--o{ deliveries : performs
    orders ||--|| deliveries : "shipped as"
    locations ||--o{ orders : fulfills

    locations {
        bigint id PK
        varchar location_code UK
        varchar name
        enum type "warehouse/store/hub"
        varchar city
        decimal latitude
        decimal longitude
        json operating_hours
        boolean is_active
        boolean accepts_orders
    }

    delivery_personnel {
        bigint id PK
        varchar employee_id UK
        varchar first_name
        varchar last_name
        varchar phone UK
        enum vehicle_type "bike/car/van"
        bigint home_location_id FK
        enum status "available/busy/offline"
        decimal rating "0-5"
        int total_deliveries
    }

    deliveries {
        bigint id PK
        bigint order_id FK "→ orders.id"
        bigint delivery_person_id FK
        varchar tracking_number UK
        enum status "assigned/in_transit/delivered"
        timestamp estimated_delivery_time
        timestamp actual_delivery_time
        json delivery_address
        json proof_of_delivery
    }

    location_inventory {
        bigint id PK
        bigint location_id FK
        bigint product_id FK
        int quantity
        int reserved_quantity
        int available_quantity
        int reorder_point
    }
```

---

## Loyalty & Rewards

```mermaid
erDiagram
    users ||--|| icecoins_wallet : owns
    icecoins_wallet ||--o{ icecoins_transactions : records
    users ||--o{ reward_redemptions : redeems
    orders ||--o{ reward_redemptions : "uses reward"
    loyalty_tiers ||--o{ icecoins_wallet : "tier level"

    icecoins_wallet {
        bigint id PK
        bigint user_id FK "→ users.id"
        int balance "Current IceCoins"
        int total_earned
        int total_spent
        enum tier "bronze/silver/gold/platinum"
        int tier_points
        decimal multiplier "Earning rate"
    }

    icecoins_transactions {
        bigint id PK
        bigint user_id FK
        bigint wallet_id FK
        enum transaction_type "earned/spent/expired"
        int amount
        int balance_after
        enum source "order/referral/challenge"
        bigint source_id
        timestamp created_at
    }

    reward_redemptions {
        bigint id PK
        bigint user_id FK
        enum reward_type "discount/free_product"
        int icecoins_spent
        decimal reward_value
        varchar reward_code
        enum status "active/used/expired"
        timestamp valid_until
    }

    loyalty_tiers {
        bigint id PK
        varchar tier_key UK "bronze/silver/gold"
        int min_points
        decimal earning_multiplier
        json benefits
        decimal discount_percentage
    }
```

---

## Reviews & Ratings

```mermaid
erDiagram
    users ||--o{ reviews : writes
    products ||--o{ reviews : "reviewed on"
    orders ||--o{ reviews : "verified by"
    reviews ||--o{ review_responses : "has response"
    reviews ||--o{ review_votes : "voted on"
    users ||--o{ review_votes : votes

    reviews {
        bigint id PK
        bigint user_id FK "→ users.id"
        bigint product_id FK "→ products.id"
        bigint order_id FK "→ orders.id"
        decimal rating "1.00 - 5.00"
        varchar title
        text comment
        json photos "Review images"
        boolean verified_purchase
        boolean is_featured
        int helpful_count
        enum status "pending/approved/rejected"
        timestamp created_at
    }

    review_responses {
        bigint id PK
        bigint review_id FK
        bigint responder_id FK
        enum responder_type "brand/admin"
        text response
        boolean is_official
    }

    review_votes {
        bigint id PK
        bigint review_id FK
        bigint user_id FK
        enum vote_type "helpful/not_helpful"
    }
```

---

## Recipes Platform

```mermaid
erDiagram
    users ||--o{ recipes : creates
    recipes ||--o{ recipe_products : uses
    products ||--o{ recipe_products : "ingredient in"
    recipes ||--o{ recipe_tries : "tried by"
    users ||--o{ recipe_tries : tries
    recipes ||--o{ recipe_saves : "saved by"
    users ||--o{ recipe_saves : saves
    users ||--o{ recipe_collections : creates
    recipe_collections ||--o{ recipe_saves : contains

    recipes {
        bigint id PK
        bigint creator_id FK "→ users.id"
        varchar title
        varchar slug UK
        int prep_time "minutes"
        int cook_time "minutes"
        int servings
        enum difficulty "easy/medium/hard"
        json ingredients
        json instructions
        enum status "draft/published"
        int views_count
        int tries_count
        decimal rating "0-5"
        boolean is_featured
    }

    recipe_products {
        bigint id PK
        bigint recipe_id FK
        bigint product_id FK
        decimal quantity
        varchar unit "kg/grams/cups"
        boolean is_optional
    }

    recipe_tries {
        bigint id PK
        bigint recipe_id FK
        bigint user_id FK
        decimal rating "User's rating"
        text review
        json photos "User's photos"
        boolean would_make_again
        timestamp created_at
    }

    recipe_collections {
        bigint id PK
        bigint user_id FK
        varchar name
        boolean is_public
        int recipe_count
    }
```

---

## Social Features

```mermaid
erDiagram
    users ||--o{ user_follows : "follows others"
    users ||--o{ user_follows : "followed by"
    users ||--o{ user_posts : creates
    user_posts ||--o{ post_likes : "liked by"
    users ||--o{ post_likes : likes
    user_posts ||--o{ post_comments : has
    users ||--o{ post_comments : writes
    post_comments ||--o{ post_comments : "replies to"

    user_posts {
        bigint id PK
        bigint user_id FK "→ users.id"
        enum post_type "text/image/recipe_share"
        text content
        json media_urls
        bigint related_recipe_id FK
        bigint related_product_id FK
        enum visibility "public/followers/private"
        int likes_count
        int comments_count
        timestamp created_at
    }

    user_follows {
        bigint id PK
        bigint follower_id FK "→ users.id"
        bigint following_id FK "→ users.id"
        timestamp created_at
    }

    post_likes {
        bigint id PK
        bigint post_id FK
        bigint user_id FK
        enum reaction_type "like/love/wow"
        timestamp created_at
    }

    post_comments {
        bigint id PK
        bigint post_id FK
        bigint user_id FK
        bigint parent_comment_id FK "For replies"
        text comment
        int likes_count
        int replies_count
    }
```

---

## Gamification

```mermaid
erDiagram
    challenges ||--o{ user_challenges : "enrolled by"
    users ||--o{ user_challenges : participates
    user_challenges ||--o{ challenge_progress_events : tracks
    badges ||--o{ user_badges : "earned by"
    users ||--o{ user_badges : earns
    leaderboards ||--o{ leaderboard_entries : contains
    users ||--o{ leaderboard_entries : "ranks in"

    challenges {
        bigint id PK
        varchar challenge_key UK
        varchar title
        enum challenge_type "ordering/recipe/review"
        enum difficulty "easy/medium/hard"
        decimal goal_value
        int reward_icecoins
        boolean is_recurring
        timestamp start_date
        timestamp end_date
        boolean is_active
    }

    user_challenges {
        bigint id PK
        bigint user_id FK
        bigint challenge_id FK
        enum status "enrolled/completed/failed"
        decimal progress_value
        decimal progress_percentage
        boolean reward_claimed
        timestamp completed_at
    }

    badges {
        bigint id PK
        varchar badge_key UK
        varchar badge_name
        enum category "ordering/social/recipes"
        enum rarity "common/rare/legendary"
        varchar icon_url
        int reward_icecoins
        boolean is_secret
    }

    user_badges {
        bigint id PK
        bigint user_id FK
        bigint badge_id FK
        timestamp earned_at
        boolean is_pinned
        boolean is_public
    }

    leaderboards {
        bigint id PK
        varchar leaderboard_key UK
        varchar title
        enum category "spending/orders/recipes"
        enum ranking_period "monthly/weekly/all_time"
        boolean is_active
    }

    leaderboard_entries {
        bigint id PK
        bigint leaderboard_id FK
        bigint user_id FK
        int rank
        decimal score
        enum movement "up/down/same"
    }
```

---

## Analytics

```mermaid
erDiagram
    users ||--o{ page_views : views
    sessions ||--o{ page_views : tracks
    users ||--o{ search_queries : searches
    search_queries ||--o{ search_results : returns
    users ||--o{ cart_analytics : "cart events"
    users ||--o{ conversion_tracking : converts

    page_views {
        bigint id PK
        bigint user_id FK
        bigint session_id FK
        varchar page_url
        varchar page_type
        varchar referrer_url
        int time_on_page "seconds"
        timestamp created_at
    }

    search_queries {
        bigint id PK
        bigint user_id FK
        bigint session_id FK
        varchar query_text
        int results_count
        bigint clicked_result_id
        boolean resulted_in_order
        boolean is_zero_results
        timestamp created_at
    }

    search_results {
        bigint id PK
        bigint search_query_id FK
        enum result_type "product/recipe"
        bigint result_id
        int result_position
        decimal relevance_score
        boolean was_clicked
    }

    cart_analytics {
        bigint id PK
        bigint user_id FK
        bigint session_id FK
        enum event_type "item_added/cart_abandoned"
        bigint product_id FK
        int quantity
        decimal cart_value
        varchar source "product_page/search"
        timestamp created_at
    }

    conversion_tracking {
        bigint id PK
        bigint user_id FK
        bigint order_id FK
        enum conversion_type "first_order/repeat"
        decimal conversion_value
        varchar attribution_source
        int time_to_convert "seconds"
        timestamp created_at
    }
```

---

## Digital Passport & Sustainability

```mermaid
erDiagram
    products ||--o{ digital_passports : "tracked by"
    digital_passports ||--o{ passport_scans : "scanned by"
    users ||--o{ passport_scans : scans
    products ||--o{ sustainability_reports : reports

    digital_passports {
        bigint id PK
        bigint product_id FK "→ products.id"
        varchar batch_number
        varchar qr_code UK "QR Code"
        varchar blockchain_hash
        date manufacturing_date
        date expiry_date
        json origin_location "Farm/Factory"
        json certifications "Organic/Halal"
        json supply_chain_stages
        decimal sustainability_score
        int total_scans
        enum status "active/verified"
    }

    passport_scans {
        bigint id PK
        bigint passport_id FK
        bigint user_id FK
        varchar scan_location
        decimal latitude
        decimal longitude
        enum scan_type "consumer/inspector"
        timestamp created_at
    }

    sustainability_reports {
        bigint id PK
        bigint product_id FK
        varchar report_period "Q1 2025"
        decimal carbon_footprint "kg CO2"
        decimal water_usage "liters"
        boolean organic_certified
        boolean fair_trade_certified
        decimal overall_sustainability_score
    }
```

---

## Promotions & Referrals

```mermaid
erDiagram
    promotions ||--o{ promotion_usage : "used in"
    users ||--o{ promotion_usage : uses
    orders ||--o{ promotion_usage : "applied to"
    users ||--o{ referrals : "refers as referrer"
    users ||--o{ referrals : "referred as"
    orders ||--o{ referrals : "first order"

    promotions {
        bigint id PK
        varchar promotion_code UK
        varchar name
        enum promotion_type "percentage/fixed/free_shipping"
        decimal discount_value
        decimal min_order_amount
        int max_uses_per_user
        json applicable_products
        timestamp start_date
        timestamp end_date
        boolean is_active
    }

    promotion_usage {
        bigint id PK
        bigint promotion_id FK
        bigint user_id FK
        bigint order_id FK
        decimal discount_amount
        timestamp used_at
    }

    referrals {
        bigint id PK
        bigint referrer_id FK "→ users.id"
        bigint referred_id FK "→ users.id"
        varchar referral_code UK
        enum status "pending/completed"
        int referrer_reward "IceCoins"
        int referred_reward "IceCoins"
        timestamp registered_at
        bigint first_order_id FK
    }
```

---

## Administration

```mermaid
erDiagram
    admin_roles ||--o{ admin_users : "assigned to"
    admin_users ||--o{ admin_activity_logs : performs
    admin_users ||--o{ api_keys : manages
    api_keys ||--o{ api_logs : logs

    admin_users {
        bigint id PK
        varchar username UK
        varchar email UK
        varchar password_hash
        bigint role_id FK "→ admin_roles.id"
        enum status "active/inactive"
        boolean two_factor_enabled
        timestamp last_login_at
    }

    admin_roles {
        bigint id PK
        varchar role_key UK "super_admin/editor"
        varchar role_name
        int level "Access level"
        json permissions
        boolean can_manage_users
        boolean can_manage_products
        boolean can_view_analytics
    }

    admin_activity_logs {
        bigint id PK
        bigint admin_user_id FK
        varchar action "create/update/delete"
        varchar entity_type "product/user/order"
        bigint entity_id
        json old_values
        json new_values
        timestamp created_at
    }

    api_keys {
        bigint id PK
        varchar api_key UK
        enum key_type "public/private"
        bigint user_id FK
        json permissions
        int rate_limit
        enum status "active/revoked"
        timestamp expires_at
    }
```

---

## Summary Statistics

| Category | Tables | Key Features |
|----------|--------|--------------|
| **User Management** | 7 | Authentication, profiles, addresses, sessions |
| **Products** | 5 | Catalog, categories, nutrition, allergens |
| **Orders** | 9 | Orders, payments, delivery, tracking |
| **Loyalty** | 7 | IceCoins, rewards, tiers, challenges |
| **Social** | 8 | Posts, follows, likes, comments |
| **Recipes** | 5 | Creation, tries, saves, collections |
| **Gamification** | 6 | Badges, challenges, leaderboards |
| **Analytics** | 8 | Page views, search, cart, conversion |
| **Digital Trust** | 5 | Passports, sustainability, verification |
| **Admin** | 10 | Roles, logs, API management |
| **System** | 10 | Files, webhooks, errors, jobs |
| **TOTAL** | **80** | Complete e-commerce ecosystem |

---

*Last Updated: November 11, 2025*  
*Database: MySQL 8.0+ | Character Set: utf8mb4*
