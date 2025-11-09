-- =====================================================
-- SavoyConnect Database Schema - DDL
-- Phase 1: MVP Core Tables (Tables 1-21)
-- MySQL 8.0+
-- Generated: November 9, 2025
-- =====================================================

-- Set SQL mode and character set
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+06:00";

-- Set database character set
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- =====================================================
-- Create Database
-- =====================================================
CREATE DATABASE IF NOT EXISTS `savoyconnect` 
DEFAULT CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE `savoyconnect`;

-- =====================================================
-- SECTION 1: USER MANAGEMENT (Tables 1-6)
-- =====================================================

-- Table 1: users
CREATE TABLE `users` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NOT NULL,
  `phone` VARCHAR(20) NULL,
  `password_hash` VARCHAR(255) NOT NULL,
  `first_name` VARCHAR(100) NULL,
  `last_name` VARCHAR(100) NULL,
  `date_of_birth` DATE NULL,
  `gender` ENUM('male', 'female', 'other', 'prefer_not_to_say') NULL,
  `profile_picture_url` VARCHAR(500) NULL,
  `email_verified` BOOLEAN NOT NULL DEFAULT FALSE,
  `phone_verified` BOOLEAN NOT NULL DEFAULT FALSE,
  `status` ENUM('active', 'inactive', 'suspended', 'deleted') NOT NULL DEFAULT 'active',
  `last_login_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_email` (`email`),
  UNIQUE KEY `idx_phone` (`phone`),
  KEY `idx_status` (`status`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 2: user_profiles
CREATE TABLE `user_profiles` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `bio` TEXT NULL,
  `occupation` VARCHAR(100) NULL,
  `company` VARCHAR(255) NULL,
  `website` VARCHAR(500) NULL,
  `location` VARCHAR(255) NULL,
  `social_links` JSON NULL COMMENT 'Social media profile links',
  `interests` JSON NULL COMMENT 'User interests array',
  `dietary_preferences` JSON NULL COMMENT 'Dietary restrictions and preferences',
  `language_preference` VARCHAR(10) NOT NULL DEFAULT 'en' COMMENT 'en, bn',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_id` (`user_id`),
  CONSTRAINT `fk_user_profiles_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 3: user_preferences
CREATE TABLE `user_preferences` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `email_notifications` BOOLEAN NOT NULL DEFAULT TRUE,
  `sms_notifications` BOOLEAN NOT NULL DEFAULT TRUE,
  `push_notifications` BOOLEAN NOT NULL DEFAULT TRUE,
  `marketing_emails` BOOLEAN NOT NULL DEFAULT TRUE,
  `order_updates` BOOLEAN NOT NULL DEFAULT TRUE,
  `promotional_offers` BOOLEAN NOT NULL DEFAULT TRUE,
  `newsletter_subscription` BOOLEAN NOT NULL DEFAULT FALSE,
  `product_recommendations` BOOLEAN NOT NULL DEFAULT TRUE,
  `recipe_suggestions` BOOLEAN NOT NULL DEFAULT TRUE,
  `challenge_invitations` BOOLEAN NOT NULL DEFAULT TRUE,
  `social_activity_updates` BOOLEAN NOT NULL DEFAULT TRUE,
  `weekly_digest` BOOLEAN NOT NULL DEFAULT FALSE,
  `theme` ENUM('light', 'dark', 'auto') NOT NULL DEFAULT 'auto',
  `currency` VARCHAR(3) NOT NULL DEFAULT 'BDT',
  `timezone` VARCHAR(100) NOT NULL DEFAULT 'Asia/Dhaka',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_id` (`user_id`),
  CONSTRAINT `fk_user_preferences_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 4: user_addresses
CREATE TABLE `user_addresses` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `address_type` ENUM('home', 'work', 'other') NOT NULL DEFAULT 'home',
  `label` VARCHAR(100) NULL COMMENT 'Custom label like "Mom''s House"',
  `recipient_name` VARCHAR(255) NULL,
  `recipient_phone` VARCHAR(20) NULL,
  `street_address` VARCHAR(500) NOT NULL,
  `landmark` VARCHAR(255) NULL,
  `area` VARCHAR(255) NULL,
  `city` VARCHAR(100) NOT NULL,
  `state` VARCHAR(100) NULL,
  `postal_code` VARCHAR(20) NULL,
  `country` VARCHAR(100) NOT NULL DEFAULT 'Bangladesh',
  `latitude` DECIMAL(10, 8) NULL,
  `longitude` DECIMAL(11, 8) NULL,
  `is_default` BOOLEAN NOT NULL DEFAULT FALSE,
  `delivery_instructions` TEXT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_is_default` (`is_default`),
  KEY `idx_city` (`city`),
  CONSTRAINT `fk_user_addresses_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 5: sessions
CREATE TABLE `sessions` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `session_token` VARCHAR(255) NOT NULL,
  `refresh_token` VARCHAR(255) NULL,
  `device_type` ENUM('web', 'mobile', 'tablet', 'desktop') NOT NULL,
  `device_name` VARCHAR(255) NULL,
  `browser` VARCHAR(100) NULL,
  `operating_system` VARCHAR(100) NULL,
  `ip_address` VARCHAR(45) NULL,
  `user_agent` TEXT NULL,
  `last_activity` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expires_at` TIMESTAMP NOT NULL,
  `is_active` BOOLEAN NOT NULL DEFAULT TRUE,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_session_token` (`session_token`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_expires_at` (`expires_at`),
  KEY `idx_is_active` (`is_active`),
  CONSTRAINT `fk_sessions_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 6: password_resets
CREATE TABLE `password_resets` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `token` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `is_used` BOOLEAN NOT NULL DEFAULT FALSE,
  `used_at` TIMESTAMP NULL,
  `expires_at` TIMESTAMP NOT NULL,
  `ip_address` VARCHAR(45) NULL,
  `user_agent` TEXT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_token` (`token`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_email` (`email`),
  KEY `idx_expires_at` (`expires_at`),
  CONSTRAINT `fk_password_resets_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- SECTION 2: PRODUCT CATALOG (Tables 7-11)
-- =====================================================

-- Table 7: products
CREATE TABLE `products` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_code` VARCHAR(100) NOT NULL,
  `barcode` VARCHAR(100) NULL,
  `name` VARCHAR(255) NOT NULL,
  `slug` VARCHAR(255) NOT NULL,
  `description` TEXT NULL,
  `short_description` VARCHAR(500) NULL,
  `category_id` BIGINT UNSIGNED NULL,
  `brand` VARCHAR(255) NULL,
  `manufacturer` VARCHAR(255) NULL,
  `origin_country` VARCHAR(100) NULL,
  `unit` VARCHAR(50) NOT NULL COMMENT 'kg, liter, piece, pack',
  `unit_value` DECIMAL(10, 2) NOT NULL COMMENT 'Numeric value of unit',
  `price` DECIMAL(10, 2) NOT NULL,
  `compare_price` DECIMAL(10, 2) NULL COMMENT 'Original price before discount',
  `cost_price` DECIMAL(10, 2) NULL COMMENT 'Cost to business',
  `currency` VARCHAR(3) NOT NULL DEFAULT 'BDT',
  `tax_percentage` DECIMAL(5, 2) NOT NULL DEFAULT 0.00,
  `is_taxable` BOOLEAN NOT NULL DEFAULT FALSE,
  `weight` DECIMAL(10, 2) NULL COMMENT 'Weight in kg',
  `dimensions` JSON NULL COMMENT 'Length, width, height in cm',
  `stock_quantity` INT NOT NULL DEFAULT 0,
  `low_stock_threshold` INT NOT NULL DEFAULT 10,
  `is_available` BOOLEAN NOT NULL DEFAULT TRUE,
  `status` ENUM('active', 'inactive', 'out_of_stock', 'discontinued') NOT NULL DEFAULT 'active',
  `featured` BOOLEAN NOT NULL DEFAULT FALSE,
  `tags` JSON NULL COMMENT 'Product tags array',
  `meta_title` VARCHAR(255) NULL,
  `meta_description` VARCHAR(500) NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_product_code` (`product_code`),
  UNIQUE KEY `idx_slug` (`slug`),
  KEY `idx_barcode` (`barcode`),
  KEY `idx_category_id` (`category_id`),
  KEY `idx_status` (`status`),
  KEY `idx_featured` (`featured`),
  KEY `idx_price` (`price`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 8: product_categories
CREATE TABLE `product_categories` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_id` BIGINT UNSIGNED NULL,
  `name` VARCHAR(255) NOT NULL,
  `slug` VARCHAR(255) NOT NULL,
  `description` TEXT NULL,
  `icon_url` VARCHAR(500) NULL,
  `image_url` VARCHAR(500) NULL,
  `banner_url` VARCHAR(500) NULL,
  `display_order` INT NOT NULL DEFAULT 0,
  `level` INT NOT NULL DEFAULT 0 COMMENT 'Hierarchy level: 0 = root, 1 = child, etc.',
  `is_active` BOOLEAN NOT NULL DEFAULT TRUE,
  `is_featured` BOOLEAN NOT NULL DEFAULT FALSE,
  `product_count` INT NOT NULL DEFAULT 0,
  `meta_title` VARCHAR(255) NULL,
  `meta_description` VARCHAR(500) NULL,
  `color_code` VARCHAR(7) NULL COMMENT 'Hex color for UI',
  `tags` JSON NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_slug` (`slug`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_is_active` (`is_active`),
  KEY `idx_display_order` (`display_order`),
  CONSTRAINT `fk_product_categories_parent` FOREIGN KEY (`parent_id`) REFERENCES `product_categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add foreign key for products.category_id after product_categories is created
ALTER TABLE `products` 
ADD CONSTRAINT `fk_products_category` FOREIGN KEY (`category_id`) REFERENCES `product_categories` (`id`) ON DELETE SET NULL;

-- Table 9: product_nutrition
CREATE TABLE `product_nutrition` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_id` BIGINT UNSIGNED NOT NULL,
  `serving_size` VARCHAR(100) NOT NULL COMMENT '100g, 1 cup, 1 piece',
  `servings_per_container` DECIMAL(5, 2) NULL,
  `calories` DECIMAL(8, 2) NOT NULL,
  `calories_from_fat` DECIMAL(8, 2) NULL,
  `total_fat` DECIMAL(8, 2) NULL COMMENT 'Grams',
  `saturated_fat` DECIMAL(8, 2) NULL,
  `trans_fat` DECIMAL(8, 2) NULL,
  `cholesterol` DECIMAL(8, 2) NULL COMMENT 'Milligrams',
  `sodium` DECIMAL(8, 2) NULL COMMENT 'Milligrams',
  `total_carbohydrates` DECIMAL(8, 2) NULL COMMENT 'Grams',
  `dietary_fiber` DECIMAL(8, 2) NULL,
  `sugars` DECIMAL(8, 2) NULL,
  `added_sugars` DECIMAL(8, 2) NULL,
  `protein` DECIMAL(8, 2) NULL COMMENT 'Grams',
  `vitamin_a` DECIMAL(8, 2) NULL,
  `vitamin_c` DECIMAL(8, 2) NULL,
  `vitamin_d` DECIMAL(8, 2) NULL,
  `calcium` DECIMAL(8, 2) NULL,
  `iron` DECIMAL(8, 2) NULL,
  `potassium` DECIMAL(8, 2) NULL,
  `ingredients` TEXT NULL COMMENT 'Full ingredient list',
  `nutritional_claims` JSON NULL COMMENT 'Low-fat, organic, etc.',
  `health_score` DECIMAL(3, 2) NULL COMMENT 'Score 0-5',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_product_id` (`product_id`),
  CONSTRAINT `fk_product_nutrition_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 10: product_allergens
CREATE TABLE `product_allergens` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_id` BIGINT UNSIGNED NOT NULL,
  `allergen_type` ENUM('milk', 'eggs', 'fish', 'shellfish', 'tree_nuts', 'peanuts', 'wheat', 'soybeans', 'gluten', 'sesame', 'sulfites', 'mustard') NOT NULL,
  `severity` ENUM('contains', 'may_contain', 'free') NOT NULL,
  `notes` TEXT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_product_id` (`product_id`),
  KEY `idx_allergen_type` (`allergen_type`),
  CONSTRAINT `fk_product_allergens_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 11: product_images
CREATE TABLE `product_images` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_id` BIGINT UNSIGNED NOT NULL,
  `image_url` VARCHAR(1000) NOT NULL,
  `thumbnail_url` VARCHAR(1000) NULL,
  `image_type` ENUM('main', 'gallery', 'thumbnail', 'lifestyle', '360') NOT NULL DEFAULT 'gallery',
  `alt_text` VARCHAR(255) NULL,
  `title` VARCHAR(255) NULL,
  `display_order` INT NOT NULL DEFAULT 0,
  `width` INT NULL,
  `height` INT NULL,
  `file_size` BIGINT NULL COMMENT 'Size in bytes',
  `is_primary` BOOLEAN NOT NULL DEFAULT FALSE,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_product_id` (`product_id`),
  KEY `idx_image_type` (`image_type`),
  KEY `idx_display_order` (`display_order`),
  CONSTRAINT `fk_product_images_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- SECTION 3: ORDER MANAGEMENT (Tables 12-15)
-- =====================================================

-- Table 12: orders
CREATE TABLE `orders` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_number` VARCHAR(100) NOT NULL,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `status` ENUM('pending', 'confirmed', 'processing', 'ready', 'out_for_delivery', 'delivered', 'cancelled', 'refunded') NOT NULL DEFAULT 'pending',
  `payment_status` ENUM('pending', 'paid', 'failed', 'refunded', 'partially_refunded') NOT NULL DEFAULT 'pending',
  `subtotal` DECIMAL(10, 2) NOT NULL,
  `tax_amount` DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
  `delivery_fee` DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
  `discount_amount` DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
  `icecoins_used` INT NOT NULL DEFAULT 0,
  `icecoins_value` DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
  `total_amount` DECIMAL(10, 2) NOT NULL,
  `currency` VARCHAR(3) NOT NULL DEFAULT 'BDT',
  `delivery_address_id` BIGINT UNSIGNED NULL,
  `delivery_address_snapshot` JSON NULL COMMENT 'Address details at order time',
  `delivery_date` DATE NULL,
  `delivery_time_slot` VARCHAR(100) NULL,
  `delivery_instructions` TEXT NULL,
  `location_id` BIGINT UNSIGNED NULL COMMENT 'Fulfillment location',
  `promotion_code` VARCHAR(100) NULL,
  `promotion_discount` DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
  `notes` TEXT NULL,
  `customer_notes` TEXT NULL,
  `internal_notes` TEXT NULL,
  `items_count` INT NOT NULL DEFAULT 0,
  `ip_address` VARCHAR(45) NULL,
  `user_agent` TEXT NULL,
  `confirmed_at` TIMESTAMP NULL,
  `cancelled_at` TIMESTAMP NULL,
  `cancellation_reason` TEXT NULL,
  `delivered_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_order_number` (`order_number`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_status` (`status`),
  KEY `idx_payment_status` (`payment_status`),
  KEY `idx_delivery_date` (`delivery_date`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `fk_orders_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_orders_address` FOREIGN KEY (`delivery_address_id`) REFERENCES `user_addresses` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 13: order_items
CREATE TABLE `order_items` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` BIGINT UNSIGNED NOT NULL,
  `product_id` BIGINT UNSIGNED NOT NULL,
  `product_name` VARCHAR(255) NOT NULL,
  `product_code` VARCHAR(100) NOT NULL,
  `quantity` INT NOT NULL,
  `unit_price` DECIMAL(10, 2) NOT NULL,
  `subtotal` DECIMAL(10, 2) NOT NULL,
  `tax_amount` DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
  `discount_amount` DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
  `total_amount` DECIMAL(10, 2) NOT NULL,
  `product_snapshot` JSON NULL COMMENT 'Product details at order time',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order_id`),
  KEY `idx_product_id` (`product_id`),
  CONSTRAINT `fk_order_items_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_order_items_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 14: order_status_history
CREATE TABLE `order_status_history` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` BIGINT UNSIGNED NOT NULL,
  `old_status` VARCHAR(50) NULL,
  `new_status` VARCHAR(50) NOT NULL,
  `changed_by` BIGINT UNSIGNED NULL COMMENT 'User or admin ID',
  `changed_by_type` ENUM('user', 'admin', 'system') NOT NULL DEFAULT 'system',
  `notes` TEXT NULL,
  `metadata` JSON NULL,
  `ip_address` VARCHAR(45) NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order_id`),
  KEY `idx_new_status` (`new_status`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `fk_order_status_history_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 15: payments
CREATE TABLE `payments` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` BIGINT UNSIGNED NOT NULL,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `payment_method_id` BIGINT UNSIGNED NULL,
  `payment_method` ENUM('cash', 'card', 'bkash', 'nagad', 'rocket', 'upay', 'bank_transfer', 'icecoins', 'wallet') NOT NULL,
  `transaction_id` VARCHAR(255) NULL,
  `payment_gateway` VARCHAR(100) NULL COMMENT 'stripe, sslcommerz, etc.',
  `gateway_transaction_id` VARCHAR(255) NULL,
  `amount` DECIMAL(10, 2) NOT NULL,
  `currency` VARCHAR(3) NOT NULL DEFAULT 'BDT',
  `status` ENUM('pending', 'processing', 'completed', 'failed', 'refunded', 'cancelled') NOT NULL DEFAULT 'pending',
  `payment_date` TIMESTAMP NULL,
  `refund_amount` DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
  `refund_date` TIMESTAMP NULL,
  `refund_reason` TEXT NULL,
  `gateway_response` JSON NULL,
  `error_message` TEXT NULL,
  `notes` TEXT NULL,
  `ip_address` VARCHAR(45) NULL,
  `payment_screenshot` VARCHAR(500) NULL,
  `verified_by` BIGINT UNSIGNED NULL,
  `verified_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_transaction_id` (`transaction_id`),
  KEY `idx_status` (`status`),
  KEY `idx_payment_date` (`payment_date`),
  CONSTRAINT `fk_payments_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_payments_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- SECTION 4: LOCATIONS & INVENTORY (Tables 16-18)
-- =====================================================

-- Table 16: payment_methods
CREATE TABLE `payment_methods` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `method_type` ENUM('card', 'bank_account', 'mobile_banking', 'wallet') NOT NULL,
  `provider` VARCHAR(100) NULL COMMENT 'visa, mastercard, bkash, etc.',
  `account_name` VARCHAR(255) NULL,
  `account_number` VARCHAR(255) NULL COMMENT 'Last 4 digits or masked',
  `account_number_encrypted` VARCHAR(500) NULL COMMENT 'Full encrypted number',
  `expiry_month` INT NULL,
  `expiry_year` INT NULL,
  `cvv_hash` VARCHAR(255) NULL,
  `billing_address` JSON NULL,
  `is_default` BOOLEAN NOT NULL DEFAULT FALSE,
  `is_verified` BOOLEAN NOT NULL DEFAULT FALSE,
  `token` VARCHAR(500) NULL COMMENT 'Gateway token',
  `gateway` VARCHAR(100) NULL,
  `last_used_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_method_type` (`method_type`),
  KEY `idx_is_default` (`is_default`),
  CONSTRAINT `fk_payment_methods_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add foreign key for payments.payment_method_id
ALTER TABLE `payments` 
ADD CONSTRAINT `fk_payments_method` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_methods` (`id`) ON DELETE SET NULL;

-- Table 17: locations
CREATE TABLE `locations` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `location_code` VARCHAR(100) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `type` ENUM('warehouse', 'store', 'hub', 'dark_store') NOT NULL,
  `street_address` VARCHAR(500) NOT NULL,
  `area` VARCHAR(255) NULL,
  `city` VARCHAR(100) NOT NULL,
  `state` VARCHAR(100) NULL,
  `postal_code` VARCHAR(20) NULL,
  `country` VARCHAR(100) NOT NULL DEFAULT 'Bangladesh',
  `latitude` DECIMAL(10, 8) NOT NULL,
  `longitude` DECIMAL(11, 8) NOT NULL,
  `phone` VARCHAR(20) NULL,
  `email` VARCHAR(255) NULL,
  `manager_name` VARCHAR(255) NULL,
  `manager_phone` VARCHAR(20) NULL,
  `operating_hours` JSON NULL,
  `service_areas` JSON NULL COMMENT 'Array of serviceable areas',
  `delivery_radius_km` DECIMAL(5, 2) NULL,
  `capacity` INT NULL,
  `current_load` INT NOT NULL DEFAULT 0,
  `is_active` BOOLEAN NOT NULL DEFAULT TRUE,
  `accepts_orders` BOOLEAN NOT NULL DEFAULT TRUE,
  `supports_pickup` BOOLEAN NOT NULL DEFAULT FALSE,
  `facilities` JSON NULL COMMENT 'Cold storage, parking, etc.',
  `notes` TEXT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_location_code` (`location_code`),
  KEY `idx_city` (`city`),
  KEY `idx_type` (`type`),
  KEY `idx_is_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add foreign key for orders.location_id
ALTER TABLE `orders` 
ADD CONSTRAINT `fk_orders_location` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`) ON DELETE SET NULL;

-- Table 18: location_inventory
CREATE TABLE `location_inventory` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `location_id` BIGINT UNSIGNED NOT NULL,
  `product_id` BIGINT UNSIGNED NOT NULL,
  `quantity` INT NOT NULL DEFAULT 0,
  `reserved_quantity` INT NOT NULL DEFAULT 0 COMMENT 'Quantity reserved for pending orders',
  `available_quantity` INT NOT NULL DEFAULT 0 COMMENT 'quantity - reserved_quantity',
  `reorder_point` INT NOT NULL DEFAULT 10,
  `reorder_quantity` INT NOT NULL DEFAULT 50,
  `last_restocked_at` TIMESTAMP NULL,
  `last_counted_at` TIMESTAMP NULL,
  `bin_location` VARCHAR(100) NULL COMMENT 'Physical location within warehouse',
  `notes` TEXT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_location_product` (`location_id`, `product_id`),
  KEY `idx_location_id` (`location_id`),
  KEY `idx_product_id` (`product_id`),
  KEY `idx_available_quantity` (`available_quantity`),
  CONSTRAINT `fk_location_inventory_location` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_location_inventory_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- SECTION 5: DELIVERY (Tables 19-20)
-- =====================================================

-- Table 19: delivery_personnel
CREATE TABLE `delivery_personnel` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `employee_id` VARCHAR(100) NOT NULL,
  `first_name` VARCHAR(100) NOT NULL,
  `last_name` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(20) NOT NULL,
  `email` VARCHAR(255) NULL,
  `profile_picture` VARCHAR(500) NULL,
  `vehicle_type` ENUM('bike', 'scooter', 'car', 'van', 'cycle', 'on_foot') NOT NULL,
  `vehicle_number` VARCHAR(100) NULL,
  `license_number` VARCHAR(100) NULL,
  `license_expiry` DATE NULL,
  `home_location_id` BIGINT UNSIGNED NULL,
  `current_location_id` BIGINT UNSIGNED NULL,
  `current_latitude` DECIMAL(10, 8) NULL,
  `current_longitude` DECIMAL(11, 8) NULL,
  `status` ENUM('available', 'busy', 'offline', 'on_break') NOT NULL DEFAULT 'offline',
  `rating` DECIMAL(3, 2) NOT NULL DEFAULT 0.00,
  `total_deliveries` INT NOT NULL DEFAULT 0,
  `successful_deliveries` INT NOT NULL DEFAULT 0,
  `cancelled_deliveries` INT NOT NULL DEFAULT 0,
  `date_of_birth` DATE NULL,
  `date_of_joining` DATE NOT NULL,
  `emergency_contact_name` VARCHAR(255) NULL,
  `emergency_contact_phone` VARCHAR(20) NULL,
  `bank_account` JSON NULL COMMENT 'Encrypted bank details',
  `is_active` BOOLEAN NOT NULL DEFAULT TRUE,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_employee_id` (`employee_id`),
  UNIQUE KEY `idx_phone` (`phone`),
  KEY `idx_status` (`status`),
  KEY `idx_home_location_id` (`home_location_id`),
  KEY `idx_current_location_id` (`current_location_id`),
  CONSTRAINT `fk_delivery_personnel_home_location` FOREIGN KEY (`home_location_id`) REFERENCES `locations` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_delivery_personnel_current_location` FOREIGN KEY (`current_location_id`) REFERENCES `locations` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 20: deliveries
CREATE TABLE `deliveries` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` BIGINT UNSIGNED NOT NULL,
  `delivery_person_id` BIGINT UNSIGNED NULL,
  `tracking_number` VARCHAR(100) NOT NULL,
  `status` ENUM('assigned', 'picked_up', 'in_transit', 'arrived', 'delivered', 'failed', 'returned') NOT NULL DEFAULT 'assigned',
  `pickup_location_id` BIGINT UNSIGNED NULL,
  `delivery_address` JSON NOT NULL COMMENT 'Full address details',
  `estimated_pickup_time` TIMESTAMP NULL,
  `actual_pickup_time` TIMESTAMP NULL,
  `estimated_delivery_time` TIMESTAMP NULL,
  `actual_delivery_time` TIMESTAMP NULL,
  `delivery_notes` TEXT NULL,
  `proof_of_delivery` JSON NULL COMMENT 'Photos, signature',
  `recipient_name` VARCHAR(255) NULL,
  `recipient_phone` VARCHAR(20) NULL,
  `distance_km` DECIMAL(6, 2) NULL,
  `delivery_fee` DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
  `failed_reason` TEXT NULL,
  `attempts` INT NOT NULL DEFAULT 0,
  `current_latitude` DECIMAL(10, 8) NULL,
  `current_longitude` DECIMAL(11, 8) NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_tracking_number` (`tracking_number`),
  UNIQUE KEY `idx_order_id` (`order_id`),
  KEY `idx_delivery_person_id` (`delivery_person_id`),
  KEY `idx_status` (`status`),
  KEY `idx_estimated_delivery_time` (`estimated_delivery_time`),
  CONSTRAINT `fk_deliveries_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_deliveries_person` FOREIGN KEY (`delivery_person_id`) REFERENCES `delivery_personnel` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_deliveries_pickup_location` FOREIGN KEY (`pickup_location_id`) REFERENCES `locations` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- SECTION 6: LOYALTY SYSTEM (Table 21)
-- =====================================================

-- Table 21: icecoins_wallet
CREATE TABLE `icecoins_wallet` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `balance` INT NOT NULL DEFAULT 0,
  `total_earned` INT NOT NULL DEFAULT 0,
  `total_spent` INT NOT NULL DEFAULT 0,
  `total_expired` INT NOT NULL DEFAULT 0,
  `lifetime_balance` INT NOT NULL DEFAULT 0,
  `pending_balance` INT NOT NULL DEFAULT 0 COMMENT 'Pending confirmation',
  `tier` ENUM('bronze', 'silver', 'gold', 'platinum', 'diamond') NOT NULL DEFAULT 'bronze',
  `tier_points` INT NOT NULL DEFAULT 0,
  `next_tier_points` INT NOT NULL DEFAULT 1000,
  `multiplier` DECIMAL(3, 2) NOT NULL DEFAULT 1.00 COMMENT 'Earning multiplier based on tier',
  `last_earned_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_id` (`user_id`),
  KEY `idx_tier` (`tier`),
  CONSTRAINT `fk_icecoins_wallet_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- INDEXES AND OPTIMIZATIONS
-- =====================================================

-- Composite indexes for common queries
CREATE INDEX `idx_orders_user_status` ON `orders` (`user_id`, `status`);
CREATE INDEX `idx_orders_user_created` ON `orders` (`user_id`, `created_at`);
CREATE INDEX `idx_products_category_status` ON `products` (`category_id`, `status`);
CREATE INDEX `idx_products_featured_status` ON `products` (`featured`, `status`);

-- =====================================================
-- END OF PHASE 1: MVP CORE TABLES
-- =====================================================

-- Success message for Phase 1
SELECT 'Phase 1 MVP Core Tables (21 tables) created successfully!' AS status;

-- =====================================================
-- PHASE 2: ENHANCED FEATURES (Tables 22-37)
-- =====================================================

-- =====================================================
-- SECTION 7: LOYALTY SYSTEM CONTINUED (Tables 22-25)
-- =====================================================

-- Table 22: icecoins_transactions
CREATE TABLE `icecoins_transactions` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `wallet_id` BIGINT UNSIGNED NOT NULL,
  `transaction_type` ENUM('earned', 'spent', 'expired', 'refunded', 'bonus', 'penalty', 'transferred') NOT NULL,
  `amount` INT NOT NULL,
  `balance_before` INT NOT NULL,
  `balance_after` INT NOT NULL,
  `source` ENUM('order', 'referral', 'challenge', 'review', 'signup_bonus', 'admin', 'promotion', 'redemption', 'expiry') NOT NULL,
  `source_id` BIGINT UNSIGNED NULL COMMENT 'Related entity ID (order, challenge, etc.)',
  `description` VARCHAR(500) NOT NULL,
  `metadata` JSON NULL,
  `expires_at` TIMESTAMP NULL,
  `is_pending` BOOLEAN NOT NULL DEFAULT FALSE,
  `processed_at` TIMESTAMP NULL,
  `reversed_at` TIMESTAMP NULL,
  `reversal_reason` TEXT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_wallet_id` (`wallet_id`),
  KEY `idx_transaction_type` (`transaction_type`),
  KEY `idx_source` (`source`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `fk_icecoins_transactions_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_icecoins_transactions_wallet` FOREIGN KEY (`wallet_id`) REFERENCES `icecoins_wallet` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 23: loyalty_tiers
CREATE TABLE `loyalty_tiers` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `tier_name` VARCHAR(100) NOT NULL,
  `tier_key` VARCHAR(50) NOT NULL,
  `min_points` INT NOT NULL,
  `max_points` INT NULL,
  `earning_multiplier` DECIMAL(3, 2) NOT NULL DEFAULT 1.00,
  `benefits` JSON NOT NULL COMMENT 'Array of tier benefits',
  `icon_url` VARCHAR(500) NULL,
  `badge_url` VARCHAR(500) NULL,
  `color_code` VARCHAR(7) NULL,
  `welcome_message` TEXT NULL,
  `discount_percentage` DECIMAL(5, 2) NOT NULL DEFAULT 0.00,
  `free_delivery_threshold` DECIMAL(10, 2) NULL,
  `priority_support` BOOLEAN NOT NULL DEFAULT FALSE,
  `early_access` BOOLEAN NOT NULL DEFAULT FALSE,
  `display_order` INT NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_tier_key` (`tier_key`),
  KEY `idx_min_points` (`min_points`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 24: reward_redemptions
CREATE TABLE `reward_redemptions` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `reward_type` ENUM('discount_coupon', 'free_product', 'free_delivery', 'cashback', 'gift_card', 'partner_voucher') NOT NULL,
  `reward_name` VARCHAR(255) NOT NULL,
  `icecoins_required` INT NOT NULL,
  `icecoins_spent` INT NOT NULL,
  `reward_value` DECIMAL(10, 2) NOT NULL,
  `reward_code` VARCHAR(100) NULL,
  `reward_details` JSON NULL,
  `status` ENUM('pending', 'active', 'used', 'expired', 'cancelled') NOT NULL DEFAULT 'pending',
  `valid_from` TIMESTAMP NOT NULL,
  `valid_until` TIMESTAMP NOT NULL,
  `used_at` TIMESTAMP NULL,
  `used_on_order_id` BIGINT UNSIGNED NULL,
  `terms_conditions` TEXT NULL,
  `partner_name` VARCHAR(255) NULL,
  `notes` TEXT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_reward_code` (`reward_code`),
  KEY `idx_status` (`status`),
  KEY `idx_valid_until` (`valid_until`),
  CONSTRAINT `fk_reward_redemptions_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_reward_redemptions_order` FOREIGN KEY (`used_on_order_id`) REFERENCES `orders` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 25: challenges
CREATE TABLE `challenges` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `challenge_key` VARCHAR(100) NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `description` TEXT NOT NULL,
  `challenge_type` ENUM('ordering', 'spending', 'recipe', 'review', 'social', 'streak', 'referral', 'special') NOT NULL,
  `difficulty` ENUM('easy', 'medium', 'hard', 'expert') NOT NULL DEFAULT 'medium',
  `goal_type` VARCHAR(100) NOT NULL COMMENT 'orders_count, total_spent, recipes_tried, etc.',
  `goal_value` DECIMAL(10, 2) NOT NULL,
  `goal_unit` VARCHAR(50) NOT NULL,
  `reward_icecoins` INT NOT NULL DEFAULT 0,
  `reward_badge_id` BIGINT UNSIGNED NULL,
  `reward_description` VARCHAR(500) NULL,
  `icon_url` VARCHAR(500) NULL,
  `banner_url` VARCHAR(500) NULL,
  `is_recurring` BOOLEAN NOT NULL DEFAULT FALSE,
  `recurrence_type` ENUM('daily', 'weekly', 'monthly') NULL,
  `start_date` TIMESTAMP NOT NULL,
  `end_date` TIMESTAMP NULL,
  `max_participants` INT NULL,
  `current_participants` INT NOT NULL DEFAULT 0,
  `is_active` BOOLEAN NOT NULL DEFAULT TRUE,
  `is_featured` BOOLEAN NOT NULL DEFAULT FALSE,
  `category` VARCHAR(100) NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_challenge_key` (`challenge_key`),
  KEY `idx_challenge_type` (`challenge_type`),
  KEY `idx_is_active` (`is_active`),
  KEY `idx_start_date` (`start_date`),
  KEY `idx_end_date` (`end_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 26: user_challenges
CREATE TABLE `user_challenges` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `challenge_id` BIGINT UNSIGNED NOT NULL,
  `status` ENUM('enrolled', 'in_progress', 'completed', 'failed', 'abandoned') NOT NULL DEFAULT 'enrolled',
  `progress_value` DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
  `goal_value` DECIMAL(10, 2) NOT NULL,
  `progress_percentage` DECIMAL(5, 2) NOT NULL DEFAULT 0.00,
  `started_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `completed_at` TIMESTAMP NULL,
  `reward_claimed` BOOLEAN NOT NULL DEFAULT FALSE,
  `reward_claimed_at` TIMESTAMP NULL,
  `icecoins_earned` INT NOT NULL DEFAULT 0,
  `attempts` INT NOT NULL DEFAULT 1,
  `last_activity_at` TIMESTAMP NULL,
  `metadata` JSON NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_challenge` (`user_id`, `challenge_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_challenge_id` (`challenge_id`),
  KEY `idx_status` (`status`),
  CONSTRAINT `fk_user_challenges_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_user_challenges_challenge` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 27: challenge_progress_events
CREATE TABLE `challenge_progress_events` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_challenge_id` BIGINT UNSIGNED NOT NULL,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `challenge_id` BIGINT UNSIGNED NOT NULL,
  `event_type` VARCHAR(100) NOT NULL,
  `progress_increment` DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
  `new_progress_value` DECIMAL(10, 2) NOT NULL,
  `source_id` BIGINT UNSIGNED NULL,
  `source_type` VARCHAR(100) NULL,
  `metadata` JSON NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_challenge_id` (`user_challenge_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_challenge_id` (`challenge_id`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `fk_challenge_progress_user_challenge` FOREIGN KEY (`user_challenge_id`) REFERENCES `user_challenges` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_challenge_progress_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_challenge_progress_challenge` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- SECTION 8: REVIEWS & RATINGS (Tables 28-30)
-- =====================================================

-- Table 28: reviews
CREATE TABLE `reviews` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `product_id` BIGINT UNSIGNED NOT NULL,
  `order_id` BIGINT UNSIGNED NULL,
  `rating` DECIMAL(3, 2) NOT NULL COMMENT 'Rating 1.00 to 5.00',
  `title` VARCHAR(255) NULL,
  `comment` TEXT NULL,
  `pros` TEXT NULL,
  `cons` TEXT NULL,
  `photos` JSON NULL COMMENT 'Array of photo URLs',
  `videos` JSON NULL COMMENT 'Array of video URLs',
  `verified_purchase` BOOLEAN NOT NULL DEFAULT FALSE,
  `is_featured` BOOLEAN NOT NULL DEFAULT FALSE,
  `helpful_count` INT NOT NULL DEFAULT 0,
  `not_helpful_count` INT NOT NULL DEFAULT 0,
  `response_count` INT NOT NULL DEFAULT 0,
  `status` ENUM('pending', 'approved', 'rejected', 'flagged') NOT NULL DEFAULT 'pending',
  `moderation_notes` TEXT NULL,
  `moderated_by` BIGINT UNSIGNED NULL,
  `moderated_at` TIMESTAMP NULL,
  `icecoins_earned` INT NOT NULL DEFAULT 0,
  `sentiment` ENUM('positive', 'neutral', 'negative') NULL,
  `flagged_count` INT NOT NULL DEFAULT 0,
  `flagged_reasons` JSON NULL,
  `edited_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_product_id` (`product_id`),
  KEY `idx_order_id` (`order_id`),
  KEY `idx_rating` (`rating`),
  KEY `idx_status` (`status`),
  KEY `idx_verified_purchase` (`verified_purchase`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `fk_reviews_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_reviews_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_reviews_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 29: review_responses
CREATE TABLE `review_responses` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `review_id` BIGINT UNSIGNED NOT NULL,
  `responder_id` BIGINT UNSIGNED NOT NULL,
  `responder_type` ENUM('brand', 'admin', 'vendor') NOT NULL,
  `response` TEXT NOT NULL,
  `is_official` BOOLEAN NOT NULL DEFAULT TRUE,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_review_id` (`review_id`),
  KEY `idx_responder_id` (`responder_id`),
  CONSTRAINT `fk_review_responses_review` FOREIGN KEY (`review_id`) REFERENCES `reviews` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 30: review_votes
CREATE TABLE `review_votes` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `review_id` BIGINT UNSIGNED NOT NULL,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `vote_type` ENUM('helpful', 'not_helpful') NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_review_user` (`review_id`, `user_id`),
  KEY `idx_review_id` (`review_id`),
  KEY `idx_user_id` (`user_id`),
  CONSTRAINT `fk_review_votes_review` FOREIGN KEY (`review_id`) REFERENCES `reviews` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_review_votes_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- SECTION 9: REFERRALS (Table 31)
-- =====================================================

-- Table 31: referrals
CREATE TABLE `referrals` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `referrer_id` BIGINT UNSIGNED NOT NULL,
  `referred_id` BIGINT UNSIGNED NULL,
  `referral_code` VARCHAR(100) NOT NULL,
  `referral_method` ENUM('code', 'link', 'email', 'sms', 'social', 'qr_code') NOT NULL,
  `channel` VARCHAR(100) NULL COMMENT 'facebook, whatsapp, email, etc.',
  `status` ENUM('pending', 'registered', 'completed', 'expired', 'cancelled') NOT NULL DEFAULT 'pending',
  `referred_email` VARCHAR(255) NULL,
  `referred_phone` VARCHAR(20) NULL,
  `registered_at` TIMESTAMP NULL,
  `first_order_at` TIMESTAMP NULL,
  `first_order_id` BIGINT UNSIGNED NULL,
  `referrer_reward` INT NOT NULL DEFAULT 0 COMMENT 'IceCoins for referrer',
  `referred_reward` INT NOT NULL DEFAULT 0 COMMENT 'IceCoins for referred',
  `referrer_reward_claimed` BOOLEAN NOT NULL DEFAULT FALSE,
  `referred_reward_claimed` BOOLEAN NOT NULL DEFAULT FALSE,
  `referrer_reward_claimed_at` TIMESTAMP NULL,
  `referred_reward_claimed_at` TIMESTAMP NULL,
  `conversion_value` DECIMAL(10, 2) NULL COMMENT 'First order value',
  `expires_at` TIMESTAMP NULL,
  `metadata` JSON NULL,
  `ip_address` VARCHAR(45) NULL,
  `user_agent` TEXT NULL,
  `notes` TEXT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_referral_code` (`referral_code`),
  KEY `idx_referrer_id` (`referrer_id`),
  KEY `idx_referred_id` (`referred_id`),
  KEY `idx_status` (`status`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `fk_referrals_referrer` FOREIGN KEY (`referrer_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_referrals_referred` FOREIGN KEY (`referred_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_referrals_order` FOREIGN KEY (`first_order_id`) REFERENCES `orders` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- SECTION 10: PROMOTIONS (Tables 32-33)
-- =====================================================

-- Table 32: promotions
CREATE TABLE `promotions` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `promotion_code` VARCHAR(100) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `description` TEXT NULL,
  `promotion_type` ENUM('percentage_discount', 'fixed_discount', 'buy_x_get_y', 'free_shipping', 'bundle_deal', 'cashback', 'icecoins_bonus') NOT NULL,
  `discount_type` ENUM('percentage', 'fixed_amount') NULL,
  `discount_value` DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
  `max_discount_amount` DECIMAL(10, 2) NULL,
  `min_order_amount` DECIMAL(10, 2) NULL,
  `max_uses_total` INT NULL COMMENT 'Total times code can be used',
  `max_uses_per_user` INT NOT NULL DEFAULT 1,
  `current_uses` INT NOT NULL DEFAULT 0,
  `applicable_products` JSON NULL COMMENT 'Array of product IDs',
  `applicable_categories` JSON NULL COMMENT 'Array of category IDs',
  `excluded_products` JSON NULL,
  `excluded_categories` JSON NULL,
  `applicable_user_tiers` JSON NULL COMMENT 'Array of tier names',
  `new_users_only` BOOLEAN NOT NULL DEFAULT FALSE,
  `start_date` TIMESTAMP NOT NULL,
  `end_date` TIMESTAMP NOT NULL,
  `is_active` BOOLEAN NOT NULL DEFAULT TRUE,
  `is_public` BOOLEAN NOT NULL DEFAULT TRUE,
  `is_stackable` BOOLEAN NOT NULL DEFAULT FALSE COMMENT 'Can be combined with other offers',
  `banner_url` VARCHAR(500) NULL,
  `terms_conditions` TEXT NULL,
  `priority` INT NOT NULL DEFAULT 0,
  `created_by` BIGINT UNSIGNED NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_promotion_code` (`promotion_code`),
  KEY `idx_promotion_type` (`promotion_type`),
  KEY `idx_is_active` (`is_active`),
  KEY `idx_start_date` (`start_date`),
  KEY `idx_end_date` (`end_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 33: promotion_usage
CREATE TABLE `promotion_usage` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `promotion_id` BIGINT UNSIGNED NOT NULL,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `order_id` BIGINT UNSIGNED NOT NULL,
  `discount_amount` DECIMAL(10, 2) NOT NULL,
  `order_amount` DECIMAL(10, 2) NOT NULL,
  `used_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `metadata` JSON NULL,
  PRIMARY KEY (`id`),
  KEY `idx_promotion_id` (`promotion_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_order_id` (`order_id`),
  KEY `idx_used_at` (`used_at`),
  CONSTRAINT `fk_promotion_usage_promotion` FOREIGN KEY (`promotion_id`) REFERENCES `promotions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_promotion_usage_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_promotion_usage_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- SECTION 11: NOTIFICATIONS (Tables 34-35)
-- =====================================================

-- Table 34: notifications
CREATE TABLE `notifications` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `notification_type` ENUM('order', 'payment', 'delivery', 'promotion', 'social', 'system', 'achievement', 'reminder') NOT NULL,
  `channel` ENUM('in_app', 'push', 'email', 'sms') NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `message` TEXT NOT NULL,
  `action_url` VARCHAR(500) NULL,
  `action_type` VARCHAR(100) NULL,
  `icon` VARCHAR(500) NULL,
  `image_url` VARCHAR(500) NULL,
  `data` JSON NULL,
  `priority` ENUM('low', 'normal', 'high', 'urgent') NOT NULL DEFAULT 'normal',
  `is_read` BOOLEAN NOT NULL DEFAULT FALSE,
  `read_at` TIMESTAMP NULL,
  `is_sent` BOOLEAN NOT NULL DEFAULT FALSE,
  `sent_at` TIMESTAMP NULL,
  `scheduled_for` TIMESTAMP NULL,
  `expires_at` TIMESTAMP NULL,
  `related_entity_type` VARCHAR(100) NULL,
  `related_entity_id` BIGINT UNSIGNED NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_notification_type` (`notification_type`),
  KEY `idx_channel` (`channel`),
  KEY `idx_is_read` (`is_read`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `fk_notifications_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 35: notification_templates
CREATE TABLE `notification_templates` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `template_key` VARCHAR(100) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `notification_type` ENUM('order', 'payment', 'delivery', 'promotion', 'social', 'system', 'achievement', 'reminder') NOT NULL,
  `channels` JSON NOT NULL COMMENT 'Array of enabled channels',
  `title_template` VARCHAR(500) NOT NULL,
  `message_template` TEXT NOT NULL,
  `variables` JSON NOT NULL COMMENT 'Available template variables',
  `action_url_template` VARCHAR(500) NULL,
  `icon` VARCHAR(500) NULL,
  `priority` ENUM('low', 'normal', 'high', 'urgent') NOT NULL DEFAULT 'normal',
  `is_active` BOOLEAN NOT NULL DEFAULT TRUE,
  `language` VARCHAR(10) NOT NULL DEFAULT 'en',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_template_key` (`template_key`),
  KEY `idx_notification_type` (`notification_type`),
  KEY `idx_is_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- SECTION 12: RECIPES (Tables 36-37)
-- =====================================================

-- Table 36: recipes
CREATE TABLE `recipes` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `creator_id` BIGINT UNSIGNED NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `slug` VARCHAR(255) NOT NULL,
  `description` TEXT NULL,
  `prep_time` INT NULL COMMENT 'Minutes',
  `cook_time` INT NULL COMMENT 'Minutes',
  `total_time` INT NULL COMMENT 'Minutes',
  `servings` INT NULL,
  `difficulty` ENUM('easy', 'medium', 'hard') NOT NULL DEFAULT 'medium',
  `cuisine_type` VARCHAR(100) NULL,
  `meal_type` ENUM('breakfast', 'lunch', 'dinner', 'snack', 'dessert', 'beverage') NULL,
  `dietary_tags` JSON NULL COMMENT 'vegetarian, vegan, gluten-free, etc.',
  `ingredients` JSON NOT NULL COMMENT 'Array of ingredient objects',
  `instructions` JSON NOT NULL COMMENT 'Array of step objects',
  `tips` TEXT NULL,
  `featured_image` VARCHAR(500) NULL,
  `gallery_images` JSON NULL,
  `video_url` VARCHAR(500) NULL,
  `nutrition_per_serving` JSON NULL,
  `estimated_cost` DECIMAL(10, 2) NULL,
  `status` ENUM('draft', 'pending_review', 'published', 'rejected', 'archived') NOT NULL DEFAULT 'draft',
  `views_count` INT NOT NULL DEFAULT 0,
  `tries_count` INT NOT NULL DEFAULT 0,
  `saves_count` INT NOT NULL DEFAULT 0,
  `rating` DECIMAL(3, 2) NOT NULL DEFAULT 0.00,
  `rating_count` INT NOT NULL DEFAULT 0,
  `is_featured` BOOLEAN NOT NULL DEFAULT FALSE,
  `is_verified` BOOLEAN NOT NULL DEFAULT FALSE,
  `verified_by` BIGINT UNSIGNED NULL,
  `verified_at` TIMESTAMP NULL,
  `published_at` TIMESTAMP NULL,
  `icecoins_earned` INT NOT NULL DEFAULT 0,
  `tags` JSON NULL,
  `source_url` VARCHAR(500) NULL,
  `meta_title` VARCHAR(255) NULL,
  `meta_description` VARCHAR(500) NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_slug` (`slug`),
  KEY `idx_creator_id` (`creator_id`),
  KEY `idx_status` (`status`),
  KEY `idx_is_featured` (`is_featured`),
  KEY `idx_rating` (`rating`),
  KEY `idx_published_at` (`published_at`),
  CONSTRAINT `fk_recipes_creator` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 37: recipe_products
CREATE TABLE `recipe_products` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `recipe_id` BIGINT UNSIGNED NOT NULL,
  `product_id` BIGINT UNSIGNED NOT NULL,
  `quantity` DECIMAL(10, 2) NOT NULL,
  `unit` VARCHAR(50) NOT NULL,
  `is_optional` BOOLEAN NOT NULL DEFAULT FALSE,
  `notes` VARCHAR(500) NULL,
  `display_order` INT NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_recipe_id` (`recipe_id`),
  KEY `idx_product_id` (`product_id`),
  CONSTRAINT `fk_recipe_products_recipe` FOREIGN KEY (`recipe_id`) REFERENCES `recipes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_recipe_products_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- INDEXES AND OPTIMIZATIONS FOR PHASE 2
-- =====================================================

-- Composite indexes for Phase 2
CREATE INDEX `idx_icecoins_transactions_user_type` ON `icecoins_transactions` (`user_id`, `transaction_type`);
CREATE INDEX `idx_reviews_product_status` ON `reviews` (`product_id`, `status`);
CREATE INDEX `idx_reviews_product_rating` ON `reviews` (`product_id`, `rating`);
CREATE INDEX `idx_recipes_status_published` ON `recipes` (`status`, `published_at`);

-- =====================================================
-- END OF PHASE 2: ENHANCED FEATURES
-- =====================================================

-- Success message for Phase 2
SELECT 'Phase 2 Enhanced Features (16 tables, Total: 37 tables) created successfully!' AS status;

-- =====================================================
-- PHASE 3: ADVANCED FEATURES (Tables 38-55)
-- =====================================================

-- =====================================================
-- SECTION 13: RECIPE FEATURES CONTINUED (Tables 38-40)
-- =====================================================

-- Table 38: recipe_tries
CREATE TABLE `recipe_tries` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `recipe_id` BIGINT UNSIGNED NOT NULL,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `rating` DECIMAL(3, 2) NULL COMMENT 'User rating 1.00 to 5.00',
  `review` TEXT NULL,
  `photos` JSON NULL COMMENT 'User''s photos of their attempt',
  `modifications` TEXT NULL COMMENT 'What user changed',
  `would_make_again` BOOLEAN NULL,
  `difficulty_rating` ENUM('easier', 'as_expected', 'harder') NULL,
  `time_taken` INT NULL COMMENT 'Minutes',
  `success` BOOLEAN NULL,
  `tips` TEXT NULL,
  `is_public` BOOLEAN NOT NULL DEFAULT TRUE,
  `icecoins_earned` INT NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_recipe_id` (`recipe_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_rating` (`rating`),
  CONSTRAINT `fk_recipe_tries_recipe` FOREIGN KEY (`recipe_id`) REFERENCES `recipes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_recipe_tries_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 39: recipe_saves
CREATE TABLE `recipe_saves` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `recipe_id` BIGINT UNSIGNED NOT NULL,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `collection_id` BIGINT UNSIGNED NULL,
  `notes` TEXT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_recipe_user` (`recipe_id`, `user_id`),
  KEY `idx_recipe_id` (`recipe_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_collection_id` (`collection_id`),
  CONSTRAINT `fk_recipe_saves_recipe` FOREIGN KEY (`recipe_id`) REFERENCES `recipes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_recipe_saves_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 40: recipe_collections
CREATE TABLE `recipe_collections` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `description` TEXT NULL,
  `cover_image` VARCHAR(500) NULL,
  `is_public` BOOLEAN NOT NULL DEFAULT FALSE,
  `recipe_count` INT NOT NULL DEFAULT 0,
  `display_order` INT NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_is_public` (`is_public`),
  CONSTRAINT `fk_recipe_collections_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add foreign key for recipe_saves.collection_id
ALTER TABLE `recipe_saves` 
ADD CONSTRAINT `fk_recipe_saves_collection` FOREIGN KEY (`collection_id`) REFERENCES `recipe_collections` (`id`) ON DELETE SET NULL;

-- =====================================================
-- SECTION 14: SOCIAL FEATURES (Tables 41-44)
-- =====================================================

-- Table 41: user_follows
CREATE TABLE `user_follows` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `follower_id` BIGINT UNSIGNED NOT NULL,
  `following_id` BIGINT UNSIGNED NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_follower_following` (`follower_id`, `following_id`),
  KEY `idx_follower_id` (`follower_id`),
  KEY `idx_following_id` (`following_id`),
  CONSTRAINT `fk_user_follows_follower` FOREIGN KEY (`follower_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_user_follows_following` FOREIGN KEY (`following_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 42: user_posts
CREATE TABLE `user_posts` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `post_type` ENUM('text', 'image', 'video', 'recipe_share', 'product_review', 'achievement', 'poll') NOT NULL,
  `content` TEXT NULL,
  `media_urls` JSON NULL COMMENT 'Array of image/video URLs',
  `related_recipe_id` BIGINT UNSIGNED NULL,
  `related_product_id` BIGINT UNSIGNED NULL,
  `related_review_id` BIGINT UNSIGNED NULL,
  `visibility` ENUM('public', 'followers', 'private') NOT NULL DEFAULT 'public',
  `likes_count` INT NOT NULL DEFAULT 0,
  `comments_count` INT NOT NULL DEFAULT 0,
  `shares_count` INT NOT NULL DEFAULT 0,
  `is_pinned` BOOLEAN NOT NULL DEFAULT FALSE,
  `tags` JSON NULL,
  `location` VARCHAR(255) NULL,
  `status` ENUM('active', 'hidden', 'deleted', 'flagged') NOT NULL DEFAULT 'active',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_post_type` (`post_type`),
  KEY `idx_visibility` (`visibility`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `fk_user_posts_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_user_posts_recipe` FOREIGN KEY (`related_recipe_id`) REFERENCES `recipes` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_user_posts_product` FOREIGN KEY (`related_product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_user_posts_review` FOREIGN KEY (`related_review_id`) REFERENCES `reviews` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 43: post_likes
CREATE TABLE `post_likes` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `post_id` BIGINT UNSIGNED NOT NULL,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `reaction_type` ENUM('like', 'love', 'wow', 'sad', 'angry') NOT NULL DEFAULT 'like',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_post_user` (`post_id`, `user_id`),
  KEY `idx_post_id` (`post_id`),
  KEY `idx_user_id` (`user_id`),
  CONSTRAINT `fk_post_likes_post` FOREIGN KEY (`post_id`) REFERENCES `user_posts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_post_likes_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 44: post_comments
CREATE TABLE `post_comments` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `post_id` BIGINT UNSIGNED NOT NULL,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `parent_comment_id` BIGINT UNSIGNED NULL COMMENT 'For nested replies',
  `comment` TEXT NOT NULL,
  `media_url` VARCHAR(500) NULL,
  `likes_count` INT NOT NULL DEFAULT 0,
  `replies_count` INT NOT NULL DEFAULT 0,
  `is_edited` BOOLEAN NOT NULL DEFAULT FALSE,
  `edited_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  KEY `idx_post_id` (`post_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_parent_comment_id` (`parent_comment_id`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `fk_post_comments_post` FOREIGN KEY (`post_id`) REFERENCES `user_posts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_post_comments_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_post_comments_parent` FOREIGN KEY (`parent_comment_id`) REFERENCES `post_comments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- SECTION 15: DIGITAL PASSPORT (Tables 45-47)
-- =====================================================

-- Table 45: digital_passports
CREATE TABLE `digital_passports` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_id` BIGINT UNSIGNED NOT NULL,
  `batch_number` VARCHAR(100) NOT NULL,
  `serial_number` VARCHAR(100) NOT NULL,
  `qr_code` VARCHAR(255) NOT NULL,
  `blockchain_hash` VARCHAR(255) NULL COMMENT 'For immutability verification',
  `manufacturing_date` DATE NOT NULL,
  `expiry_date` DATE NULL,
  `origin_location` JSON NOT NULL COMMENT 'Farm, factory details',
  `certifications` JSON NULL COMMENT 'Organic, halal, etc.',
  `supply_chain_stages` JSON NOT NULL COMMENT 'Array of supply chain steps',
  `quality_checks` JSON NULL,
  `temperature_logs` JSON NULL COMMENT 'For cold chain products',
  `sustainability_score` DECIMAL(3, 2) NULL COMMENT 'Score 0-5',
  `carbon_footprint` DECIMAL(10, 2) NULL COMMENT 'kg CO2',
  `water_usage` DECIMAL(10, 2) NULL COMMENT 'Liters',
  `farmer_info` JSON NULL,
  `certifying_body` VARCHAR(255) NULL,
  `certificate_number` VARCHAR(100) NULL,
  `certificate_url` VARCHAR(500) NULL,
  `is_verified` BOOLEAN NOT NULL DEFAULT FALSE,
  `verified_by` VARCHAR(255) NULL,
  `verified_at` TIMESTAMP NULL,
  `total_scans` INT NOT NULL DEFAULT 0,
  `unique_scanners` INT NOT NULL DEFAULT 0,
  `last_scanned_at` TIMESTAMP NULL,
  `status` ENUM('active', 'expired', 'recalled', 'verified', 'suspicious') NOT NULL DEFAULT 'active',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_qr_code` (`qr_code`),
  UNIQUE KEY `idx_batch_serial` (`batch_number`, `serial_number`),
  KEY `idx_product_id` (`product_id`),
  KEY `idx_status` (`status`),
  CONSTRAINT `fk_digital_passports_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 46: passport_scans
CREATE TABLE `passport_scans` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `passport_id` BIGINT UNSIGNED NOT NULL,
  `user_id` BIGINT UNSIGNED NULL,
  `scan_location` VARCHAR(255) NULL,
  `latitude` DECIMAL(10, 8) NULL,
  `longitude` DECIMAL(11, 8) NULL,
  `device_info` JSON NULL,
  `ip_address` VARCHAR(45) NULL,
  `scan_type` ENUM('consumer', 'retailer', 'inspector', 'system') NOT NULL DEFAULT 'consumer',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_passport_id` (`passport_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `fk_passport_scans_passport` FOREIGN KEY (`passport_id`) REFERENCES `digital_passports` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_passport_scans_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 47: sustainability_reports
CREATE TABLE `sustainability_reports` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_id` BIGINT UNSIGNED NOT NULL,
  `report_period` VARCHAR(100) NOT NULL COMMENT 'Q1 2025, 2025, etc.',
  `carbon_footprint` DECIMAL(12, 2) NOT NULL COMMENT 'Total kg CO2',
  `water_usage` DECIMAL(12, 2) NOT NULL COMMENT 'Total liters',
  `energy_consumption` DECIMAL(12, 2) NULL COMMENT 'kWh',
  `renewable_energy_percentage` DECIMAL(5, 2) NULL,
  `waste_generated` DECIMAL(12, 2) NULL COMMENT 'kg',
  `waste_recycled` DECIMAL(12, 2) NULL COMMENT 'kg',
  `packaging_recyclable` BOOLEAN NOT NULL DEFAULT FALSE,
  `packaging_biodegradable` BOOLEAN NOT NULL DEFAULT FALSE,
  `local_sourcing_percentage` DECIMAL(5, 2) NULL,
  `fair_trade_certified` BOOLEAN NOT NULL DEFAULT FALSE,
  `organic_certified` BOOLEAN NOT NULL DEFAULT FALSE,
  `social_impact_score` DECIMAL(3, 2) NULL COMMENT 'Score 0-5',
  `environmental_impact_score` DECIMAL(3, 2) NULL COMMENT 'Score 0-5',
  `overall_sustainability_score` DECIMAL(3, 2) NULL COMMENT 'Score 0-5',
  `improvements` TEXT NULL,
  `goals` TEXT NULL,
  `report_url` VARCHAR(500) NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_product_id` (`product_id`),
  KEY `idx_overall_score` (`overall_sustainability_score`),
  CONSTRAINT `fk_sustainability_reports_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- SECTION 16: CUSTOM BOXES (Tables 48-49)
-- =====================================================

-- Table 48: custom_boxes
CREATE TABLE `custom_boxes` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `box_name` VARCHAR(255) NOT NULL,
  `box_type` ENUM('weekly', 'monthly', 'custom', 'gift') NOT NULL,
  `description` TEXT NULL,
  `frequency` ENUM('one_time', 'weekly', 'bi_weekly', 'monthly') NOT NULL DEFAULT 'one_time',
  `price` DECIMAL(10, 2) NOT NULL,
  `discount_percentage` DECIMAL(5, 2) NOT NULL DEFAULT 0.00,
  `total_items` INT NOT NULL DEFAULT 0,
  `delivery_day` ENUM('monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday') NULL,
  `next_delivery_date` DATE NULL,
  `status` ENUM('active', 'paused', 'cancelled', 'completed') NOT NULL DEFAULT 'active',
  `is_gift` BOOLEAN NOT NULL DEFAULT FALSE,
  `gift_message` TEXT NULL,
  `gift_recipient_name` VARCHAR(255) NULL,
  `gift_recipient_phone` VARCHAR(20) NULL,
  `subscription_start_date` DATE NULL,
  `subscription_end_date` DATE NULL,
  `auto_renew` BOOLEAN NOT NULL DEFAULT TRUE,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_status` (`status`),
  KEY `idx_next_delivery_date` (`next_delivery_date`),
  CONSTRAINT `fk_custom_boxes_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 49: custom_box_items
CREATE TABLE `custom_box_items` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `box_id` BIGINT UNSIGNED NOT NULL,
  `product_id` BIGINT UNSIGNED NOT NULL,
  `quantity` INT NOT NULL,
  `unit_price` DECIMAL(10, 2) NOT NULL,
  `subtotal` DECIMAL(10, 2) NOT NULL,
  `is_substitutable` BOOLEAN NOT NULL DEFAULT TRUE,
  `notes` TEXT NULL,
  `display_order` INT NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_box_id` (`box_id`),
  KEY `idx_product_id` (`product_id`),
  CONSTRAINT `fk_custom_box_items_box` FOREIGN KEY (`box_id`) REFERENCES `custom_boxes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_custom_box_items_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- SECTION 17: STOCK NOTIFICATIONS (Table 50)
-- =====================================================

-- Table 50: stock_notifications
CREATE TABLE `stock_notifications` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `product_id` BIGINT UNSIGNED NOT NULL,
  `notification_type` ENUM('back_in_stock', 'low_stock', 'price_drop') NOT NULL,
  `status` ENUM('pending', 'sent', 'expired', 'cancelled') NOT NULL DEFAULT 'pending',
  `threshold_price` DECIMAL(10, 2) NULL COMMENT 'For price drop alerts',
  `notified_at` TIMESTAMP NULL,
  `expires_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_product_id` (`product_id`),
  KEY `idx_status` (`status`),
  KEY `idx_notification_type` (`notification_type`),
  CONSTRAINT `fk_stock_notifications_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_stock_notifications_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- SECTION 18: HEALTH TRACKING (Tables 51-52)
-- =====================================================

-- Table 51: health_goals
CREATE TABLE `health_goals` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `goal_type` ENUM('calorie_limit', 'sugar_reduction', 'protein_intake', 'low_carb', 'weight_management', 'fitness') NOT NULL,
  `goal_name` VARCHAR(255) NOT NULL,
  `target_value` DECIMAL(10, 2) NOT NULL,
  `target_unit` VARCHAR(50) NOT NULL,
  `current_value` DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
  `timeframe` ENUM('daily', 'weekly', 'monthly', 'custom') NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NULL,
  `status` ENUM('active', 'completed', 'paused', 'abandoned') NOT NULL DEFAULT 'active',
  `reminder_enabled` BOOLEAN NOT NULL DEFAULT TRUE,
  `reminder_time` TIME NULL,
  `progress_percentage` DECIMAL(5, 2) NOT NULL DEFAULT 0.00,
  `streak_days` INT NOT NULL DEFAULT 0,
  `best_streak` INT NOT NULL DEFAULT 0,
  `days_successful` INT NOT NULL DEFAULT 0,
  `days_failed` INT NOT NULL DEFAULT 0,
  `icecoins_earned` INT NOT NULL DEFAULT 0,
  `notes` TEXT NULL,
  `completed_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_goal_type` (`goal_type`),
  KEY `idx_status` (`status`),
  CONSTRAINT `fk_health_goals_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 52: health_goal_logs
CREATE TABLE `health_goal_logs` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `health_goal_id` BIGINT UNSIGNED NOT NULL,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `log_date` DATE NOT NULL,
  `recorded_value` DECIMAL(10, 2) NOT NULL,
  `target_value` DECIMAL(10, 2) NOT NULL,
  `goal_met` BOOLEAN NOT NULL,
  `variance` DECIMAL(10, 2) NOT NULL,
  `source` ENUM('manual', 'order_tracking', 'app_integration', 'system') NOT NULL DEFAULT 'manual',
  `orders_counted` JSON NULL,
  `products_consumed` JSON NULL,
  `nutrition_breakdown` JSON NULL,
  `notes` TEXT NULL,
  `mood` ENUM('great', 'good', 'okay', 'struggling', 'bad') NULL,
  `energy_level` INT NULL COMMENT '1-5 scale',
  `icecoins_earned` INT NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_goal_date` (`health_goal_id`, `log_date`),
  KEY `idx_health_goal_id` (`health_goal_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_log_date` (`log_date`),
  CONSTRAINT `fk_health_goal_logs_goal` FOREIGN KEY (`health_goal_id`) REFERENCES `health_goals` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_health_goal_logs_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- SECTION 19: GAMIFICATION (Tables 53-54)
-- =====================================================

-- Table 53: badges
CREATE TABLE `badges` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `badge_key` VARCHAR(100) NOT NULL,
  `badge_name` VARCHAR(255) NOT NULL,
  `description` TEXT NOT NULL,
  `badge_category` ENUM('ordering', 'social', 'recipes', 'reviews', 'sustainability', 'loyalty', 'challenges', 'special') NOT NULL,
  `rarity` ENUM('common', 'uncommon', 'rare', 'epic', 'legendary') NOT NULL DEFAULT 'common',
  `icon_url` VARCHAR(500) NOT NULL,
  `icon_locked_url` VARCHAR(500) NULL,
  `color_hex` VARCHAR(7) NOT NULL,
  `unlock_criteria` JSON NOT NULL,
  `unlock_message` VARCHAR(500) NULL,
  `reward_icecoins` INT NOT NULL DEFAULT 0,
  `is_secret` BOOLEAN NOT NULL DEFAULT FALSE,
  `is_limited_edition` BOOLEAN NOT NULL DEFAULT FALSE,
  `available_from` TIMESTAMP NULL,
  `available_until` TIMESTAMP NULL,
  `max_awards` INT NULL,
  `current_awards` INT NOT NULL DEFAULT 0,
  `display_priority` INT NOT NULL DEFAULT 0,
  `is_active` BOOLEAN NOT NULL DEFAULT TRUE,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_badge_key` (`badge_key`),
  KEY `idx_badge_category` (`badge_category`),
  KEY `idx_rarity` (`rarity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 54: user_badges
CREATE TABLE `user_badges` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `badge_id` BIGINT UNSIGNED NOT NULL,
  `earned_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `progress_data` JSON NULL,
  `icecoins_awarded` INT NOT NULL DEFAULT 0,
  `notification_sent` BOOLEAN NOT NULL DEFAULT FALSE,
  `is_pinned` BOOLEAN NOT NULL DEFAULT FALSE,
  `is_public` BOOLEAN NOT NULL DEFAULT TRUE,
  `shared_on_feed` BOOLEAN NOT NULL DEFAULT FALSE,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_badge` (`user_id`, `badge_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_badge_id` (`badge_id`),
  KEY `idx_earned_at` (`earned_at`),
  CONSTRAINT `fk_user_badges_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_user_badges_badge` FOREIGN KEY (`badge_id`) REFERENCES `badges` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 55: leaderboards
CREATE TABLE `leaderboards` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `leaderboard_key` VARCHAR(100) NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `description` TEXT NULL,
  `category` ENUM('spending', 'orders', 'recipes', 'reviews', 'social', 'sustainability', 'challenges') NOT NULL,
  `metric_type` VARCHAR(100) NOT NULL,
  `ranking_period` ENUM('all_time', 'monthly', 'weekly', 'daily', 'custom') NOT NULL,
  `start_date` TIMESTAMP NULL,
  `end_date` TIMESTAMP NULL,
  `min_entries` INT NOT NULL DEFAULT 1,
  `max_rank_display` INT NOT NULL DEFAULT 100,
  `reward_structure` JSON NULL,
  `icon_url` VARCHAR(500) NULL,
  `banner_url` VARCHAR(500) NULL,
  `is_active` BOOLEAN NOT NULL DEFAULT TRUE,
  `is_featured` BOOLEAN NOT NULL DEFAULT FALSE,
  `visibility` ENUM('public', 'tier_restricted', 'private') NOT NULL DEFAULT 'public',
  `tier_requirement` ENUM('bronze', 'silver', 'gold', 'platinum', 'diamond') NULL,
  `last_updated_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_leaderboard_key` (`leaderboard_key`),
  KEY `idx_category` (`category`),
  KEY `idx_is_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- INDEXES AND OPTIMIZATIONS FOR PHASE 3
-- =====================================================

-- Composite indexes for Phase 3
CREATE INDEX `idx_user_posts_user_created` ON `user_posts` (`user_id`, `created_at`);
CREATE INDEX `idx_digital_passports_product_status` ON `digital_passports` (`product_id`, `status`);
CREATE INDEX `idx_health_goal_logs_user_date` ON `health_goal_logs` (`user_id`, `log_date`);

-- =====================================================
-- END OF PHASE 3: ADVANCED FEATURES
-- =====================================================

-- Success message for Phase 3
SELECT 'Phase 3 Advanced Features (18 tables, Total: 55 tables) created successfully!' AS status;

-- =====================================================
-- PHASE 4: TRUST, ANALYTICS & ADMINISTRATION (Tables 56-70)
-- =====================================================

-- =====================================================
-- SECTION 20: LEADERBOARDS CONTINUED (Table 56)
-- =====================================================

-- Table 56: leaderboard_entries
CREATE TABLE `leaderboard_entries` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `leaderboard_id` BIGINT UNSIGNED NOT NULL,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `rank` INT NOT NULL,
  `previous_rank` INT NULL,
  `score` DECIMAL(15, 2) NOT NULL,
  `metric_value` DECIMAL(15, 2) NOT NULL,
  `metric_label` VARCHAR(255) NULL,
  `badge_url` VARCHAR(500) NULL,
  `movement` ENUM('up', 'down', 'same', 'new') NOT NULL DEFAULT 'new',
  `rank_change` INT NOT NULL DEFAULT 0,
  `percentile` DECIMAL(5, 2) NULL,
  `is_trending` BOOLEAN NOT NULL DEFAULT FALSE,
  `reward_earned` INT NOT NULL DEFAULT 0,
  `reward_claimed` BOOLEAN NOT NULL DEFAULT FALSE,
  `last_activity_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_leaderboard_user` (`leaderboard_id`, `user_id`),
  KEY `idx_leaderboard_rank` (`leaderboard_id`, `rank`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_score` (`score`),
  CONSTRAINT `fk_leaderboard_entries_leaderboard` FOREIGN KEY (`leaderboard_id`) REFERENCES `leaderboards` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_leaderboard_entries_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- SECTION 21: TRUST & VERIFICATION (Tables 57-58)
-- =====================================================

-- Table 57: user_verifications
CREATE TABLE `user_verifications` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `verification_type` ENUM('email', 'phone', 'identity', 'address', 'payment', 'social_media') NOT NULL,
  `verification_method` VARCHAR(100) NULL,
  `status` ENUM('pending', 'verified', 'failed', 'expired', 'revoked') NOT NULL DEFAULT 'pending',
  `verification_code` VARCHAR(100) NULL,
  `verification_token` VARCHAR(255) NULL,
  `document_type` VARCHAR(100) NULL COMMENT 'NID, Passport, Driving License',
  `document_number` VARCHAR(100) NULL,
  `document_front_url` VARCHAR(500) NULL,
  `document_back_url` VARCHAR(500) NULL,
  `selfie_url` VARCHAR(500) NULL,
  `verified_data` JSON NULL,
  `rejection_reason` TEXT NULL,
  `verified_by` BIGINT UNSIGNED NULL,
  `verified_at` TIMESTAMP NULL,
  `expires_at` TIMESTAMP NULL,
  `attempts` INT NOT NULL DEFAULT 0,
  `max_attempts` INT NOT NULL DEFAULT 3,
  `ip_address` VARCHAR(45) NULL,
  `device_info` JSON NULL,
  `metadata` JSON NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_verification_type` (`verification_type`),
  KEY `idx_status` (`status`),
  CONSTRAINT `fk_user_verifications_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 58: trust_scores
CREATE TABLE `trust_scores` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `overall_score` DECIMAL(5, 2) NOT NULL DEFAULT 0.00 COMMENT 'Score 0-100',
  `identity_verification_score` DECIMAL(5, 2) NOT NULL DEFAULT 0.00,
  `payment_reliability_score` DECIMAL(5, 2) NOT NULL DEFAULT 0.00,
  `order_history_score` DECIMAL(5, 2) NOT NULL DEFAULT 0.00,
  `review_credibility_score` DECIMAL(5, 2) NOT NULL DEFAULT 0.00,
  `community_contribution_score` DECIMAL(5, 2) NOT NULL DEFAULT 0.00,
  `account_age_score` DECIMAL(5, 2) NOT NULL DEFAULT 0.00,
  `total_orders` INT NOT NULL DEFAULT 0,
  `successful_orders` INT NOT NULL DEFAULT 0,
  `cancelled_orders` INT NOT NULL DEFAULT 0,
  `returned_orders` INT NOT NULL DEFAULT 0,
  `total_spent` DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
  `verified_purchases` INT NOT NULL DEFAULT 0,
  `helpful_reviews` INT NOT NULL DEFAULT 0,
  `reports_received` INT NOT NULL DEFAULT 0,
  `warnings_issued` INT NOT NULL DEFAULT 0,
  `trust_level` ENUM('new', 'bronze', 'silver', 'gold', 'platinum', 'trusted') NOT NULL DEFAULT 'new',
  `risk_flags` JSON NULL,
  `positive_factors` JSON NULL,
  `last_calculated_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_id` (`user_id`),
  KEY `idx_overall_score` (`overall_score`),
  KEY `idx_trust_level` (`trust_level`),
  CONSTRAINT `fk_trust_scores_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- SECTION 22: FEEDBACK SYSTEM (Tables 59-60)
-- =====================================================

-- Table 59: feedback
CREATE TABLE `feedback` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NULL,
  `feedback_type` ENUM('bug', 'feature_request', 'complaint', 'suggestion', 'compliment', 'question', 'other') NOT NULL,
  `category` VARCHAR(100) NULL,
  `subject` VARCHAR(255) NOT NULL,
  `description` TEXT NOT NULL,
  `priority` ENUM('low', 'medium', 'high', 'critical') NOT NULL DEFAULT 'medium',
  `status` ENUM('new', 'reviewing', 'in_progress', 'resolved', 'closed', 'rejected') NOT NULL DEFAULT 'new',
  `related_order_id` BIGINT UNSIGNED NULL,
  `related_product_id` BIGINT UNSIGNED NULL,
  `attachments` JSON NULL,
  `screenshots` JSON NULL,
  `device_info` JSON NULL,
  `app_version` VARCHAR(50) NULL,
  `platform` VARCHAR(50) NULL,
  `ip_address` VARCHAR(45) NULL,
  `user_agent` TEXT NULL,
  `sentiment` ENUM('positive', 'neutral', 'negative') NULL,
  `votes_helpful` INT NOT NULL DEFAULT 0,
  `is_public` BOOLEAN NOT NULL DEFAULT FALSE,
  `assigned_to` BIGINT UNSIGNED NULL,
  `resolved_at` TIMESTAMP NULL,
  `resolution_notes` TEXT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_feedback_type` (`feedback_type`),
  KEY `idx_status` (`status`),
  KEY `idx_priority` (`priority`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `fk_feedback_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_feedback_order` FOREIGN KEY (`related_order_id`) REFERENCES `orders` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_feedback_product` FOREIGN KEY (`related_product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 60: feedback_responses
CREATE TABLE `feedback_responses` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `feedback_id` BIGINT UNSIGNED NOT NULL,
  `responder_id` BIGINT UNSIGNED NOT NULL,
  `responder_type` ENUM('admin', 'support', 'system') NOT NULL,
  `response` TEXT NOT NULL,
  `is_internal` BOOLEAN NOT NULL DEFAULT FALSE,
  `attachments` JSON NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_feedback_id` (`feedback_id`),
  KEY `idx_responder_id` (`responder_id`),
  CONSTRAINT `fk_feedback_responses_feedback` FOREIGN KEY (`feedback_id`) REFERENCES `feedback` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- SECTION 23: ANALYTICS (Tables 61-67)
-- =====================================================

-- Table 61: page_views
CREATE TABLE `page_views` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NULL,
  `session_id` BIGINT UNSIGNED NULL,
  `page_url` VARCHAR(500) NOT NULL,
  `page_title` VARCHAR(255) NULL,
  `page_type` VARCHAR(100) NULL COMMENT 'home, product, category, checkout, etc.',
  `referrer_url` VARCHAR(500) NULL,
  `utm_source` VARCHAR(100) NULL,
  `utm_medium` VARCHAR(100) NULL,
  `utm_campaign` VARCHAR(100) NULL,
  `utm_term` VARCHAR(100) NULL,
  `utm_content` VARCHAR(100) NULL,
  `device_type` ENUM('desktop', 'mobile', 'tablet', 'other') NULL,
  `browser` VARCHAR(100) NULL,
  `os` VARCHAR(100) NULL,
  `ip_address` VARCHAR(45) NULL,
  `country` VARCHAR(100) NULL,
  `city` VARCHAR(100) NULL,
  `time_on_page` INT NULL COMMENT 'Seconds',
  `scroll_depth` INT NULL COMMENT 'Percentage',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_session_id` (`session_id`),
  KEY `idx_page_type` (`page_type`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `fk_page_views_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_page_views_session` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 62: user_activity_logs
CREATE TABLE `user_activity_logs` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `activity_type` VARCHAR(100) NOT NULL,
  `activity_category` VARCHAR(100) NULL,
  `description` TEXT NULL,
  `entity_type` VARCHAR(100) NULL COMMENT 'product, order, recipe, etc.',
  `entity_id` BIGINT UNSIGNED NULL,
  `metadata` JSON NULL,
  `ip_address` VARCHAR(45) NULL,
  `user_agent` TEXT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_activity_type` (`activity_type`),
  KEY `idx_entity` (`entity_type`, `entity_id`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `fk_user_activity_logs_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 63: search_queries
CREATE TABLE `search_queries` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NULL,
  `session_id` BIGINT UNSIGNED NULL,
  `query_text` VARCHAR(500) NOT NULL,
  `normalized_query` VARCHAR(500) NULL,
  `search_type` ENUM('product', 'recipe', 'general', 'voice') NOT NULL DEFAULT 'product',
  `filters_applied` JSON NULL,
  `sort_by` VARCHAR(100) NULL,
  `results_count` INT NOT NULL DEFAULT 0,
  `clicked_result_id` BIGINT UNSIGNED NULL,
  `clicked_result_position` INT NULL,
  `time_to_click` INT NULL COMMENT 'Milliseconds',
  `resulted_in_order` BOOLEAN NOT NULL DEFAULT FALSE,
  `order_id` BIGINT UNSIGNED NULL,
  `is_zero_results` BOOLEAN NOT NULL DEFAULT FALSE,
  `did_you_mean_shown` BOOLEAN NOT NULL DEFAULT FALSE,
  `suggested_query` VARCHAR(500) NULL,
  `ip_address` VARCHAR(45) NULL,
  `device_type` VARCHAR(50) NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_session_id` (`session_id`),
  KEY `idx_query_text` (`query_text`(255)),
  KEY `idx_is_zero_results` (`is_zero_results`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `fk_search_queries_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_search_queries_session` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_search_queries_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 64: search_results
CREATE TABLE `search_results` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `search_query_id` BIGINT UNSIGNED NOT NULL,
  `result_type` ENUM('product', 'recipe', 'category', 'content') NOT NULL,
  `result_id` BIGINT UNSIGNED NOT NULL,
  `result_position` INT NOT NULL,
  `relevance_score` DECIMAL(5, 4) NULL,
  `was_clicked` BOOLEAN NOT NULL DEFAULT FALSE,
  `click_timestamp` TIMESTAMP NULL,
  `time_visible` INT NULL COMMENT 'Milliseconds',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_search_query_id` (`search_query_id`),
  KEY `idx_result` (`result_type`, `result_id`),
  KEY `idx_was_clicked` (`was_clicked`),
  CONSTRAINT `fk_search_results_query` FOREIGN KEY (`search_query_id`) REFERENCES `search_queries` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 65: click_tracking
CREATE TABLE `click_tracking` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NULL,
  `session_id` BIGINT UNSIGNED NULL,
  `element_type` VARCHAR(100) NOT NULL COMMENT 'button, link, banner, product_card, etc.',
  `element_id` VARCHAR(255) NULL,
  `element_text` VARCHAR(500) NULL,
  `page_url` VARCHAR(500) NOT NULL,
  `target_url` VARCHAR(500) NULL,
  `section` VARCHAR(100) NULL,
  `campaign_id` VARCHAR(100) NULL,
  `position` INT NULL,
  `metadata` JSON NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_session_id` (`session_id`),
  KEY `idx_element_type` (`element_type`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `fk_click_tracking_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_click_tracking_session` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 66: cart_analytics
CREATE TABLE `cart_analytics` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NULL,
  `session_id` BIGINT UNSIGNED NULL,
  `event_type` ENUM('cart_viewed', 'item_added', 'item_removed', 'quantity_changed', 'cart_abandoned', 'checkout_started', 'checkout_completed') NOT NULL,
  `product_id` BIGINT UNSIGNED NULL,
  `quantity` INT NULL,
  `price` DECIMAL(10, 2) NULL,
  `cart_value` DECIMAL(10, 2) NULL,
  `cart_item_count` INT NULL,
  `source` VARCHAR(100) NULL COMMENT 'product_page, search, recommendation, etc.',
  `related_order_id` BIGINT UNSIGNED NULL,
  `time_in_cart` INT NULL COMMENT 'Seconds before action',
  `metadata` JSON NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_session_id` (`session_id`),
  KEY `idx_event_type` (`event_type`),
  KEY `idx_product_id` (`product_id`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `fk_cart_analytics_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_cart_analytics_session` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_cart_analytics_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_cart_analytics_order` FOREIGN KEY (`related_order_id`) REFERENCES `orders` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 67: conversion_tracking
CREATE TABLE `conversion_tracking` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NULL,
  `session_id` BIGINT UNSIGNED NULL,
  `conversion_type` ENUM('signup', 'first_order', 'repeat_order', 'subscription', 'referral', 'review', 'recipe_submission') NOT NULL,
  `order_id` BIGINT UNSIGNED NULL,
  `conversion_value` DECIMAL(10, 2) NULL,
  `attribution_source` VARCHAR(100) NULL,
  `attribution_medium` VARCHAR(100) NULL,
  `attribution_campaign` VARCHAR(100) NULL,
  `first_touch_source` VARCHAR(100) NULL,
  `first_touch_medium` VARCHAR(100) NULL,
  `last_touch_source` VARCHAR(100) NULL,
  `last_touch_medium` VARCHAR(100) NULL,
  `touchpoints` JSON NULL,
  `time_to_convert` INT NULL COMMENT 'Seconds from first visit',
  `page_views_before_conversion` INT NULL,
  `sessions_before_conversion` INT NULL,
  `metadata` JSON NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_session_id` (`session_id`),
  KEY `idx_conversion_type` (`conversion_type`),
  KEY `idx_order_id` (`order_id`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `fk_conversion_tracking_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_conversion_tracking_session` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_conversion_tracking_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- SECTION 24: ADMINISTRATION (Tables 68-70)
-- =====================================================

-- Table 68: admin_users
CREATE TABLE `admin_users` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(100) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password_hash` VARCHAR(255) NOT NULL,
  `full_name` VARCHAR(255) NOT NULL,
  `role_id` BIGINT UNSIGNED NOT NULL,
  `phone` VARCHAR(20) NULL,
  `avatar` VARCHAR(500) NULL,
  `department` VARCHAR(100) NULL,
  `employee_id` VARCHAR(50) NULL,
  `status` ENUM('active', 'inactive', 'suspended') NOT NULL DEFAULT 'active',
  `two_factor_enabled` BOOLEAN NOT NULL DEFAULT FALSE,
  `two_factor_secret` VARCHAR(255) NULL,
  `permissions` JSON NULL,
  `last_login_at` TIMESTAMP NULL,
  `last_login_ip` VARCHAR(45) NULL,
  `failed_login_attempts` INT NOT NULL DEFAULT 0,
  `locked_until` TIMESTAMP NULL,
  `password_changed_at` TIMESTAMP NULL,
  `must_change_password` BOOLEAN NOT NULL DEFAULT FALSE,
  `created_by` BIGINT UNSIGNED NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_username` (`username`),
  UNIQUE KEY `idx_email` (`email`),
  UNIQUE KEY `idx_employee_id` (`employee_id`),
  KEY `idx_role_id` (`role_id`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 69: admin_roles
CREATE TABLE `admin_roles` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_name` VARCHAR(100) NOT NULL,
  `role_key` VARCHAR(100) NOT NULL,
  `description` TEXT NULL,
  `level` INT NOT NULL DEFAULT 0 COMMENT 'Higher level = more access',
  `permissions` JSON NOT NULL COMMENT 'Array of permission keys',
  `can_manage_users` BOOLEAN NOT NULL DEFAULT FALSE,
  `can_manage_products` BOOLEAN NOT NULL DEFAULT FALSE,
  `can_manage_orders` BOOLEAN NOT NULL DEFAULT FALSE,
  `can_manage_content` BOOLEAN NOT NULL DEFAULT FALSE,
  `can_view_analytics` BOOLEAN NOT NULL DEFAULT FALSE,
  `can_manage_settings` BOOLEAN NOT NULL DEFAULT FALSE,
  `can_manage_admins` BOOLEAN NOT NULL DEFAULT FALSE,
  `is_system_role` BOOLEAN NOT NULL DEFAULT FALSE,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_role_key` (`role_key`),
  KEY `idx_level` (`level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add foreign key for admin_users.role_id
ALTER TABLE `admin_users` 
ADD CONSTRAINT `fk_admin_users_role` FOREIGN KEY (`role_id`) REFERENCES `admin_roles` (`id`) ON DELETE RESTRICT;

-- Table 70: admin_activity_logs
CREATE TABLE `admin_activity_logs` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `admin_user_id` BIGINT UNSIGNED NOT NULL,
  `action` VARCHAR(100) NOT NULL,
  `action_category` VARCHAR(100) NULL,
  `description` TEXT NULL,
  `entity_type` VARCHAR(100) NULL COMMENT 'user, product, order, etc.',
  `entity_id` BIGINT UNSIGNED NULL,
  `old_values` JSON NULL,
  `new_values` JSON NULL,
  `ip_address` VARCHAR(45) NULL,
  `user_agent` TEXT NULL,
  `metadata` JSON NULL,
  `severity` ENUM('info', 'warning', 'critical') NOT NULL DEFAULT 'info',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_admin_user_id` (`admin_user_id`),
  KEY `idx_action` (`action`),
  KEY `idx_entity` (`entity_type`, `entity_id`),
  KEY `idx_severity` (`severity`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `fk_admin_activity_logs_admin` FOREIGN KEY (`admin_user_id`) REFERENCES `admin_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- INDEXES AND OPTIMIZATIONS FOR PHASE 4
-- =====================================================

-- Composite indexes for Phase 4
CREATE INDEX `idx_feedback_status_priority` ON `feedback` (`status`, `priority`);
CREATE INDEX `idx_search_queries_user_created` ON `search_queries` (`user_id`, `created_at`);
CREATE INDEX `idx_cart_analytics_user_event` ON `cart_analytics` (`user_id`, `event_type`);
CREATE INDEX `idx_admin_activity_logs_admin_created` ON `admin_activity_logs` (`admin_user_id`, `created_at`);

-- =====================================================
-- END OF PHASE 4: TRUST, ANALYTICS & ADMINISTRATION
-- =====================================================

-- Success message for Phase 4
SELECT 'Phase 4 Trust, Analytics & Administration (15 tables, Total: 70 tables) created successfully!' AS status;

-- =====================================================
-- PHASE 5: SYSTEM & INTEGRATION (Tables 71-80) - FINAL PHASE
-- =====================================================

-- =====================================================
-- SECTION 25: SYSTEM CONFIGURATION (Table 71)
-- =====================================================

-- Table 71: system_settings
CREATE TABLE `system_settings` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `setting_key` VARCHAR(255) NOT NULL,
  `setting_value` TEXT NULL,
  `setting_type` ENUM('string', 'number', 'boolean', 'json', 'array', 'encrypted') NOT NULL DEFAULT 'string',
  `category` VARCHAR(100) NOT NULL,
  `description` TEXT NULL,
  `is_public` BOOLEAN NOT NULL DEFAULT FALSE COMMENT 'Can be accessed by frontend',
  `is_editable` BOOLEAN NOT NULL DEFAULT TRUE,
  `validation_rules` JSON NULL,
  `default_value` TEXT NULL,
  `display_order` INT NOT NULL DEFAULT 0,
  `last_modified_by` BIGINT UNSIGNED NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_setting_key` (`setting_key`),
  KEY `idx_category` (`category`),
  KEY `idx_is_public` (`is_public`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- SECTION 26: API MANAGEMENT (Tables 72-73)
-- =====================================================

-- Table 72: api_keys
CREATE TABLE `api_keys` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `key_name` VARCHAR(255) NOT NULL,
  `api_key` VARCHAR(255) NOT NULL,
  `api_secret` VARCHAR(255) NULL,
  `key_type` ENUM('public', 'private', 'server', 'webhook') NOT NULL DEFAULT 'private',
  `user_id` BIGINT UNSIGNED NULL,
  `admin_user_id` BIGINT UNSIGNED NULL,
  `permissions` JSON NOT NULL COMMENT 'Array of allowed endpoints/actions',
  `rate_limit` INT NOT NULL DEFAULT 1000 COMMENT 'Requests per hour',
  `rate_limit_window` INT NOT NULL DEFAULT 3600 COMMENT 'Seconds',
  `current_usage` INT NOT NULL DEFAULT 0,
  `total_requests` BIGINT NOT NULL DEFAULT 0,
  `last_used_at` TIMESTAMP NULL,
  `last_used_ip` VARCHAR(45) NULL,
  `allowed_ips` JSON NULL COMMENT 'IP whitelist',
  `allowed_domains` JSON NULL,
  `status` ENUM('active', 'inactive', 'suspended', 'revoked') NOT NULL DEFAULT 'active',
  `expires_at` TIMESTAMP NULL,
  `metadata` JSON NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_api_key` (`api_key`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_admin_user_id` (`admin_user_id`),
  KEY `idx_status` (`status`),
  CONSTRAINT `fk_api_keys_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_api_keys_admin` FOREIGN KEY (`admin_user_id`) REFERENCES `admin_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 73: api_logs
CREATE TABLE `api_logs` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `api_key_id` BIGINT UNSIGNED NULL,
  `endpoint` VARCHAR(255) NOT NULL,
  `method` ENUM('GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'OPTIONS', 'HEAD') NOT NULL,
  `request_headers` JSON NULL,
  `request_body` TEXT NULL,
  `response_status` INT NOT NULL,
  `response_body` TEXT NULL,
  `response_time` INT NOT NULL COMMENT 'Milliseconds',
  `ip_address` VARCHAR(45) NULL,
  `user_agent` TEXT NULL,
  `user_id` BIGINT UNSIGNED NULL,
  `error_message` TEXT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_api_key_id` (`api_key_id`),
  KEY `idx_endpoint` (`endpoint`),
  KEY `idx_response_status` (`response_status`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `fk_api_logs_key` FOREIGN KEY (`api_key_id`) REFERENCES `api_keys` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- SECTION 27: COMMUNICATION TEMPLATES (Tables 74-75)
-- =====================================================

-- Table 74: email_templates
CREATE TABLE `email_templates` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `template_key` VARCHAR(100) NOT NULL,
  `template_name` VARCHAR(255) NOT NULL,
  `category` VARCHAR(100) NULL,
  `subject` VARCHAR(500) NOT NULL,
  `subject_variables` JSON NULL,
  `body_html` TEXT NOT NULL,
  `body_text` TEXT NULL,
  `body_variables` JSON NULL COMMENT 'Available variables for substitution',
  `from_name` VARCHAR(255) NULL,
  `from_email` VARCHAR(255) NULL,
  `reply_to` VARCHAR(255) NULL,
  `cc` VARCHAR(500) NULL,
  `bcc` VARCHAR(500) NULL,
  `attachments` JSON NULL,
  `language` VARCHAR(10) NOT NULL DEFAULT 'en',
  `status` ENUM('active', 'inactive', 'draft') NOT NULL DEFAULT 'active',
  `version` INT NOT NULL DEFAULT 1,
  `is_default` BOOLEAN NOT NULL DEFAULT FALSE,
  `preview_text` VARCHAR(255) NULL,
  `design_json` JSON NULL COMMENT 'Email builder JSON',
  `last_used_at` TIMESTAMP NULL,
  `usage_count` INT NOT NULL DEFAULT 0,
  `created_by` BIGINT UNSIGNED NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_template_key_language` (`template_key`, `language`),
  KEY `idx_category` (`category`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 75: sms_templates
CREATE TABLE `sms_templates` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `template_key` VARCHAR(100) NOT NULL,
  `template_name` VARCHAR(255) NOT NULL,
  `category` VARCHAR(100) NULL,
  `message` TEXT NOT NULL,
  `message_variables` JSON NULL,
  `max_length` INT NOT NULL DEFAULT 160,
  `sender_id` VARCHAR(20) NULL,
  `language` VARCHAR(10) NOT NULL DEFAULT 'en',
  `status` ENUM('active', 'inactive', 'draft') NOT NULL DEFAULT 'active',
  `is_default` BOOLEAN NOT NULL DEFAULT FALSE,
  `last_used_at` TIMESTAMP NULL,
  `usage_count` INT NOT NULL DEFAULT 0,
  `created_by` BIGINT UNSIGNED NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_template_key_language` (`template_key`, `language`),
  KEY `idx_category` (`category`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- SECTION 28: FILE MANAGEMENT (Table 76)
-- =====================================================

-- Table 76: file_uploads
CREATE TABLE `file_uploads` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NULL,
  `admin_user_id` BIGINT UNSIGNED NULL,
  `file_name` VARCHAR(255) NOT NULL,
  `original_name` VARCHAR(255) NOT NULL,
  `file_path` VARCHAR(500) NOT NULL,
  `file_url` VARCHAR(500) NOT NULL,
  `file_type` VARCHAR(100) NOT NULL COMMENT 'image/jpeg, application/pdf, etc.',
  `file_category` ENUM('product_image', 'user_avatar', 'review_photo', 'recipe_photo', 'document', 'other') NULL,
  `file_size` BIGINT NOT NULL COMMENT 'Bytes',
  `mime_type` VARCHAR(100) NOT NULL,
  `dimensions` VARCHAR(50) NULL COMMENT 'WxH for images',
  `thumbnail_url` VARCHAR(500) NULL,
  `storage_provider` ENUM('local', 's3', 'cloudinary', 'azure', 'gcs') NOT NULL DEFAULT 'local',
  `storage_path` VARCHAR(500) NULL,
  `cdn_url` VARCHAR(500) NULL,
  `is_public` BOOLEAN NOT NULL DEFAULT TRUE,
  `entity_type` VARCHAR(100) NULL COMMENT 'product, user, review, etc.',
  `entity_id` BIGINT UNSIGNED NULL,
  `metadata` JSON NULL,
  `alt_text` VARCHAR(255) NULL,
  `description` TEXT NULL,
  `virus_scan_status` ENUM('pending', 'clean', 'infected', 'error') NULL,
  `virus_scan_at` TIMESTAMP NULL,
  `download_count` INT NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_admin_user_id` (`admin_user_id`),
  KEY `idx_file_category` (`file_category`),
  KEY `idx_entity` (`entity_type`, `entity_id`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `fk_file_uploads_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_file_uploads_admin` FOREIGN KEY (`admin_user_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- SECTION 29: JOB SCHEDULING (Table 77)
-- =====================================================

-- Table 77: scheduled_jobs
CREATE TABLE `scheduled_jobs` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `job_name` VARCHAR(255) NOT NULL,
  `job_key` VARCHAR(100) NOT NULL,
  `job_type` ENUM('cron', 'interval', 'one_time', 'recurring') NOT NULL,
  `job_class` VARCHAR(255) NULL COMMENT 'PHP class or function name',
  `job_command` TEXT NULL,
  `description` TEXT NULL,
  `schedule` VARCHAR(255) NOT NULL COMMENT 'Cron expression or interval',
  `timezone` VARCHAR(100) NOT NULL DEFAULT 'Asia/Dhaka',
  `parameters` JSON NULL,
  `priority` INT NOT NULL DEFAULT 5 COMMENT '1-10, higher = more priority',
  `max_attempts` INT NOT NULL DEFAULT 3,
  `retry_delay` INT NOT NULL DEFAULT 300 COMMENT 'Seconds',
  `timeout` INT NOT NULL DEFAULT 3600 COMMENT 'Seconds',
  `status` ENUM('active', 'paused', 'disabled', 'failed') NOT NULL DEFAULT 'active',
  `last_run_at` TIMESTAMP NULL,
  `last_run_status` ENUM('success', 'failed', 'timeout', 'skipped') NULL,
  `last_run_duration` INT NULL COMMENT 'Seconds',
  `last_error` TEXT NULL,
  `next_run_at` TIMESTAMP NULL,
  `run_count` INT NOT NULL DEFAULT 0,
  `success_count` INT NOT NULL DEFAULT 0,
  `failure_count` INT NOT NULL DEFAULT 0,
  `average_duration` INT NULL COMMENT 'Seconds',
  `is_running` BOOLEAN NOT NULL DEFAULT FALSE,
  `running_since` TIMESTAMP NULL,
  `alert_on_failure` BOOLEAN NOT NULL DEFAULT TRUE,
  `alert_emails` JSON NULL,
  `metadata` JSON NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_job_key` (`job_key`),
  KEY `idx_status` (`status`),
  KEY `idx_next_run_at` (`next_run_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- SECTION 30: MONITORING & WEBHOOKS (Tables 78-80)
-- =====================================================

-- Table 78: error_logs
CREATE TABLE `error_logs` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `error_type` VARCHAR(100) NOT NULL,
  `error_level` ENUM('debug', 'info', 'notice', 'warning', 'error', 'critical', 'alert', 'emergency') NOT NULL DEFAULT 'error',
  `error_code` VARCHAR(50) NULL,
  `error_message` TEXT NOT NULL,
  `error_context` JSON NULL,
  `stack_trace` TEXT NULL,
  `file_path` VARCHAR(500) NULL,
  `line_number` INT NULL,
  `user_id` BIGINT UNSIGNED NULL,
  `admin_user_id` BIGINT UNSIGNED NULL,
  `request_url` VARCHAR(500) NULL,
  `request_method` VARCHAR(10) NULL,
  `request_data` JSON NULL,
  `ip_address` VARCHAR(45) NULL,
  `user_agent` TEXT NULL,
  `session_id` VARCHAR(255) NULL,
  `environment` VARCHAR(50) NULL COMMENT 'production, staging, development',
  `server_name` VARCHAR(255) NULL,
  `app_version` VARCHAR(50) NULL,
  `is_resolved` BOOLEAN NOT NULL DEFAULT FALSE,
  `resolved_at` TIMESTAMP NULL,
  `resolved_by` BIGINT UNSIGNED NULL,
  `resolution_notes` TEXT NULL,
  `occurrence_count` INT NOT NULL DEFAULT 1,
  `first_occurred_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_occurred_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_error_type` (`error_type`),
  KEY `idx_error_level` (`error_level`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_is_resolved` (`is_resolved`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `fk_error_logs_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_error_logs_admin` FOREIGN KEY (`admin_user_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 79: webhooks
CREATE TABLE `webhooks` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `webhook_name` VARCHAR(255) NOT NULL,
  `webhook_url` VARCHAR(500) NOT NULL,
  `webhook_secret` VARCHAR(255) NULL COMMENT 'For HMAC signature verification',
  `event_types` JSON NOT NULL COMMENT 'Array of events to trigger: order.created, payment.completed, etc.',
  `http_method` ENUM('POST', 'PUT', 'PATCH') NOT NULL DEFAULT 'POST',
  `headers` JSON NULL COMMENT 'Custom headers to send',
  `payload_template` JSON NULL,
  `content_type` VARCHAR(100) NOT NULL DEFAULT 'application/json',
  `status` ENUM('active', 'inactive', 'suspended', 'failed') NOT NULL DEFAULT 'active',
  `retry_policy` JSON NULL COMMENT 'Max retries, backoff strategy',
  `max_retries` INT NOT NULL DEFAULT 3,
  `timeout` INT NOT NULL DEFAULT 30 COMMENT 'Seconds',
  `success_count` INT NOT NULL DEFAULT 0,
  `failure_count` INT NOT NULL DEFAULT 0,
  `last_triggered_at` TIMESTAMP NULL,
  `last_success_at` TIMESTAMP NULL,
  `last_failure_at` TIMESTAMP NULL,
  `last_error` TEXT NULL,
  `average_response_time` INT NULL COMMENT 'Milliseconds',
  `user_id` BIGINT UNSIGNED NULL,
  `admin_user_id` BIGINT UNSIGNED NULL,
  `description` TEXT NULL,
  `metadata` JSON NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_admin_user_id` (`admin_user_id`),
  CONSTRAINT `fk_webhooks_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_webhooks_admin` FOREIGN KEY (`admin_user_id`) REFERENCES `admin_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table 80: webhook_logs
CREATE TABLE `webhook_logs` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `webhook_id` BIGINT UNSIGNED NOT NULL,
  `event_type` VARCHAR(100) NOT NULL,
  `event_id` VARCHAR(255) NULL,
  `payload` JSON NOT NULL,
  `request_headers` JSON NULL,
  `response_status` INT NULL,
  `response_body` TEXT NULL,
  `response_headers` JSON NULL,
  `response_time` INT NULL COMMENT 'Milliseconds',
  `attempt_number` INT NOT NULL DEFAULT 1,
  `status` ENUM('pending', 'success', 'failed', 'retrying') NOT NULL DEFAULT 'pending',
  `error_message` TEXT NULL,
  `will_retry` BOOLEAN NOT NULL DEFAULT FALSE,
  `next_retry_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `processed_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  KEY `idx_webhook_id` (`webhook_id`),
  KEY `idx_event_type` (`event_type`),
  KEY `idx_status` (`status`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `fk_webhook_logs_webhook` FOREIGN KEY (`webhook_id`) REFERENCES `webhooks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- FINAL INDEXES AND OPTIMIZATIONS
-- =====================================================

-- Additional composite indexes for performance
CREATE INDEX `idx_api_logs_key_created` ON `api_logs` (`api_key_id`, `created_at`);
CREATE INDEX `idx_error_logs_type_level` ON `error_logs` (`error_type`, `error_level`);
CREATE INDEX `idx_webhook_logs_webhook_status` ON `webhook_logs` (`webhook_id`, `status`);

-- =====================================================
-- END OF PHASE 5: SYSTEM & INTEGRATION (FINAL PHASE)
-- =====================================================

-- Success message for Phase 5
SELECT 'Phase 5 System & Integration (10 tables, Total: 80 tables) created successfully!' AS status;

-- =====================================================
-- COMPLETE DATABASE SCHEMA
-- =====================================================

SELECT '
================================================================================
  SAVOYCONNECT DATABASE SCHEMA - COMPLETE
================================================================================

  Total Tables: 80
  
  Phase 1 (MVP Core): 21 tables
    - User Management (6 tables)
    - Product Catalog (5 tables)
    - Order Management (4 tables)
    - Locations & Inventory (3 tables)
    - Delivery (2 tables)
    - Loyalty Foundation (1 table)
  
  Phase 2 (Enhanced Features): 16 tables
    - Loyalty System (6 tables)
    - Reviews & Ratings (3 tables)
    - Referrals (1 table)
    - Promotions (2 tables)
    - Notifications (2 tables)
    - Recipes (2 tables)
  
  Phase 3 (Advanced Features): 18 tables
    - Recipe Features (3 tables)
    - Social Features (4 tables)
    - Digital Passport (3 tables)
    - Custom Boxes (2 tables)
    - Stock Notifications (1 table)
    - Health Tracking (2 tables)
    - Gamification (3 tables)
  
  Phase 4 (Trust, Analytics & Administration): 15 tables
    - Leaderboards (1 table)
    - Trust & Verification (2 tables)
    - Feedback System (2 tables)
    - Analytics (7 tables)
    - Administration (3 tables)
  
  Phase 5 (System & Integration): 10 tables
    - System Configuration (1 table)
    - API Management (2 tables)
    - Communication Templates (2 tables)
    - File Management (1 table)
    - Job Scheduling (1 table)
    - Monitoring & Webhooks (3 tables)

================================================================================
  DEPLOYMENT INSTRUCTIONS
================================================================================

  1. Database Setup:
     - Create database: CREATE DATABASE savoyconnect CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
     - Set timezone: SET time_zone = '\''+06:00'\'';
     
  2. Execute this file:
     - mysql -u username -p savoyconnect < SavoyConnect_DDL_Phase1_MVP.sql
     
  3. Verify installation:
     - Check table count: SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = '\''savoyconnect'\'';
     - Should return: 80 tables
     
  4. Create initial admin user and roles
  
  5. Configure system_settings table with application settings
  
  6. Set up scheduled_jobs for background tasks
  
  7. Run data migrations if upgrading from previous version

================================================================================
  DATABASE SCHEMA COMPLETE - READY FOR PRODUCTION
================================================================================
' AS deployment_guide;

COMMIT;
