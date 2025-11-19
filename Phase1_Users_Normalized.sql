-- =====================================================
-- SavoyConnect Database Design - Phase 1: User Management
-- Fully Normalized (3NF) - Built from Scratch
-- MySQL 8.0+
-- Created: November 12, 2025
-- =====================================================

-- =====================================================
-- DESIGN PHILOSOPHY & NORMALIZATION PRINCIPLES
-- =====================================================
-- 
-- This schema follows strict normalization rules:
-- 
-- 1NF (First Normal Form):
--   - All columns contain atomic values (no arrays, no JSON for core data)
--   - Each column contains values of a single type
--   - Each column has a unique name
--   - Order of rows/columns doesn't matter
--
-- 2NF (Second Normal Form):
--   - Meets 1NF requirements
--   - No partial dependencies (non-key attributes depend on entire primary key)
--   - Applied through proper table separation
--
-- 3NF (Third Normal Form):
--   - Meets 2NF requirements
--   - No transitive dependencies (non-key attributes don't depend on other non-key attributes)
--   - Each table represents ONE entity with attributes directly dependent on primary key
--
-- BENEFITS:
--   ✓ Zero data redundancy
--   ✓ No update anomalies
--   ✓ No insertion anomalies  
--   ✓ No deletion anomalies
--   ✓ Data integrity enforced at database level
--   ✓ GDPR/privacy compliance ready
--
-- =====================================================

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+06:00";

SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- =====================================================
-- DATABASE CREATION
-- =====================================================

CREATE DATABASE IF NOT EXISTS `savoyconnect_users` 
DEFAULT CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE `savoyconnect_users`;

-- =====================================================
-- ENTITY 1: USERS (Core Authentication)
-- =====================================================
-- Purpose: Minimal authentication credentials only
-- Why separate: Authentication concerns are independent of profile data
-- Normalization: 3NF - Only auth-related attributes, no profile info
-- =====================================================

CREATE TABLE `users` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  
  -- Authentication Credentials
  `email` VARCHAR(255) NOT NULL COMMENT 'Primary login identifier',
  `phone` VARCHAR(20) NOT NULL COMMENT 'E.164 format: +880XXXXXXXXXX',
  `password_hash` VARCHAR(255) NOT NULL COMMENT 'Bcrypt/Argon2id hashed password',
  
  -- Verification Status
  `email_verified_at` TIMESTAMP NULL COMMENT 'When email was verified',
  `phone_verified_at` TIMESTAMP NULL COMMENT 'When phone was verified',
  
  -- Account Status
  `status` ENUM('active', 'inactive', 'suspended', 'deleted') NOT NULL DEFAULT 'active'
    COMMENT 'active: normal use | inactive: not verified | suspended: temp ban | deleted: soft delete',
  
  -- Security & Access Control
  `last_login_at` TIMESTAMP NULL COMMENT 'Last successful login timestamp',
  `login_attempts` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Failed login counter (reset on success)',
  `locked_until` TIMESTAMP NULL COMMENT 'Account lock expiration (NULL = not locked)',
  
  -- Audit Timestamps
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NULL COMMENT 'Soft delete timestamp for GDPR compliance',
  
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_email` (`email`),
  UNIQUE KEY `uk_phone` (`phone`),
  KEY `idx_status` (`status`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_last_login` (`last_login_at`),
  KEY `idx_email_status` (`email`, `status`) COMMENT 'Composite for login queries'
  
) ENGINE=InnoDB 
  DEFAULT CHARSET=utf8mb4 
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Core user authentication - no profile data (3NF compliant)';

-- =====================================================
-- ENTITY 2: USER_PROFILES (Personal Information)
-- =====================================================
-- Purpose: Extended user personal data (1:1 with users)
-- Why separate: Profile info is optional and changes independently of auth
-- Normalization: 3NF - All attributes depend only on user_id
-- =====================================================

CREATE TABLE `user_profiles` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL COMMENT 'Foreign key to users table',
  
  -- Personal Information
  `first_name` VARCHAR(100) NULL COMMENT 'Given name',
  `last_name` VARCHAR(100) NULL COMMENT 'Family name',
  `date_of_birth` DATE NULL COMMENT 'For age verification and birthday features',
  `gender` ENUM('male', 'female', 'other', 'prefer_not_to_say') NULL,
  
  -- Profile Content
  `bio` VARCHAR(500) NULL COMMENT 'User description (max 500 chars)',
  `profile_picture_url` VARCHAR(500) NULL COMMENT 'Cloud storage URL (S3/CloudFront)',
  `occupation` VARCHAR(100) NULL,
  `company` VARCHAR(255) NULL,
  `website` VARCHAR(500) NULL COMMENT 'Personal website or portfolio',
  
  -- Location (Current Residence)
  `city` VARCHAR(100) NULL COMMENT 'Current city for location-based features',
  `state` VARCHAR(100) NULL COMMENT 'State/province/region',
  `country` VARCHAR(100) NOT NULL DEFAULT 'Bangladesh',
  
  -- Localization Preferences
  `language_code` VARCHAR(10) NOT NULL DEFAULT 'en' COMMENT 'ISO 639-1: en, bn, etc.',
  `timezone` VARCHAR(50) NOT NULL DEFAULT 'Asia/Dhaka' COMMENT 'IANA timezone identifier',
  
  -- Audit Timestamps
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_id` (`user_id`) COMMENT 'One profile per user',
  KEY `idx_city` (`city`),
  KEY `idx_country` (`country`),
  KEY `idx_location` (`city`, `country`) COMMENT 'Composite for location searches',
  
  CONSTRAINT `fk_user_profiles_user` 
    FOREIGN KEY (`user_id`) 
    REFERENCES `users` (`id`) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE
    
) ENGINE=InnoDB 
  DEFAULT CHARSET=utf8mb4 
  COLLATE=utf8mb4_unicode_ci
  COMMENT='User personal information (3NF - depends only on user_id)';

-- =====================================================
-- ENTITY 3: SOCIAL_PLATFORMS (Reference Data)
-- =====================================================
-- Purpose: Master list of supported social media platforms
-- Why separate: Normalizes social platform data, prevents typos
-- Normalization: 3NF - Reference/lookup table
-- =====================================================

CREATE TABLE `social_platforms` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL COMMENT 'Platform name: Facebook, Instagram, etc.',
  `slug` VARCHAR(50) NOT NULL COMMENT 'URL-friendly identifier',
  `icon_class` VARCHAR(100) NULL COMMENT 'CSS class or icon identifier',
  `base_url` VARCHAR(255) NULL COMMENT 'Platform base URL for validation',
  `is_active` BOOLEAN NOT NULL DEFAULT TRUE,
  `display_order` INT NOT NULL DEFAULT 0,
  
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_slug` (`slug`),
  KEY `idx_is_active` (`is_active`)
  
) ENGINE=InnoDB 
  DEFAULT CHARSET=utf8mb4 
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Social media platform reference table';

-- =====================================================
-- ENTITY 4: USER_SOCIAL_LINKS (Many-to-Many Junction)
-- =====================================================
-- Purpose: Link users to their social media profiles
-- Why separate: Eliminates JSON arrays, enables proper querying
-- Normalization: 3NF - Junction table for M:N relationship
-- =====================================================

CREATE TABLE `user_social_links` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `platform_id` INT UNSIGNED NOT NULL,
  
  -- Social Profile Data
  `profile_url` VARCHAR(500) NOT NULL COMMENT 'Full URL to social profile',
  `username` VARCHAR(255) NULL COMMENT 'Platform username/handle',
  `is_verified` BOOLEAN NOT NULL DEFAULT FALSE COMMENT 'Platform verification badge',
  `is_public` BOOLEAN NOT NULL DEFAULT TRUE COMMENT 'Show on public profile',
  `display_order` INT NOT NULL DEFAULT 0 COMMENT 'Sort order on profile',
  
  -- Audit Timestamps
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_platform` (`user_id`, `platform_id`) COMMENT 'One link per platform per user',
  KEY `idx_user_id` (`user_id`),
  KEY `idx_platform_id` (`platform_id`),
  KEY `idx_is_public` (`is_public`),
  
  CONSTRAINT `fk_user_social_links_user` 
    FOREIGN KEY (`user_id`) 
    REFERENCES `users` (`id`) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE,
  CONSTRAINT `fk_user_social_links_platform` 
    FOREIGN KEY (`platform_id`) 
    REFERENCES `social_platforms` (`id`) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE
    
) ENGINE=InnoDB 
  DEFAULT CHARSET=utf8mb4 
  COLLATE=utf8mb4_unicode_ci
  COMMENT='User social media links (eliminates JSON array)';

-- =====================================================
-- ENTITY 5: INTERESTS (Reference Data)
-- =====================================================
-- Purpose: Master list of user interests/hobbies
-- Why separate: Normalizes interest data, enables analytics
-- Normalization: 3NF - Reference/lookup table
-- =====================================================

CREATE TABLE `interests` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL COMMENT 'Interest name: Cooking, Sports, Travel, etc.',
  `slug` VARCHAR(100) NOT NULL,
  `category` VARCHAR(50) NULL COMMENT 'Group: hobbies, food, sports, entertainment',
  `icon` VARCHAR(100) NULL COMMENT 'Icon identifier',
  `is_active` BOOLEAN NOT NULL DEFAULT TRUE,
  `display_order` INT NOT NULL DEFAULT 0,
  
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_slug` (`slug`),
  KEY `idx_category` (`category`),
  KEY `idx_is_active` (`is_active`)
  
) ENGINE=InnoDB 
  DEFAULT CHARSET=utf8mb4 
  COLLATE=utf8mb4_unicode_ci
  COMMENT='User interests reference table';

-- =====================================================
-- ENTITY 6: USER_INTERESTS (Many-to-Many Junction)
-- =====================================================
-- Purpose: Link users to their interests
-- Why separate: Eliminates JSON arrays, enables interest-based recommendations
-- Normalization: 3NF - Junction table for M:N relationship
-- =====================================================

CREATE TABLE `user_interests` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `interest_id` INT UNSIGNED NOT NULL,
  `proficiency_level` ENUM('beginner', 'intermediate', 'advanced', 'expert') NULL 
    COMMENT 'Optional: user skill level in this interest',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_interest` (`user_id`, `interest_id`) COMMENT 'One interest per user',
  KEY `idx_user_id` (`user_id`),
  KEY `idx_interest_id` (`interest_id`),
  
  CONSTRAINT `fk_user_interests_user` 
    FOREIGN KEY (`user_id`) 
    REFERENCES `users` (`id`) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE,
  CONSTRAINT `fk_user_interests_interest` 
    FOREIGN KEY (`interest_id`) 
    REFERENCES `interests` (`id`) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE
    
) ENGINE=InnoDB 
  DEFAULT CHARSET=utf8mb4 
  COLLATE=utf8mb4_unicode_ci
  COMMENT='User interests junction table (eliminates JSON array)';

-- =====================================================
-- ENTITY 7: DIETARY_RESTRICTIONS (Reference Data)
-- =====================================================
-- Purpose: Master list of dietary preferences and restrictions
-- Why separate: Normalizes dietary data, enables product filtering
-- Normalization: 3NF - Reference/lookup table
-- =====================================================

CREATE TABLE `dietary_restrictions` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL COMMENT 'Vegetarian, Vegan, Halal, Gluten-Free, etc.',
  `slug` VARCHAR(100) NOT NULL,
  `category` ENUM('diet_type', 'allergen', 'intolerance', 'lifestyle', 'religious') NOT NULL,
  `description` TEXT NULL,
  `icon` VARCHAR(100) NULL,
  `severity_level` ENUM('preference', 'moderate', 'severe', 'life_threatening') NOT NULL DEFAULT 'preference'
    COMMENT 'Impact level for recommendation engine',
  `is_active` BOOLEAN NOT NULL DEFAULT TRUE,
  `display_order` INT NOT NULL DEFAULT 0,
  
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_slug` (`slug`),
  KEY `idx_category` (`category`),
  KEY `idx_severity` (`severity_level`),
  KEY `idx_is_active` (`is_active`)
  
) ENGINE=InnoDB 
  DEFAULT CHARSET=utf8mb4 
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Dietary restrictions and allergens reference table';

-- =====================================================
-- ENTITY 8: USER_DIETARY_RESTRICTIONS (Many-to-Many Junction)
-- =====================================================
-- Purpose: Link users to their dietary restrictions
-- Why separate: Eliminates JSON arrays, enables product recommendations
-- Normalization: 3NF - Junction table for M:N relationship
-- =====================================================

CREATE TABLE `user_dietary_restrictions` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `restriction_id` INT UNSIGNED NOT NULL,
  
  -- User-Specific Context
  `severity` ENUM('preference', 'allergy', 'intolerance', 'lifestyle') NOT NULL DEFAULT 'preference'
    COMMENT 'How strict this restriction is for this user',
  `notes` VARCHAR(500) NULL COMMENT 'User-specific notes or details',
  `diagnosed_by_doctor` BOOLEAN NOT NULL DEFAULT FALSE COMMENT 'Medical diagnosis vs personal choice',
  
  -- Audit
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_restriction` (`user_id`, `restriction_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_restriction_id` (`restriction_id`),
  KEY `idx_severity` (`severity`),
  
  CONSTRAINT `fk_user_dietary_user` 
    FOREIGN KEY (`user_id`) 
    REFERENCES `users` (`id`) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE,
  CONSTRAINT `fk_user_dietary_restriction` 
    FOREIGN KEY (`restriction_id`) 
    REFERENCES `dietary_restrictions` (`id`) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE
    
) ENGINE=InnoDB 
  DEFAULT CHARSET=utf8mb4 
  COLLATE=utf8mb4_unicode_ci
  COMMENT='User dietary restrictions (eliminates JSON array)';

-- =====================================================
-- ENTITY 9: USER_PREFERENCES (Application Settings)
-- =====================================================
-- Purpose: User app preferences and notification settings
-- Why separate: Settings are independent of profile, change frequently
-- Normalization: 3NF - All boolean flags depend only on user_id
-- =====================================================

CREATE TABLE `user_preferences` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  
  -- Communication Preferences
  `push_notifications_enabled` BOOLEAN NOT NULL DEFAULT TRUE,
  `email_notifications_enabled` BOOLEAN NOT NULL DEFAULT TRUE,
  `sms_notifications_enabled` BOOLEAN NOT NULL DEFAULT FALSE,
  
  -- Marketing & Privacy (GDPR Compliant)
  `marketing_emails_consent` BOOLEAN NOT NULL DEFAULT FALSE 
    COMMENT 'Explicit opt-in for marketing (GDPR/CAN-SPAM)',
  `marketing_consent_given_at` TIMESTAMP NULL COMMENT 'When consent was given',
  `marketing_consent_ip` VARCHAR(45) NULL COMMENT 'IP address at consent time',
  `marketing_consent_source` VARCHAR(50) NULL COMMENT 'signup, settings_page, campaign',
  
  `promotional_offers_enabled` BOOLEAN NOT NULL DEFAULT TRUE,
  `newsletter_subscription` BOOLEAN NOT NULL DEFAULT FALSE,
  
  -- Feature-Specific Notifications
  `order_updates_enabled` BOOLEAN NOT NULL DEFAULT TRUE,
  `delivery_updates_enabled` BOOLEAN NOT NULL DEFAULT TRUE,
  `product_recommendations_enabled` BOOLEAN NOT NULL DEFAULT TRUE,
  `recipe_suggestions_enabled` BOOLEAN NOT NULL DEFAULT TRUE,
  `challenge_notifications_enabled` BOOLEAN NOT NULL DEFAULT TRUE,
  `social_activity_notifications_enabled` BOOLEAN NOT NULL DEFAULT TRUE,
  `weekly_digest_enabled` BOOLEAN NOT NULL DEFAULT FALSE,
  
  -- UI/UX Preferences
  `theme` ENUM('light', 'dark', 'auto') NOT NULL DEFAULT 'auto',
  `font_size` ENUM('small', 'medium', 'large') NOT NULL DEFAULT 'medium',
  `high_contrast_mode` BOOLEAN NOT NULL DEFAULT FALSE COMMENT 'Accessibility',
  
  -- Regional Preferences
  `currency_code` VARCHAR(3) NOT NULL DEFAULT 'BDT' COMMENT 'ISO 4217: BDT, USD, EUR',
  `timezone` VARCHAR(50) NOT NULL DEFAULT 'Asia/Dhaka' COMMENT 'IANA timezone',
  
  -- Privacy & Data
  `data_sharing_consent` BOOLEAN NOT NULL DEFAULT FALSE 
    COMMENT 'Analytics and personalization consent',
  `data_sharing_consent_given_at` TIMESTAMP NULL,
  `show_profile_publicly` BOOLEAN NOT NULL DEFAULT TRUE,
  `show_activity_publicly` BOOLEAN NOT NULL DEFAULT TRUE,
  
  -- Audit
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_id` (`user_id`) COMMENT 'One preference set per user',
  KEY `idx_marketing_consent` (`marketing_emails_consent`),
  KEY `idx_push_enabled` (`push_notifications_enabled`),
  
  CONSTRAINT `fk_user_preferences_user` 
    FOREIGN KEY (`user_id`) 
    REFERENCES `users` (`id`) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE
    
) ENGINE=InnoDB 
  DEFAULT CHARSET=utf8mb4 
  COLLATE=utf8mb4_unicode_ci
  COMMENT='User app preferences and notification settings (3NF)';

-- =====================================================
-- ENTITY 10: USER_ADDRESSES (Delivery Addresses)
-- =====================================================
-- Purpose: Multiple delivery addresses per user
-- Why separate: Users can have many addresses, addresses are complex entities
-- Normalization: 3NF - All attributes describe the address itself
-- =====================================================

CREATE TABLE `user_addresses` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  
  -- Address Type & Label
  `address_type` ENUM('home', 'work', 'other') NOT NULL DEFAULT 'home',
  `label` VARCHAR(100) NULL COMMENT 'Custom label: "Mom''s House", "Office", etc.',
  
  -- Recipient Information (may differ from user)
  `recipient_name` VARCHAR(255) NULL COMMENT 'Name of person receiving delivery',
  `recipient_phone` VARCHAR(20) NULL COMMENT 'Contact phone for this address',
  
  -- Address Components
  `street_address` VARCHAR(500) NOT NULL COMMENT 'House/building number, street name',
  `apartment_unit` VARCHAR(100) NULL COMMENT 'Apt, suite, floor, unit number',
  `landmark` VARCHAR(255) NULL COMMENT 'Nearby landmark for easier navigation',
  `area` VARCHAR(255) NULL COMMENT 'Neighborhood/locality name',
  `city` VARCHAR(100) NOT NULL,
  `state_province` VARCHAR(100) NULL,
  `postal_code` VARCHAR(20) NULL,
  `country` VARCHAR(100) NOT NULL DEFAULT 'Bangladesh',
  
  -- Geocoding (for delivery routing)
  `latitude` DECIMAL(10, 8) NULL COMMENT 'GPS latitude (-90 to 90)',
  `longitude` DECIMAL(11, 8) NULL COMMENT 'GPS longitude (-180 to 180)',
  `geocode_accuracy` ENUM('rooftop', 'range', 'approximate', 'unknown') NULL
    COMMENT 'Geocoding precision level',
  
  -- Address Status
  `is_default` BOOLEAN NOT NULL DEFAULT FALSE COMMENT 'Primary delivery address',
  `is_verified` BOOLEAN NOT NULL DEFAULT FALSE COMMENT 'Address validated by delivery',
  `is_deliverable` BOOLEAN NOT NULL DEFAULT TRUE COMMENT 'Within delivery zones',
  
  -- Delivery Instructions
  `delivery_instructions` TEXT NULL COMMENT 'Gate code, parking, special instructions',
  
  -- Usage Tracking
  `last_used_at` TIMESTAMP NULL COMMENT 'Last time used for order',
  `usage_count` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Number of deliveries',
  
  -- Audit
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NULL COMMENT 'Soft delete',
  
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_is_default` (`is_default`),
  KEY `idx_city` (`city`),
  KEY `idx_postal_code` (`postal_code`),
  KEY `idx_coordinates` (`latitude`, `longitude`) COMMENT 'Spatial queries',
  KEY `idx_user_default` (`user_id`, `is_default`) COMMENT 'Find default address',
  
  CONSTRAINT `fk_user_addresses_user` 
    FOREIGN KEY (`user_id`) 
    REFERENCES `users` (`id`) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE
    
) ENGINE=InnoDB 
  DEFAULT CHARSET=utf8mb4 
  COLLATE=utf8mb4_unicode_ci
  COMMENT='User delivery addresses with geocoding (3NF)';

-- =====================================================
-- ENTITY 11: SESSIONS (Active User Sessions)
-- =====================================================
-- Purpose: Track active login sessions across devices
-- Why separate: Sessions are temporal and independent of user data
-- Normalization: 3NF - All attributes describe the session itself
-- =====================================================

CREATE TABLE `sessions` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  
  -- Session Tokens
  `session_token` VARCHAR(255) NOT NULL COMMENT 'JWT or secure random token (hashed)',
  `refresh_token` VARCHAR(255) NULL COMMENT 'Refresh token for renewal (hashed)',
  `token_family` VARCHAR(100) NULL COMMENT 'Token family for refresh token rotation',
  
  -- Device Information
  `device_type` ENUM('web', 'mobile_android', 'mobile_ios', 'tablet', 'desktop', 'unknown') NOT NULL,
  `device_name` VARCHAR(255) NULL COMMENT 'iPhone 15, Samsung Galaxy, Chrome on Windows',
  `device_id` VARCHAR(255) NULL COMMENT 'Unique device identifier (hashed)',
  `device_fingerprint` VARCHAR(500) NULL COMMENT 'Browser fingerprint hash',
  
  -- Browser & OS
  `browser_name` VARCHAR(100) NULL COMMENT 'Chrome, Safari, Firefox',
  `browser_version` VARCHAR(50) NULL,
  `operating_system` VARCHAR(100) NULL COMMENT 'iOS 17, Android 14, Windows 11',
  `os_version` VARCHAR(50) NULL,
  
  -- Network Information
  `ip_address` VARCHAR(45) NULL COMMENT 'IPv4 or IPv6',
  `ip_country` VARCHAR(100) NULL COMMENT 'GeoIP country',
  `ip_city` VARCHAR(100) NULL COMMENT 'GeoIP city',
  `user_agent` TEXT NULL COMMENT 'Full user agent string',
  
  -- Session Status & Timing
  `is_active` BOOLEAN NOT NULL DEFAULT TRUE,
  `last_activity_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP 
    COMMENT 'Last API request timestamp',
  `expires_at` TIMESTAMP NOT NULL COMMENT 'Session expiration time',
  
  -- Security Flags
  `is_trusted_device` BOOLEAN NOT NULL DEFAULT FALSE COMMENT 'Remembered/trusted device',
  `requires_2fa` BOOLEAN NOT NULL DEFAULT FALSE COMMENT '2FA required for this session',
  
  -- Audit
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_session_token` (`session_token`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_refresh_token` (`refresh_token`),
  KEY `idx_expires_at` (`expires_at`),
  KEY `idx_is_active` (`is_active`),
  KEY `idx_last_activity` (`last_activity_at`),
  KEY `idx_user_active` (`user_id`, `is_active`, `expires_at`) COMMENT 'Active sessions per user',
  
  CONSTRAINT `fk_sessions_user` 
    FOREIGN KEY (`user_id`) 
    REFERENCES `users` (`id`) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE
    
) ENGINE=InnoDB 
  DEFAULT CHARSET=utf8mb4 
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Active user sessions with device tracking (3NF)';

-- =====================================================
-- ENTITY 12: PASSWORD_RESETS (Password Reset Tokens)
-- =====================================================
-- Purpose: Manage password reset requests
-- Why separate: Temporal security tokens, independent lifecycle
-- Normalization: 3NF - All attributes describe the reset request
-- =====================================================

CREATE TABLE `password_resets` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `email` VARCHAR(255) NOT NULL COMMENT 'Email for password reset',
  
  -- Reset Token
  `token` VARCHAR(255) NOT NULL COMMENT 'Secure random token (hashed)',
  `token_hash_algo` VARCHAR(50) NOT NULL DEFAULT 'sha256' COMMENT 'Hash algorithm used',
  
  -- Token Status
  `is_used` BOOLEAN NOT NULL DEFAULT FALSE,
  `used_at` TIMESTAMP NULL COMMENT 'When token was consumed',
  `expires_at` TIMESTAMP NOT NULL COMMENT 'Token expiration (typically 1 hour)',
  
  -- Security Context
  `ip_address` VARCHAR(45) NULL COMMENT 'IP of reset request',
  `user_agent` TEXT NULL COMMENT 'User agent of request',
  `reset_method` ENUM('email', 'sms', 'security_questions') NOT NULL DEFAULT 'email',
  
  -- Usage Tracking
  `attempt_count` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Number of failed attempts with this token',
  `last_attempt_at` TIMESTAMP NULL,
  
  -- Audit
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_token` (`token`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_email` (`email`),
  KEY `idx_expires_at` (`expires_at`),
  KEY `idx_is_used` (`is_used`),
  KEY `idx_user_active` (`user_id`, `is_used`, `expires_at`) COMMENT 'Active reset tokens',
  
  CONSTRAINT `fk_password_resets_user` 
    FOREIGN KEY (`user_id`) 
    REFERENCES `users` (`id`) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE
    
) ENGINE=InnoDB 
  DEFAULT CHARSET=utf8mb4 
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Password reset token management (3NF)';

-- =====================================================
-- ENTITY 13: USER_LOGIN_HISTORY (Authentication Audit)
-- =====================================================
-- Purpose: Complete audit trail of all login attempts
-- Why separate: Historical audit data, never delete
-- Normalization: 3NF - All attributes describe the login event
-- =====================================================

CREATE TABLE `user_login_history` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  
  -- Login Attempt Details
  `login_method` ENUM('password', 'otp', 'social_google', 'social_facebook', 'social_apple', 'biometric', 'magic_link', 'token') NOT NULL,
  `status` ENUM('success', 'failed', 'blocked', 'suspicious') NOT NULL,
  
  -- Failure Details
  `failure_reason` VARCHAR(255) NULL COMMENT 'invalid_password, account_locked, etc.',
  `failure_code` VARCHAR(50) NULL COMMENT 'Machine-readable error code',
  
  -- Device & Network Context
  `ip_address` VARCHAR(45) NULL,
  `ip_country` VARCHAR(100) NULL COMMENT 'GeoIP country',
  `ip_city` VARCHAR(100) NULL COMMENT 'GeoIP city',
  `ip_is_vpn` BOOLEAN NULL COMMENT 'VPN/proxy detected',
  `ip_risk_score` TINYINT UNSIGNED NULL COMMENT 'IP reputation score (0-100)',
  
  `device_type` ENUM('web', 'mobile', 'tablet', 'desktop', 'api', 'unknown') NULL,
  `device_id` VARCHAR(255) NULL COMMENT 'Device fingerprint',
  `user_agent` TEXT NULL,
  `browser_name` VARCHAR(100) NULL,
  `operating_system` VARCHAR(100) NULL,
  
  -- Security Flags
  `is_new_device` BOOLEAN NOT NULL DEFAULT FALSE COMMENT 'First time login from this device',
  `is_new_location` BOOLEAN NOT NULL DEFAULT FALSE COMMENT 'First time login from this location',
  `is_suspicious` BOOLEAN NOT NULL DEFAULT FALSE COMMENT 'Flagged by security rules',
  `risk_score` TINYINT UNSIGNED NULL COMMENT 'Overall risk score (0-100)',
  
  -- Session Created
  `session_id` BIGINT UNSIGNED NULL COMMENT 'Session created (if success)',
  
  -- Timestamp
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_status` (`status`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_ip_address` (`ip_address`),
  KEY `idx_is_suspicious` (`is_suspicious`),
  KEY `idx_user_status_date` (`user_id`, `status`, `created_at`) COMMENT 'User login analytics',
  KEY `idx_session_id` (`session_id`),
  
  CONSTRAINT `fk_user_login_history_user` 
    FOREIGN KEY (`user_id`) 
    REFERENCES `users` (`id`) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE,
  CONSTRAINT `fk_user_login_history_session` 
    FOREIGN KEY (`session_id`) 
    REFERENCES `sessions` (`id`) 
    ON DELETE SET NULL 
    ON UPDATE CASCADE
    
) ENGINE=InnoDB 
  DEFAULT CHARSET=utf8mb4 
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Complete login audit trail for security (3NF)';

-- =====================================================
-- ENTITY 14: USER_ACTIVITY_LOG (General Activity Audit)
-- =====================================================
-- Purpose: Track significant user actions for audit and analytics
-- Why separate: Different lifecycle from login history, broader scope
-- Normalization: 3NF - All attributes describe the activity event
-- =====================================================

CREATE TABLE `user_activity_log` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  
  -- Activity Details
  `activity_type` VARCHAR(100) NOT NULL COMMENT 'profile_updated, address_added, preference_changed, etc.',
  `activity_category` ENUM('account', 'profile', 'security', 'privacy', 'settings', 'other') NOT NULL,
  `description` VARCHAR(500) NULL COMMENT 'Human-readable description',
  
  -- Change Details (optional)
  `entity_type` VARCHAR(100) NULL COMMENT 'Table/entity affected',
  `entity_id` BIGINT UNSIGNED NULL COMMENT 'ID of affected record',
  `old_value` TEXT NULL COMMENT 'Previous value (JSON or text)',
  `new_value` TEXT NULL COMMENT 'New value (JSON or text)',
  
  -- Context
  `ip_address` VARCHAR(45) NULL,
  `user_agent` TEXT NULL,
  `session_id` BIGINT UNSIGNED NULL,
  
  -- Timestamp
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_activity_type` (`activity_type`),
  KEY `idx_activity_category` (`activity_category`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_entity` (`entity_type`, `entity_id`) COMMENT 'Track changes to specific entities',
  KEY `idx_user_type_date` (`user_id`, `activity_type`, `created_at`),
  
  CONSTRAINT `fk_user_activity_log_user` 
    FOREIGN KEY (`user_id`) 
    REFERENCES `users` (`id`) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE,
  CONSTRAINT `fk_user_activity_log_session` 
    FOREIGN KEY (`session_id`) 
    REFERENCES `sessions` (`id`) 
    ON DELETE SET NULL 
    ON UPDATE CASCADE
    
) ENGINE=InnoDB 
  DEFAULT CHARSET=utf8mb4 
  COLLATE=utf8mb4_unicode_ci
  COMMENT='User activity audit log (3NF)';

-- =====================================================
-- REFERENCE DATA: Pre-populate lookup tables
-- =====================================================

-- Social Platforms
INSERT INTO `social_platforms` (`name`, `slug`, `icon_class`, `base_url`, `display_order`) VALUES
('Facebook', 'facebook', 'fab fa-facebook', 'https://facebook.com/', 10),
('Instagram', 'instagram', 'fab fa-instagram', 'https://instagram.com/', 20),
('Twitter / X', 'twitter', 'fab fa-twitter', 'https://twitter.com/', 30),
('LinkedIn', 'linkedin', 'fab fa-linkedin', 'https://linkedin.com/', 40),
('YouTube', 'youtube', 'fab fa-youtube', 'https://youtube.com/', 50),
('TikTok', 'tiktok', 'fab fa-tiktok', 'https://tiktok.com/', 60),
('Pinterest', 'pinterest', 'fab fa-pinterest', 'https://pinterest.com/', 70),
('Snapchat', 'snapchat', 'fab fa-snapchat', 'https://snapchat.com/', 80),
('Website', 'website', 'fas fa-globe', NULL, 90),
('Other', 'other', 'fas fa-link', NULL, 100);

-- Interests
INSERT INTO `interests` (`name`, `slug`, `category`, `display_order`) VALUES
-- Food & Cooking
('Cooking', 'cooking', 'food', 10),
('Baking', 'baking', 'food', 20),
('Food Photography', 'food-photography', 'food', 30),
('Wine Tasting', 'wine-tasting', 'food', 40),
('Coffee', 'coffee', 'food', 50),

-- Sports & Fitness
('Running', 'running', 'sports', 110),
('Yoga', 'yoga', 'sports', 120),
('Gym', 'gym', 'sports', 130),
('Swimming', 'swimming', 'sports', 140),
('Cycling', 'cycling', 'sports', 150),
('Cricket', 'cricket', 'sports', 160),
('Football', 'football', 'sports', 170),

-- Entertainment
('Movies', 'movies', 'entertainment', 210),
('Music', 'music', 'entertainment', 220),
('Reading', 'reading', 'entertainment', 230),
('Gaming', 'gaming', 'entertainment', 240),
('Photography', 'photography', 'entertainment', 250),
('Art', 'art', 'entertainment', 260),

-- Lifestyle
('Travel', 'travel', 'lifestyle', 310),
('Fashion', 'fashion', 'lifestyle', 320),
('Technology', 'technology', 'lifestyle', 330),
('Gardening', 'gardening', 'lifestyle', 340),
('Pets', 'pets', 'lifestyle', 350),
('DIY', 'diy', 'lifestyle', 360);

-- Dietary Restrictions
INSERT INTO `dietary_restrictions` (`name`, `slug`, `category`, `severity_level`, `display_order`) VALUES
-- Diet Types
('Vegetarian', 'vegetarian', 'diet_type', 'preference', 10),
('Vegan', 'vegan', 'diet_type', 'preference', 20),
('Halal', 'halal', 'religious', 'preference', 30),
('Kosher', 'kosher', 'religious', 'preference', 40),
('Keto', 'keto', 'diet_type', 'preference', 50),
('Paleo', 'paleo', 'diet_type', 'preference', 60),
('Low Carb', 'low-carb', 'diet_type', 'preference', 70),
('Low Sugar', 'low-sugar', 'diet_type', 'preference', 80),
('Low Fat', 'low-fat', 'diet_type', 'preference', 90),

-- Allergens (Severe)
('Dairy Allergy', 'dairy-allergy', 'allergen', 'life_threatening', 110),
('Egg Allergy', 'egg-allergy', 'allergen', 'life_threatening', 120),
('Peanut Allergy', 'peanut-allergy', 'allergen', 'life_threatening', 130),
('Tree Nut Allergy', 'tree-nut-allergy', 'allergen', 'life_threatening', 140),
('Soy Allergy', 'soy-allergy', 'allergen', 'severe', 150),
('Wheat Allergy', 'wheat-allergy', 'allergen', 'severe', 160),
('Shellfish Allergy', 'shellfish-allergy', 'allergen', 'life_threatening', 170),
('Fish Allergy', 'fish-allergy', 'allergen', 'severe', 180),

-- Intolerances
('Lactose Intolerant', 'lactose-intolerant', 'intolerance', 'moderate', 210),
('Gluten Intolerant', 'gluten-intolerant', 'intolerance', 'moderate', 220),
('Fructose Intolerant', 'fructose-intolerant', 'intolerance', 'moderate', 230),

-- Lifestyle
('Organic Only', 'organic-only', 'lifestyle', 'preference', 310),
('Non-GMO', 'non-gmo', 'lifestyle', 'preference', 320),
('Sugar Free', 'sugar-free', 'diet_type', 'preference', 330),
('Low Sodium', 'low-sodium', 'diet_type', 'preference', 340),
('Diabetic Friendly', 'diabetic-friendly', 'diet_type', 'moderate', 350);

-- =====================================================
-- TRIGGERS: Data Integrity & Business Logic
-- =====================================================

DELIMITER $$

-- Trigger: Ensure only one default address per user
CREATE TRIGGER `trg_user_addresses_before_insert`
BEFORE INSERT ON `user_addresses`
FOR EACH ROW
BEGIN
  IF NEW.is_default = TRUE THEN
    UPDATE `user_addresses` 
    SET `is_default` = FALSE 
    WHERE `user_id` = NEW.user_id 
      AND `is_default` = TRUE
      AND `deleted_at` IS NULL;
  END IF;
END$$

CREATE TRIGGER `trg_user_addresses_before_update`
BEFORE UPDATE ON `user_addresses`
FOR EACH ROW
BEGIN
  IF NEW.is_default = TRUE AND (OLD.is_default = FALSE OR OLD.is_default IS NULL) THEN
    UPDATE `user_addresses` 
    SET `is_default` = FALSE 
    WHERE `user_id` = NEW.user_id 
      AND `id` != NEW.id 
      AND `is_default` = TRUE
      AND `deleted_at` IS NULL;
  END IF;
END$$

-- Trigger: Track address usage on update
CREATE TRIGGER `trg_user_addresses_track_usage`
BEFORE UPDATE ON `user_addresses`
FOR EACH ROW
BEGIN
  IF NEW.last_used_at > OLD.last_used_at OR OLD.last_used_at IS NULL THEN
    SET NEW.usage_count = OLD.usage_count + 1;
  END IF;
END$$

-- Trigger: Reset login attempts on successful login
CREATE TRIGGER `trg_users_after_login_success`
BEFORE UPDATE ON `users`
FOR EACH ROW
BEGIN
  IF NEW.last_login_at > OLD.last_login_at OR OLD.last_login_at IS NULL THEN
    SET NEW.login_attempts = 0;
    SET NEW.locked_until = NULL;
  END IF;
END$$

-- Trigger: Lock account after 5 failed login attempts
-- (This would typically be in application logic, but showing as example)
CREATE TRIGGER `trg_users_check_login_attempts`
BEFORE UPDATE ON `users`
FOR EACH ROW
BEGIN
  IF NEW.login_attempts >= 5 AND NEW.locked_until IS NULL THEN
    SET NEW.locked_until = DATE_ADD(NOW(), INTERVAL 30 MINUTE);
    SET NEW.status = 'suspended';
  END IF;
END$$

-- Trigger: Auto-create user_profile on user creation
CREATE TRIGGER `trg_users_after_insert`
AFTER INSERT ON `users`
FOR EACH ROW
BEGIN
  INSERT INTO `user_profiles` (`user_id`) VALUES (NEW.id);
  INSERT INTO `user_preferences` (`user_id`) VALUES (NEW.id);
END$$

DELIMITER ;

-- =====================================================
-- VIEWS: Common Query Patterns
-- =====================================================

-- View: Complete user profile with all related data
CREATE OR REPLACE VIEW `vw_user_complete_profile` AS
SELECT 
  u.id AS user_id,
  u.email,
  u.phone,
  u.status AS account_status,
  u.email_verified_at,
  u.phone_verified_at,
  u.last_login_at,
  u.created_at AS account_created_at,
  
  p.first_name,
  p.last_name,
  CONCAT_WS(' ', p.first_name, p.last_name) AS full_name,
  p.date_of_birth,
  TIMESTAMPDIFF(YEAR, p.date_of_birth, CURDATE()) AS age,
  p.gender,
  p.bio,
  p.profile_picture_url,
  p.city,
  p.country,
  p.language_code,
  p.timezone,
  
  pref.push_notifications_enabled,
  pref.email_notifications_enabled,
  pref.marketing_emails_consent,
  pref.theme,
  pref.currency_code
  
FROM `users` u
LEFT JOIN `user_profiles` p ON u.id = p.user_id
LEFT JOIN `user_preferences` pref ON u.id = pref.user_id;

-- View: User dietary summary
CREATE OR REPLACE VIEW `vw_user_dietary_summary` AS
SELECT 
  u.id AS user_id,
  u.email,
  GROUP_CONCAT(
    DISTINCT CASE 
      WHEN dr.category = 'allergen' THEN dr.name 
    END 
    ORDER BY dr.display_order 
    SEPARATOR ', '
  ) AS allergens,
  GROUP_CONCAT(
    DISTINCT CASE 
      WHEN dr.category IN ('diet_type', 'lifestyle', 'religious') THEN dr.name 
    END 
    ORDER BY dr.display_order 
    SEPARATOR ', '
  ) AS dietary_preferences,
  GROUP_CONCAT(
    DISTINCT CASE 
      WHEN udr.severity IN ('allergy', 'intolerance') THEN dr.name 
    END 
    ORDER BY dr.severity_level DESC, dr.display_order 
    SEPARATOR ', '
  ) AS critical_restrictions
FROM `users` u
LEFT JOIN `user_dietary_restrictions` udr ON u.id = udr.user_id
LEFT JOIN `dietary_restrictions` dr ON udr.restriction_id = dr.id
WHERE dr.is_active = TRUE
GROUP BY u.id, u.email;

-- View: Active user sessions
CREATE OR REPLACE VIEW `vw_active_sessions` AS
SELECT 
  s.id AS session_id,
  s.user_id,
  u.email,
  u.status AS user_status,
  s.device_type,
  s.device_name,
  s.browser_name,
  s.operating_system,
  s.ip_address,
  s.ip_city,
  s.ip_country,
  s.last_activity_at,
  s.expires_at,
  TIMESTAMPDIFF(MINUTE, s.last_activity_at, NOW()) AS minutes_since_activity,
  TIMESTAMPDIFF(MINUTE, NOW(), s.expires_at) AS minutes_until_expiry,
  s.is_trusted_device
FROM `sessions` s
INNER JOIN `users` u ON s.user_id = u.id
WHERE s.is_active = TRUE 
  AND s.expires_at > NOW()
  AND u.status = 'active';

-- View: User login statistics
CREATE OR REPLACE VIEW `vw_user_login_stats` AS
SELECT 
  u.id AS user_id,
  u.email,
  COUNT(ulh.id) AS total_login_attempts,
  SUM(CASE WHEN ulh.status = 'success' THEN 1 ELSE 0 END) AS successful_logins,
  SUM(CASE WHEN ulh.status = 'failed' THEN 1 ELSE 0 END) AS failed_logins,
  SUM(CASE WHEN ulh.status = 'suspicious' THEN 1 ELSE 0 END) AS suspicious_attempts,
  MAX(ulh.created_at) AS last_login_attempt,
  COUNT(DISTINCT ulh.ip_address) AS unique_ip_count,
  COUNT(DISTINCT ulh.device_id) AS unique_device_count,
  AVG(ulh.risk_score) AS avg_risk_score
FROM `users` u
LEFT JOIN `user_login_history` ulh ON u.id = ulh.user_id
GROUP BY u.id, u.email;

-- =====================================================
-- INDEXES: Performance Optimization
-- =====================================================

-- Additional composite indexes for common queries
ALTER TABLE `users` 
  ADD INDEX `idx_status_verified` (`status`, `email_verified_at`, `phone_verified_at`);

ALTER TABLE `user_profiles` 
  ADD INDEX `idx_location_search` (`country`, `city`, `state_province`);

ALTER TABLE `sessions` 
  ADD INDEX `idx_device_tracking` (`user_id`, `device_id`, `is_active`);

ALTER TABLE `user_login_history` 
  ADD INDEX `idx_security_analysis` (`user_id`, `is_suspicious`, `created_at`),
  ADD INDEX `idx_ip_analysis` (`ip_address`, `created_at`);

-- =====================================================
-- STORED PROCEDURES: Common Operations
-- =====================================================

DELIMITER $$

-- Procedure: Get user with all related data
CREATE PROCEDURE `sp_get_user_full_profile`(
  IN p_user_id BIGINT UNSIGNED
)
BEGIN
  -- Basic profile
  SELECT * FROM `vw_user_complete_profile` WHERE user_id = p_user_id;
  
  -- Addresses
  SELECT * FROM `user_addresses` 
  WHERE user_id = p_user_id AND deleted_at IS NULL
  ORDER BY is_default DESC, created_at DESC;
  
  -- Social links
  SELECT usl.*, sp.name AS platform_name, sp.icon_class
  FROM `user_social_links` usl
  INNER JOIN `social_platforms` sp ON usl.platform_id = sp.id
  WHERE usl.user_id = p_user_id AND usl.is_public = TRUE
  ORDER BY usl.display_order;
  
  -- Interests
  SELECT i.name, i.category
  FROM `user_interests` ui
  INNER JOIN `interests` i ON ui.interest_id = i.id
  WHERE ui.user_id = p_user_id AND i.is_active = TRUE
  ORDER BY i.display_order;
  
  -- Dietary restrictions
  SELECT dr.name, dr.category, dr.severity_level, udr.severity AS user_severity
  FROM `user_dietary_restrictions` udr
  INNER JOIN `dietary_restrictions` dr ON udr.restriction_id = dr.id
  WHERE udr.user_id = p_user_id AND dr.is_active = TRUE
  ORDER BY dr.severity_level DESC, dr.display_order;
END$$

-- Procedure: Cleanup expired sessions
CREATE PROCEDURE `sp_cleanup_expired_sessions`()
BEGIN
  UPDATE `sessions` 
  SET `is_active` = FALSE 
  WHERE `expires_at` < NOW() AND `is_active` = TRUE;
  
  SELECT ROW_COUNT() AS sessions_deactivated;
END$$

-- Procedure: Cleanup expired password reset tokens
CREATE PROCEDURE `sp_cleanup_expired_password_resets`()
BEGIN
  DELETE FROM `password_resets` 
  WHERE `expires_at` < DATE_SUB(NOW(), INTERVAL 7 DAY);
  
  SELECT ROW_COUNT() AS tokens_deleted;
END$$

-- Procedure: Get user security summary
CREATE PROCEDURE `sp_get_user_security_summary`(
  IN p_user_id BIGINT UNSIGNED
)
BEGIN
  -- Recent login attempts
  SELECT 
    login_method,
    status,
    failure_reason,
    ip_address,
    device_type,
    is_suspicious,
    created_at
  FROM `user_login_history`
  WHERE user_id = p_user_id
  ORDER BY created_at DESC
  LIMIT 10;
  
  -- Active sessions
  SELECT 
    device_type,
    device_name,
    ip_city,
    ip_country,
    last_activity_at,
    expires_at,
    is_trusted_device
  FROM `sessions`
  WHERE user_id = p_user_id AND is_active = TRUE AND expires_at > NOW();
  
  -- Recent activity
  SELECT 
    activity_type,
    activity_category,
    description,
    created_at
  FROM `user_activity_log`
  WHERE user_id = p_user_id
  ORDER BY created_at DESC
  LIMIT 20;
END$$

DELIMITER ;

COMMIT;

-- =====================================================
-- NORMALIZATION SUMMARY & DOCUMENTATION
-- =====================================================
--
-- ENTITIES CREATED: 14 tables + 3 reference tables = 17 total
--
-- 1. users - Core authentication (3NF ✓)
-- 2. user_profiles - Personal info (3NF ✓)
-- 3. social_platforms - Reference data (3NF ✓)
-- 4. user_social_links - Many-to-many junction (3NF ✓)
-- 5. interests - Reference data (3NF ✓)
-- 6. user_interests - Many-to-many junction (3NF ✓)
-- 7. dietary_restrictions - Reference data (3NF ✓)
-- 8. user_dietary_restrictions - Many-to-many junction (3NF ✓)
-- 9. user_preferences - App settings (3NF ✓)
-- 10. user_addresses - Delivery addresses (3NF ✓)
-- 11. sessions - Active sessions (3NF ✓)
-- 12. password_resets - Password reset tokens (3NF ✓)
-- 13. user_login_history - Authentication audit (3NF ✓)
-- 14. user_activity_log - General activity audit (3NF ✓)
--
-- NORMALIZATION ACHIEVEMENTS:
-- ✓ Zero JSON arrays for core data (1NF compliant)
-- ✓ All non-key attributes depend on entire primary key (2NF)
-- ✓ No transitive dependencies (3NF)
-- ✓ Proper foreign key constraints with CASCADE
-- ✓ Reference/lookup tables for repeating data
-- ✓ Separate concerns (auth, profile, settings, audit)
--
-- FEATURES INCLUDED:
-- ✓ GDPR compliance (consent tracking, soft deletes, audit trail)
-- ✓ Security (login history, session management, password resets)
-- ✓ Accessibility (preferences for UI/UX customization)
-- ✓ Internationalization (language, timezone, currency)
-- ✓ Privacy controls (data sharing consent, visibility settings)
-- ✓ Audit trail (activity log, login history)
-- ✓ Data integrity (triggers, constraints, views)
-- ✓ Performance optimization (indexes, stored procedures)
--
-- NEXT STEPS:
-- - Test all CRUD operations
-- - Verify trigger behavior
-- - Load test with sample data
-- - Security audit
-- - Add additional indexes based on query patterns
-- - Implement application-level validation
-- - Set up monitoring and alerting
-- - Create backup/restore procedures
--
-- =====================================================
