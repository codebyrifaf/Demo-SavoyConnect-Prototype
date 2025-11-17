# SavoyConnect ERD - Quick Reference Guide

## 📊 Your ER Diagrams Are Ready!

I've created **3 comprehensive ER diagram files** for your SavoyConnect database:

### 1️⃣ **SavoyConnect_ERD.md** - Complete Overview
- **Single comprehensive diagram** showing all 80 tables
- All relationships mapped
- Quick reference for the entire database
- **Best for**: Understanding the big picture

### 2️⃣ **SavoyConnect_ERD_Detailed.md** - Section-by-Section
- **10 detailed diagrams** organized by feature
- Each section shows tables with full column details
- Includes summary statistics
- **Best for**: Deep diving into specific modules

### 3️⃣ **SavoyConnect_ERD.vuerd.json** - Interactive Editor
- **Interactive visual editor** format
- Can be opened with ERD Editor extension
- **Best for**: Visual editing and exploration

---

## 🎯 How to View Your ERD

### Method 1: Markdown Preview (Recommended - Instant View)
1. Open `SavoyConnect_ERD.md` in VS Code
2. Press `Ctrl+Shift+V` (Windows) or `Cmd+Shift+V` (Mac)
3. The Mermaid diagram will render automatically!

### Method 2: Side-by-Side View
1. Right-click on `SavoyConnect_ERD.md`
2. Select **"Open Preview to the Side"**
3. View code and diagram simultaneously

### Method 3: ERD Editor Extension (Visual Editing)
1. Open `SavoyConnect_ERD.vuerd.json`
2. The ERD Editor will launch automatically
3. You can drag, zoom, and edit visually

---

## 📋 Database Overview

### Total Statistics
- **80 Tables** across 5 phases
- **100+ Relationships** mapped
- **MySQL 8.0+** compatible
- **utf8mb4** character encoding

### Key Sections
1. **User Management** (7 tables) - Users, profiles, addresses, sessions
2. **Product Catalog** (5 tables) - Products, categories, nutrition, images
3. **Order System** (9 tables) - Orders, payments, delivery tracking
4. **Loyalty Program** (7 tables) - IceCoins, rewards, challenges
5. **Social Features** (8 tables) - Posts, follows, likes, comments
6. **Recipes** (5 tables) - User recipes, ingredients, tries
7. **Gamification** (6 tables) - Badges, leaderboards, achievements
8. **Analytics** (8 tables) - Tracking, search, conversions
9. **Trust System** (5 tables) - Verification, sustainability
10. **Administration** (10 tables) - Admin users, roles, API management
11. **System** (10 tables) - Files, webhooks, errors, jobs

---

## 🔗 Quick Navigation

### Core Business Flow
```
User Registration → Browse Products → Add to Cart → 
Create Order → Process Payment → Assign Delivery → 
Deliver Order → Earn IceCoins → Write Review
```

### Major Entity Relationships
- `users` ↔ `orders` (One-to-Many)
- `orders` ↔ `order_items` (One-to-Many)
- `products` ↔ `order_items` (Many-to-Many via junction)
- `users` ↔ `icecoins_wallet` (One-to-One)
- `users` ↔ `recipes` (One-to-Many)
- `recipes` ↔ `products` (Many-to-Many via `recipe_products`)

---

## 💡 Tips for Working with the ERD

### 1. Search for Specific Tables
Press `Ctrl+F` in the markdown file and search for table names:
- Example: Search "orders" to find all order-related relationships

### 2. Understand Relationships
- `||--||` = One-to-One
- `||--o{` = One-to-Many
- `}o--o{` = Many-to-Many

### 3. Export Options
- **PNG/SVG**: Use Mermaid CLI or online tools
- **PDF**: Print preview from VS Code
- **Share**: The markdown files work on GitHub, GitLab, etc.

---

## 🎨 Viewing Detailed Diagrams

For **module-specific diagrams**, open `SavoyConnect_ERD_Detailed.md`:

1. **User Management** - Complete user lifecycle
2. **Product Catalog** - Product hierarchy and details
3. **Order & Payment** - Order processing flow
4. **Delivery System** - Logistics and tracking
5. **Loyalty & Rewards** - IceCoins ecosystem
6. **Reviews & Ratings** - Feedback system
7. **Recipes Platform** - Recipe management
8. **Social Features** - Community interaction
9. **Gamification** - Challenges and badges
10. **Analytics** - Data tracking

Each section shows:
- ✅ Table structure with all columns
- ✅ Data types and constraints
- ✅ Foreign key relationships
- ✅ Comments and descriptions

---

## 🚀 Next Steps

### For Development
1. Review the ERD to understand data flow
2. Use diagrams for API endpoint planning
3. Reference for writing database queries
4. Guide for creating ORM models

### For Documentation
1. Include ERD in project documentation
2. Share with team members
3. Use for onboarding new developers
4. Reference in technical specifications

### For Database Management
1. Verify all foreign keys are correct
2. Check indexes are properly set
3. Plan data migrations
4. Design backup strategies

---

## 📝 File Locations

All files are in your project root:
```
e:\Demo-SavoyConnect-Prototype\
├── SavoyConnect_DDL_Phase1_MVP.sql     ← Original SQL file
├── SavoyConnect_ERD.md                  ← Complete ERD (this one!)
├── SavoyConnect_ERD_Detailed.md         ← Detailed sections
└── SavoyConnect_ERD.vuerd.json          ← ERD Editor format
```

---

## ✨ Features of Your ERD

### ✅ Comprehensive Coverage
- All 80 tables included
- Every foreign key relationship mapped
- Primary keys clearly marked
- Data types specified

### ✅ Visual Clarity
- Color-coded by Mermaid
- Hierarchical layout
- Clear relationship lines
- Organized by sections

### ✅ Interactive Options
- Clickable in VS Code preview
- Zoom in/out support
- Search functionality
- Export capabilities

---

## 🆘 Troubleshooting

### Diagram not rendering?
1. Install "Markdown Preview Mermaid Support" extension
2. Restart VS Code
3. Try opening preview again

### Need to edit the diagram?
1. Open the `.md` file
2. Edit the Mermaid syntax directly
3. Changes reflect immediately in preview

### Want a different format?
- **PlantUML**: Export from ERD Editor
- **Draw.io**: Import SQL via extensions
- **DbSchema**: Commercial tool with SQL import

---

## 📞 Need Help?

- **Mermaid Docs**: https://mermaid.js.org/
- **ERD Editor Docs**: VS Code extension documentation
- **SQL Review**: Check `SavoyConnect_DDL_Phase1_MVP.sql`

---

*Generated: November 11, 2025*  
*Total Tables: 80 | Total Relationships: 100+*  
*Database: SavoyConnect | Engine: MySQL 8.0+*

**🎉 Your complete ER diagram is ready to use!**
