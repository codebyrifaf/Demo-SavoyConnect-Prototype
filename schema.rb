# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.
#
# SavoyConnect Database Schema
# Total Tables: 80
# Generated: November 11, 2025

ActiveRecord::Schema[7.1].define(version: 2025_11_11_000000) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql" if ActiveRecord::Base.connection.adapter_name == "PostgreSQL"

  # =====================================================
  # SECTION 1: USER MANAGEMENT (Tables 1-6)
  # =====================================================

  create_table "users", id: { type: :bigint, unsigned: true }, force: :cascade do |t|
    t.string "email", limit: 255, null: false
    t.string "phone", limit: 20
    t.string "password_hash", limit: 255, null: false
    t.string "first_name", limit: 100
    t.string "last_name", limit: 100
    t.date "date_of_birth"
    t.integer "gender", limit: 1, default: 0, comment: "0:male, 1:female, 2:other, 3:prefer_not_to_say"
    t.string "profile_picture_url", limit: 500
    t.boolean "email_verified", default: false, null: false
    t.boolean "phone_verified", default: false, null: false
    t.integer "status", limit: 1, default: 0, null: false, comment: "0:active, 1:inactive, 2:suspended, 3:deleted"
    t.timestamp "last_login_at"
    t.timestamps
    t.timestamp "deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone"], name: "index_users_on_phone", unique: true
    t.index ["status"], name: "index_users_on_status"
    t.index ["created_at"], name: "index_users_on_created_at"
  end

  create_table "user_profiles", id: { type: :bigint, unsigned: true }, force: :cascade do |t|
    t.bigint "user_id", null: false, unsigned: true
    t.text "bio"
    t.string "occupation", limit: 100
    t.string "company", limit: 255
    t.string "website", limit: 500
    t.string "location", limit: 255
    t.json "social_links", comment: "Social media profile links"
    t.json "interests", comment: "User interests array"
    t.json "dietary_preferences", comment: "Dietary restrictions and preferences"
    t.string "language_preference", limit: 10, default: "en", null: false, comment: "en, bn"
    t.timestamps
    t.index ["user_id"], name: "index_user_profiles_on_user_id", unique: true
  end

  create_table "user_preferences", id: { type: :bigint, unsigned: true }, force: :cascade do |t|
    t.bigint "user_id", null: false, unsigned: true
    t.boolean "email_notifications", default: true, null: false
    t.boolean "sms_notifications", default: true, null: false
    t.boolean "push_notifications", default: true, null: false
    t.boolean "marketing_emails", default: true, null: false
    t.boolean "order_updates", default: true, null: false
    t.boolean "promotional_offers", default: true, null: false
    t.boolean "newsletter_subscription", default: false, null: false
    t.boolean "product_recommendations", default: true, null: false
    t.boolean "recipe_suggestions", default: true, null: false
    t.boolean "challenge_invitations", default: true, null: false
    t.boolean "social_activity_updates", default: true, null: false
    t.boolean "weekly_digest", default: false, null: false
    t.integer "theme", limit: 1, default: 2, null: false, comment: "0:light, 1:dark, 2:auto"
    t.string "currency", limit: 3, default: "BDT", null: false
    t.string "timezone", limit: 100, default: "Asia/Dhaka", null: false
    t.timestamps
    t.index ["user_id"], name: "index_user_preferences_on_user_id", unique: true
  end

  create_table "user_addresses", id: { type: :bigint, unsigned: true }, force: :cascade do |t|
    t.bigint "user_id", null: false, unsigned: true
    t.integer "address_type", limit: 1, default: 0, null: false, comment: "0:home, 1:work, 2:other"
    t.string "label", limit: 100, comment: "Custom label like Mom's House"
    t.string "recipient_name", limit: 255
    t.string "recipient_phone", limit: 20
    t.string "street_address", limit: 500, null: false
    t.string "landmark", limit: 255
    t.string "area", limit: 255
    t.string "city", limit: 100, null: false
    t.string "state", limit: 100
    t.string "postal_code", limit: 20
    t.string "country", limit: 100, default: "Bangladesh", null: false
    t.decimal "latitude", precision: 10, scale: 8
    t.decimal "longitude", precision: 11, scale: 8
    t.boolean "is_default", default: false, null: false
    t.text "delivery_instructions"
    t.timestamps
    t.timestamp "deleted_at"
    t.index ["user_id"], name: "index_user_addresses_on_user_id"
    t.index ["is_default"], name: "index_user_addresses_on_is_default"
    t.index ["city"], name: "index_user_addresses_on_city"
  end

  create_table "sessions", id: { type: :bigint, unsigned: true }, force: :cascade do |t|
    t.bigint "user_id", null: false, unsigned: true
    t.string "session_token", limit: 255, null: false
    t.string "refresh_token", limit: 255
    t.integer "device_type", limit: 1, null: false, comment: "0:web, 1:mobile, 2:tablet, 3:desktop"
    t.string "device_name", limit: 255
    t.string "browser", limit: 100
    t.string "operating_system", limit: 100
    t.string "ip_address", limit: 45
    t.text "user_agent"
    t.timestamp "last_activity", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.timestamp "expires_at", null: false
    t.boolean "is_active", default: true, null: false
    t.timestamp "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["session_token"], name: "index_sessions_on_session_token", unique: true
    t.index ["user_id"], name: "index_sessions_on_user_id"
    t.index ["expires_at"], name: "index_sessions_on_expires_at"
    t.index ["is_active"], name: "index_sessions_on_is_active"
  end

  create_table "password_resets", id: { type: :bigint, unsigned: true }, force: :cascade do |t|
    t.bigint "user_id", null: false, unsigned: true
    t.string "token", limit: 255, null: false
    t.string "email", limit: 255, null: false
    t.boolean "is_used", default: false, null: false
    t.timestamp "used_at"
    t.timestamp "expires_at", null: false
    t.string "ip_address", limit: 45
    t.text "user_agent"
    t.timestamp "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["token"], name: "index_password_resets_on_token", unique: true
    t.index ["user_id"], name: "index_password_resets_on_user_id"
    t.index ["email"], name: "index_password_resets_on_email"
    t.index ["expires_at"], name: "index_password_resets_on_expires_at"
  end

  # =====================================================
  # SECTION 2: PRODUCT CATALOG (Tables 7-11)
  # =====================================================

  create_table "product_categories", id: { type: :bigint, unsigned: true }, force: :cascade do |t|
    t.bigint "parent_id", unsigned: true
    t.string "name", limit: 255, null: false
    t.string "slug", limit: 255, null: false
    t.text "description"
    t.string "icon_url", limit: 500
    t.string "image_url", limit: 500
    t.string "banner_url", limit: 500
    t.integer "display_order", default: 0, null: false
    t.integer "level", default: 0, null: false, comment: "Hierarchy level: 0 = root, 1 = child, etc."
    t.boolean "is_active", default: true, null: false
    t.boolean "is_featured", default: false, null: false
    t.integer "product_count", default: 0, null: false
    t.string "meta_title", limit: 255
    t.string "meta_description", limit: 500
    t.string "color_code", limit: 7, comment: "Hex color for UI"
    t.json "tags"
    t.timestamps
    t.index ["slug"], name: "index_product_categories_on_slug", unique: true
    t.index ["parent_id"], name: "index_product_categories_on_parent_id"
    t.index ["is_active"], name: "index_product_categories_on_is_active"
    t.index ["display_order"], name: "index_product_categories_on_display_order"
  end

  create_table "products", id: { type: :bigint, unsigned: true }, force: :cascade do |t|
    t.string "product_code", limit: 100, null: false
    t.string "barcode", limit: 100
    t.string "name", limit: 255, null: false
    t.string "slug", limit: 255, null: false
    t.text "description"
    t.string "short_description", limit: 500
    t.bigint "category_id", unsigned: true
    t.string "brand", limit: 255
    t.string "manufacturer", limit: 255
    t.string "origin_country", limit: 100
    t.string "unit", limit: 50, null: false, comment: "kg, liter, piece, pack"
    t.decimal "unit_value", precision: 10, scale: 2, null: false, comment: "Numeric value of unit"
    t.decimal "price", precision: 10, scale: 2, null: false
    t.decimal "compare_price", precision: 10, scale: 2, comment: "Original price before discount"
    t.decimal "cost_price", precision: 10, scale: 2, comment: "Cost to business"
    t.string "currency", limit: 3, default: "BDT", null: false
    t.decimal "tax_percentage", precision: 5, scale: 2, default: 0.0, null: false
    t.boolean "is_taxable", default: false, null: false
    t.decimal "weight", precision: 10, scale: 2, comment: "Weight in kg"
    t.json "dimensions", comment: "Length, width, height in cm"
    t.integer "stock_quantity", default: 0, null: false
    t.integer "low_stock_threshold", default: 10, null: false
    t.boolean "is_available", default: true, null: false
    t.integer "status", limit: 1, default: 0, null: false, comment: "0:active, 1:inactive, 2:out_of_stock, 3:discontinued"
    t.boolean "featured", default: false, null: false
    t.json "tags", comment: "Product tags array"
    t.string "meta_title", limit: 255
    t.string "meta_description", limit: 500
    t.timestamps
    t.timestamp "deleted_at"
    t.index ["product_code"], name: "index_products_on_product_code", unique: true
    t.index ["slug"], name: "index_products_on_slug", unique: true
    t.index ["barcode"], name: "index_products_on_barcode"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["status"], name: "index_products_on_status"
    t.index ["featured"], name: "index_products_on_featured"
    t.index ["price"], name: "index_products_on_price"
    t.index ["category_id", "status"], name: "index_products_on_category_status"
    t.index ["featured", "status"], name: "index_products_on_featured_status"
  end

  create_table "product_nutrition", id: { type: :bigint, unsigned: true }, force: :cascade do |t|
    t.bigint "product_id", null: false, unsigned: true
    t.string "serving_size", limit: 100, null: false, comment: "100g, 1 cup, 1 piece"
    t.decimal "servings_per_container", precision: 5, scale: 2
    t.decimal "calories", precision: 8, scale: 2, null: false
    t.decimal "calories_from_fat", precision: 8, scale: 2
    t.decimal "total_fat", precision: 8, scale: 2, comment: "Grams"
    t.decimal "saturated_fat", precision: 8, scale: 2
    t.decimal "trans_fat", precision: 8, scale: 2
    t.decimal "cholesterol", precision: 8, scale: 2, comment: "Milligrams"
    t.decimal "sodium", precision: 8, scale: 2, comment: "Milligrams"
    t.decimal "total_carbohydrates", precision: 8, scale: 2, comment: "Grams"
    t.decimal "dietary_fiber", precision: 8, scale: 2
    t.decimal "sugars", precision: 8, scale: 2
    t.decimal "added_sugars", precision: 8, scale: 2
    t.decimal "protein", precision: 8, scale: 2, comment: "Grams"
    t.decimal "vitamin_a", precision: 8, scale: 2
    t.decimal "vitamin_c", precision: 8, scale: 2
    t.decimal "vitamin_d", precision: 8, scale: 2
    t.decimal "calcium", precision: 8, scale: 2
    t.decimal "iron", precision: 8, scale: 2
    t.decimal "potassium", precision: 8, scale: 2
    t.text "ingredients", comment: "Full ingredient list"
    t.json "nutritional_claims", comment: "Low-fat, organic, etc."
    t.decimal "health_score", precision: 3, scale: 2, comment: "Score 0-5"
    t.timestamps
    t.index ["product_id"], name: "index_product_nutrition_on_product_id", unique: true
  end

  create_table "product_allergens", id: { type: :bigint, unsigned: true }, force: :cascade do |t|
    t.bigint "product_id", null: false, unsigned: true
    t.integer "allergen_type", limit: 1, null: false, comment: "0:milk, 1:eggs, 2:fish, 3:shellfish, 4:tree_nuts, 5:peanuts, 6:wheat, 7:soybeans, 8:gluten, 9:sesame, 10:sulfites, 11:mustard"
    t.integer "severity", limit: 1, null: false, comment: "0:contains, 1:may_contain, 2:free"
    t.text "notes"
    t.timestamp "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["product_id"], name: "index_product_allergens_on_product_id"
    t.index ["allergen_type"], name: "index_product_allergens_on_allergen_type"
  end

  create_table "product_images", id: { type: :bigint, unsigned: true }, force: :cascade do |t|
    t.bigint "product_id", null: false, unsigned: true
    t.string "image_url", limit: 1000, null: false
    t.string "thumbnail_url", limit: 1000
    t.integer "image_type", limit: 1, default: 1, null: false, comment: "0:main, 1:gallery, 2:thumbnail, 3:lifestyle, 4:360"
    t.string "alt_text", limit: 255
    t.string "title", limit: 255
    t.integer "display_order", default: 0, null: false
    t.integer "width"
    t.integer "height"
    t.bigint "file_size", comment: "Size in bytes"
    t.boolean "is_primary", default: false, null: false
    t.timestamps
    t.index ["product_id"], name: "index_product_images_on_product_id"
    t.index ["image_type"], name: "index_product_images_on_image_type"
    t.index ["display_order"], name: "index_product_images_on_display_order"
  end

  # =====================================================
  # SECTION 3: ORDER MANAGEMENT (Tables 12-15)
  # =====================================================

  create_table "orders", id: { type: :bigint, unsigned: true }, force: :cascade do |t|
    t.string "order_number", limit: 100, null: false
    t.bigint "user_id", null: false, unsigned: true
    t.integer "status", limit: 1, default: 0, null: false, comment: "0:pending, 1:confirmed, 2:processing, 3:ready, 4:out_for_delivery, 5:delivered, 6:cancelled, 7:refunded"
    t.integer "payment_status", limit: 1, default: 0, null: false, comment: "0:pending, 1:paid, 2:failed, 3:refunded, 4:partially_refunded"
    t.decimal "subtotal", precision: 10, scale: 2, null: false
    t.decimal "tax_amount", precision: 10, scale: 2, default: 0.0, null: false
    t.decimal "delivery_fee", precision: 10, scale: 2, default: 0.0, null: false
    t.decimal "discount_amount", precision: 10, scale: 2, default: 0.0, null: false
    t.integer "icecoins_used", default: 0, null: false
    t.decimal "icecoins_value", precision: 10, scale: 2, default: 0.0, null: false
    t.decimal "total_amount", precision: 10, scale: 2, null: false
    t.string "currency", limit: 3, default: "BDT", null: false
    t.bigint "delivery_address_id", unsigned: true
    t.json "delivery_address_snapshot", comment: "Address details at order time"
    t.date "delivery_date"
    t.string "delivery_time_slot", limit: 100
    t.text "delivery_instructions"
    t.bigint "location_id", unsigned: true, comment: "Fulfillment location"
    t.string "promotion_code", limit: 100
    t.decimal "promotion_discount", precision: 10, scale: 2, default: 0.0, null: false
    t.text "notes"
    t.text "customer_notes"
    t.text "internal_notes"
    t.integer "items_count", default: 0, null: false
    t.string "ip_address", limit: 45
    t.text "user_agent"
    t.timestamp "confirmed_at"
    t.timestamp "cancelled_at"
    t.text "cancellation_reason"
    t.timestamp "delivered_at"
    t.timestamps
    t.index ["order_number"], name: "index_orders_on_order_number", unique: true
    t.index ["user_id"], name: "index_orders_on_user_id"
    t.index ["status"], name: "index_orders_on_status"
    t.index ["payment_status"], name: "index_orders_on_payment_status"
    t.index ["delivery_date"], name: "index_orders_on_delivery_date"
    t.index ["created_at"], name: "index_orders_on_created_at"
    t.index ["user_id", "status"], name: "index_orders_on_user_status"
    t.index ["user_id", "created_at"], name: "index_orders_on_user_created"
  end

  create_table "order_items", id: { type: :bigint, unsigned: true }, force: :cascade do |t|
    t.bigint "order_id", null: false, unsigned: true
    t.bigint "product_id", null: false, unsigned: true
    t.string "product_name", limit: 255, null: false
    t.string "product_code", limit: 100, null: false
    t.integer "quantity", null: false
    t.decimal "unit_price", precision: 10, scale: 2, null: false
    t.decimal "subtotal", precision: 10, scale: 2, null: false
    t.decimal "tax_amount", precision: 10, scale: 2, default: 0.0, null: false
    t.decimal "discount_amount", precision: 10, scale: 2, default: 0.0, null: false
    t.decimal "total_amount", precision: 10, scale: 2, null: false
    t.json "product_snapshot", comment: "Product details at order time"
    t.timestamp "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
  end

  create_table "order_status_history", id: { type: :bigint, unsigned: true }, force: :cascade do |t|
    t.bigint "order_id", null: false, unsigned: true
    t.string "old_status", limit: 50
    t.string "new_status", limit: 50, null: false
    t.bigint "changed_by", unsigned: true, comment: "User or admin ID"
    t.integer "changed_by_type", limit: 1, default: 2, null: false, comment: "0:user, 1:admin, 2:system"
    t.text "notes"
    t.json "metadata"
    t.string "ip_address", limit: 45
    t.timestamp "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["order_id"], name: "index_order_status_history_on_order_id"
    t.index ["new_status"], name: "index_order_status_history_on_new_status"
    t.index ["created_at"], name: "index_order_status_history_on_created_at"
  end

  create_table "payment_methods", id: { type: :bigint, unsigned: true }, force: :cascade do |t|
    t.bigint "user_id", null: false, unsigned: true
    t.integer "method_type", limit: 1, null: false, comment: "0:card, 1:bank_account, 2:mobile_banking, 3:wallet"
    t.string "provider", limit: 100, comment: "visa, mastercard, bkash, etc."
    t.string "account_name", limit: 255
    t.string "account_number", limit: 255, comment: "Last 4 digits or masked"
    t.string "account_number_encrypted", limit: 500, comment: "Full encrypted number"
    t.integer "expiry_month"
    t.integer "expiry_year"
    t.string "cvv_hash", limit: 255
    t.json "billing_address"
    t.boolean "is_default", default: false, null: false
    t.boolean "is_verified", default: false, null: false
    t.string "token", limit: 500, comment: "Gateway token"
    t.string "gateway", limit: 100
    t.timestamp "last_used_at"
    t.timestamps
    t.timestamp "deleted_at"
    t.index ["user_id"], name: "index_payment_methods_on_user_id"
    t.index ["method_type"], name: "index_payment_methods_on_method_type"
    t.index ["is_default"], name: "index_payment_methods_on_is_default"
  end

  create_table "payments", id: { type: :bigint, unsigned: true }, force: :cascade do |t|
    t.bigint "order_id", null: false, unsigned: true
    t.bigint "user_id", null: false, unsigned: true
    t.bigint "payment_method_id", unsigned: true
    t.integer "payment_method", limit: 1, null: false, comment: "0:cash, 1:card, 2:bkash, 3:nagad, 4:rocket, 5:upay, 6:bank_transfer, 7:icecoins, 8:wallet"
    t.string "transaction_id", limit: 255
    t.string "payment_gateway", limit: 100, comment: "stripe, sslcommerz, etc."
    t.string "gateway_transaction_id", limit: 255
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.string "currency", limit: 3, default: "BDT", null: false
    t.integer "status", limit: 1, default: 0, null: false, comment: "0:pending, 1:processing, 2:completed, 3:failed, 4:refunded, 5:cancelled"
    t.timestamp "payment_date"
    t.decimal "refund_amount", precision: 10, scale: 2, default: 0.0, null: false
    t.timestamp "refund_date"
    t.text "refund_reason"
    t.json "gateway_response"
    t.text "error_message"
    t.text "notes"
    t.string "ip_address", limit: 45
    t.string "payment_screenshot", limit: 500
    t.bigint "verified_by", unsigned: true
    t.timestamp "verified_at"
    t.timestamps
    t.index ["order_id"], name: "index_payments_on_order_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
    t.index ["transaction_id"], name: "index_payments_on_transaction_id"
    t.index ["status"], name: "index_payments_on_status"
    t.index ["payment_date"], name: "index_payments_on_payment_date"
  end

  # Continue with remaining sections...
  # Note: Due to length limits, I'm showing the pattern. The full schema.rb would include all 80 tables.

  # Foreign Key Constraints
  add_foreign_key "user_profiles", "users", on_delete: :cascade
  add_foreign_key "user_preferences", "users", on_delete: :cascade
  add_foreign_key "user_addresses", "users", on_delete: :cascade
  add_foreign_key "sessions", "users", on_delete: :cascade
  add_foreign_key "password_resets", "users", on_delete: :cascade
  add_foreign_key "product_categories", "product_categories", column: "parent_id", on_delete: :nullify
  add_foreign_key "products", "product_categories", column: "category_id", on_delete: :nullify
  add_foreign_key "product_nutrition", "products", on_delete: :cascade
  add_foreign_key "product_allergens", "products", on_delete: :cascade
  add_foreign_key "product_images", "products", on_delete: :cascade
  add_foreign_key "orders", "users", on_delete: :cascade
  add_foreign_key "orders", "user_addresses", column: "delivery_address_id", on_delete: :nullify
  add_foreign_key "order_items", "orders", on_delete: :cascade
  add_foreign_key "order_items", "products", on_delete: :restrict
  add_foreign_key "order_status_history", "orders", on_delete: :cascade
  add_foreign_key "payments", "orders", on_delete: :cascade
  add_foreign_key "payments", "users", on_delete: :cascade
  add_foreign_key "payments", "payment_methods", on_delete: :nullify
  add_foreign_key "payment_methods", "users", on_delete: :cascade

  # Additional foreign keys would continue for all 80 tables...

end
