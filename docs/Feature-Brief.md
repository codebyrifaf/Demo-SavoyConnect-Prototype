

### 1.1 Ordering Flow (Pieces or Liters)
- What: Order by pieces (boxes) or liters. Real-time totals, delivery fee threshold, validation, and a structured delivery form.
- Why: Supports retail carton flows and HoReCa bulk ordering.
- User value: Clear pricing/minimums; fast, trustworthy checkout.
- Company value: Fewer manual corrections; higher conversion; controllable unit economics.
- KPIs: Checkout conversion, AOV, repeat order rate, validation drop-offs.
 

### 1.2 Payment Methods & Preferences
- What: Settings area for payment methods and user preferences (UI shell in prototype).
- Why: Faster repeat checkout; fewer payment failures.
- User value: Saved methods and consistent defaults.
- Company value: Higher repeat rate; lower friction and support load.
- KPIs: Saved-method penetration, repeat checkout time, payment failure rate.
 

### 1.3 Customer Care, Help Center, About
- What: Customer Care modal, Help Center entry, and About modal within Settings.
- Why: Industrial buyers expect clear support and self-service.
- User value: Faster answers and resolution.
- Company value: Lower churn; deflection of simple tickets.
- KPIs: CSAT, First Response Time, Time to Resolution, deflection rate.
 

### 1.4 Terms & Conditions (Compliance)
- What: T&C modal accessible from Settings.
- Why: Legal clarity for usage, orders, warranties, and data handling.
- User value: Transparency and trust.
- Company value: Risk mitigation; policy enforcement.
- KPIs: T&C acceptance (if gated), dispute rate per 1,000 orders.
 

### 1.5 Flavor Ratings & Reviews
- What: Star ratings + text reviews per flavor, with character count and report action.
- Why: Social proof improves conversion and guides product improvements.
- User value: Trust in flavor choices; voice in product quality.
- Company value: Conversion lift; sentiment telemetry by SKU/region/batch.
- KPIs: Review coverage, average rating, sentiment trend, conversion lift on reviewed SKUs.
 

### 1.6 Store Reviews (Location-level)
- What: Reviews for store/outlet locations in addition to products.
- Why: Surfaces service quality and operational issues by location.
- User value: Informed decisions about where to purchase.
- Company value: Ops insights; targeted training and QA.
- KPIs: Store NPS, review velocity by region, correlation to sales/returns.
 

### 1.7 Recipe Discovery (Catalog + Filters + Details)
- What: “All Recipes” screen with categories/filters, images, and a detailed view (ingredients, steps). Links to relevant flavors.
- Why: Content marketing that converts interest into product demand.
- User value: Inspiration and step-by-step guidance.
- Company value: Cross-sell; longer sessions; brand affinity.
- KPIs: Recipe views/session, filter usage, CTR to product/order, assisted conversions.
 

### 1.8 Wallet & Loyalty (IceCoins UI)
- What: A complete loyalty hub with:
	- Wallet home card showing balance with “Earn More” and “Redeem” CTAs.
	- Recent Activity ledger with positive/negative entries (e.g., Purchase Reward +50, Reward Redeemed −200, Challenge Complete +100) and short descriptions.
	- Available Rewards gallery and a Redeem Rewards list with tile cards (e.g., Free Scoop 200, Double Scoop Deal 350, Ice Cream Cake 500, Mystery Flavor Box 1000 IceCoins).
	- Prototype accrual/burn from purchases, challenges, promos; redemption confirmation via toast.
- Why: Makes loyalty tangible by showing value, history, and clear ways to redeem—driving retention and frequency.
- User value: Know exactly how many coins they have, where they came from, and what they can get—redeem in a tap.
- Company value: Increases repeat rate and ARPU; creates room for targeted promos (e.g., Double IceCoins Week) and cross‑feature ties (Challenges, Community).
- KPIs: Wallet adoption, redemption rate, time‑to‑first redemption, earn:burn ratio, outstanding liability, promo uplift (e.g., double‑points CTR to redemption), share of accrual from challenges.
  
	Notes: In production, keep a server‑side ledger, anti‑abuse checks (rate limits, device/account heuristics), expiration policy, and dispute workflow. Integrates with Promotions & Ads Center for campaigns and with Challenges for earn events; enables contextual badges in Community posts.
 

### 1.9 Notifications & Toasts
- What: Non-blocking notifications for key actions (e.g., ordering, games placeholders).
- Why: Inform users without breaking flow.
- User value: Clear feedback.
- Company value: Better UX and reduced support confusion.
- KPIs: Error vs. success rate, frequency of repeat attempts.
 

### 1.10 Search & History (Recipes)
- What: Basic recipe search/history tracking .
- Why: Return to recent items quickly; inform content strategy.
- User value: Convenience.
- Company value: Insights into content demand.
- KPIs: Search frequency, top queries, revisit rate.
 

### 1.11 Nearby Availability Finder
- What: Search a flavor and see nearby retailers, Depo, Freezers with live/near-real-time availability; suggest similar substitutes when unavailable.
- Why: Reduces lost sales due to stock-outs and increases user satisfaction by guiding to alternatives.
- User value: Saves time finding desired products; smart substitutes.
- Company value: Higher conversion; better inventory utilization.
- KPIs: Successful find rate, substitute acceptance rate, store visit CTR.
 

### 1.12 Map View + Directions
- What: Integrated map (Google Maps/Mapbox) of nearby Savoy retailers, Depo's and Freezers with filters (open now) and one-tap directions.
- Why: Bridges discovery to physical purchase.
- User value: Visual proximity and fast navigation.
- Company value: Drives footfall to retail partners; tracks campaign effectiveness by region.
- KPIs: Map opens, filter usage, directions taps.
 

### 1.13 Stock Notification System
- What: “Notify me” when a flavor is back in stock nearby; alerts via in-app and/or push/email.
- Why: Recovers demand that would otherwise churn.
- User value: Confidence they won’t miss desired items.
- Company value: Increased recapture rate; demand signaling for replenishment.
- KPIs: Notify opt-ins, alert open rate, post-alert conversion.
 

### 1.14 Barcode/QR Scan
- What: Scan package QR/barcode to show authenticity, ingredient/allergen info, active promos and increase wallet points.
- Why: Builds trust and drives promotional engagement at point-of-use.
- User value: Safety and savings.
- Company value: Anti-counterfeit telemetry; promo attribution.
- KPIs: Scans per 1,000 packs, promo redemption rate, authenticity checks, earn points.
 

### 1.15 News & Campaign Feed
- What: In-app feed for flavor launches, CSR updates, seasonal offers.
- Why: Always-on consumer communication channel.
- User value: Stay informed about what matters to them.
- Company value: Increased campaign reach without paid media.
- KPIs: Feed views, post CTR, offer redemption.
 

### 1.16 Leaderboards (Engagement)
- What: Leaderboard UI with period toggles (weekly/monthly/all-time) for the most wallet point gainer; 
- Why: Optional engagement mechanic for community and contests.
- User value: Recognition and competition.
- Company value: Retention through light gamification.
- KPIs: Views, period toggle usage, retention lift among participants.
 

### 1.17 Games Hub (Online, Offline, AR; Spin Removed)
- What: A centralized hub for Online and Offline games (e.g., Scratch, Memory, Puzzle), location-aware AR games, and city-wise competitions. Includes a catalog of popular game subscriptions purchasable with IceCoins, plus event-based mini-games (market by market). 
- Why: Scalable engagement engine that deepens brand connection, supports local activations, and ties play directly to loyalty (earn/burn) and campaigns.
- User value: Fun experiences (online/offline/AR), local challenges, and the ability to unlock or subscribe to games using IceCoins.
- Company value: Higher time-on-app, loyalty adoption (IceCoins burn), regional community engagement, partnership revenue via subscriptions, and measurable uplift to core funnels.
- KPIs: Games DAU/WAU/MAU, sessions per user, average session length, IceCoins redemption/burn in games, subscription conversion rate, AR participation rate, city event participation, retention lift vs. non-gamers, post-game order conversion.
 

### 1.18 AI Flavor Recommendation Engine
- What: Personalized flavor suggestions using preferences, history, seasonality, and weather.
- Why: Improves discovery and basket expansion.
- User value: Feels understood; less decision fatigue.
- Company value: Higher AOV and conversion from recommendations.
- KPIs: Rec CTR, add-to-order from recs, lift vs. control.
 

### 1.19 Digital Ice Cream Passport
- What: Tracks flavors tried, awards badges (“Chocolate Lover”, “Explorer”), and visualizes progress.
- Why: Makes exploration rewarding.
- User value: Fun collection journey.
- Company value: Increased SKU trial; insight into taste segments.
- KPIs: Badges earned, flavors tried per user, repeat rate.
 

### 1.20 Eco Meter & Sustainability Impact Tracker
- What: Shows per-purchase sustainability contributions (e.g., plastic saved, trees planted) with badges, plus longitudinal tracking of personal eco impact with levels (Eco Beginner → Eco Hero).
- Why: Aligns with values-driven purchasing and sustains engagement over time.
- User value: Recognition for positive impact, motivation through progress and levels.
- Company value: Differentiation and CSR storytelling; ongoing re-engagement and brand affinity.
- KPIs: Badge unlock rate, eco views/session, return visits to tracker, level progression, correlation to retention, cohort retention.
 


### 1.21 Make-Your-Own-Box
- What: Build a personalized gift box by selecting individual scoops/flavors per slot (e.g., 4–6 scoops), choose packaging, add a gift message, recipient details, and schedule delivery or pickup. Also supports “for me” self-purchase.
- Why: Personalization and gifting increase perceived value and drive premium orders, especially during seasonal peaks.
- User value: Tailored selection with an easy end-to-end gifting flow (message, address, schedule).
- Company value: Higher margins on curated bundles; rich preference data for merchandising and campaigns.
- KPIs: Gift box creations, completion rate, ARPB (average revenue per box), on-time delivery rate, gift redemption success.
 

### 1.22 Birthday Gift Feature
- What: Detects birthdays and issues a time-bound coupon or greeting.
- Why: Human touch that drives a high-conversion moment.
- User value: Delight.
- Company value: Strong, trackable re-engagement.
- KPIs: Coupon open/redeem rate, birthday cohort retention.
 

### 1.23 Health & Nutrition
- What: A dedicated hub for health-conscious shopping: Health Profile (weight, height, auto-calculated BMI), dietary preferences and allergies, daily calorie goal with progress; a BMI Calculator; personalized Recommendations with a “Perfect Match” badge based on profile; side-by-side Nutrition Compare for two flavors; and clear Allergen Information badges per flavor.
- Why: Helps users quickly identify products that fit their goals and restrictions while building trust through transparency.
- User value: Safer choices for allergens/diets, awareness of calories and BMI, confidence via “Perfect Match,” and easier decision-making with compare.
- Company value: Expands the addressable audience (dietary, medical, lifestyle segments), improves recommendation relevance, reduces post-purchase dissatisfaction/refunds, and deepens brand trust.
- KPIs: Health profile completion rate, BMI calculator usage, users with a set calorie goal, CTR on “Recommended for you,” conversion lift for “Perfect Match” items vs. baseline, allergen filter usage, nutrition-compare usage, opt-out rate for health data.
  
	Notes: Not medical advice; provide a plain-language disclaimer. Respect privacy by storing only what’s necessary and allowing users to edit/clear profile data. Integrates with Recommendations, Search/Filters, and product detail pages to surface suitability chips (e.g., Vegan, Lactose-free). Accessibility: ensure inputs, contrast, and screen reader labels.
 

### 1.24 Referral / Pyramid Rewards
- What: Invite flow rewarding both referrer and referee; optional tiered bonuses.
- Why: Harnesses word-of-mouth at scale.
- User value: Earn rewards by inviting friends.
- Company value: Low-CAC acquisition channel.
- KPIs: Invites sent, acceptance rate, k-factor, cost per acquired user.
 

### 1.25 Community Feed
- What: A brand-safe social feed with a composer ("Share your Savoy experience…"), rich post cards, and interactions. Post types include Flavor Reviews (tag pill), Challenge Completed badges, photo posts, and stories with hashtags. Users can like, comment, and share; counts are visible. Posts can deep-link to flavor pages, reviews, or challenge details.
- Why: Turns authentic user moments into ongoing social proof and distribution, amplifying core funnels (reviews, trials, challenges).
- User value: Easy way to share experiences, celebrate challenge completions, discover trending flavors, and interact with the community.
- Company value: Continuous UGC pipeline, increased reach via shares, and behavioral signals to inform merchandising and campaigns.
- KPIs: DAU/WAU on feed, posts/day, engagement rate (likes+comments+shares), share-out rate, CTR from feed to flavor/review/challenge, moderation pass rate.
  
	Notes: Brand-safe moderation and reporting/flagging, spam/abuse controls, optional tag filters (e.g., Reviews, Challenges), and privacy controls. Auto-generated posts for milestone events (e.g., completed a challenge) are supported.


### 1.26 Challenges & Missions (IceCoins)
- What: A goal-based challenge system with progress tracking and IceCoins rewards. Examples: “Flavor Explorer — Try 5 new flavors this month”, “Social Star — Share 3 ice cream photos”, “Eco Warrior — Use your own cup 5 times”. Supports time-bounded windows (weekly/monthly), per-challenge progress bars, and instant reward issuance upon completion.
- Why: Nudge high-value behaviors across trial, content creation, and sustainability, while tying them to loyalty to reinforce repeat engagement.
- User value: Clear goals, visible progress, and meaningful rewards for doing what they enjoy.
- Company value: Increased SKU trial, steady UGC supply, and adoption of eco behaviors; measurable retention and ARPU lift via loyalty.
- KPIs: Challenge opt-in rate, completion rate, average IceCoins issued/user, lift to conversion post-completion, UGC submissions approved, eco action completions, abuse detection rate.
  
	Notes: Brand-safe moderation for social tasks; anti-abuse checks (cooldowns, device/account heuristics); optional city- or store-specific challenges; optional streaks/tiers; optional integration with Games Hub for event challenges.


### 1.27 In‑App Feedback & CSAT
- What: A “Share Your Feedback” CTA card that opens a lightweight feedback modal. Users can select a category (Bug, Suggestion, Compliment, Other), rate satisfaction (optional NPS/CSAT), add free‑text comments, and optionally attach a screenshot. Submissions confirm via toast and route to Customer Care (triage tags) with an option to be anonymous.
- Why: Captures the voice of the customer within context, closing the loop faster and informing product and operations.
- User value: Frictionless way to be heard and help improve the experience.
- Company value: Continuous QoE signal, prioritized backlog via categorization, early detection of issues, measurable satisfaction trends.
- KPIs: Feedback submission rate (per 1,000 sessions), completion rate, CSAT/NPS trend, time to first response, % categorized, top themes, fix time for bug-classified items.
  
	Notes: Respect privacy and consent (no PII required for anonymous mode). Basic rate limiting and spam checks. Optional screenshot capture stub in prototype; in production, integrate with ticketing (e.g., Zendesk/Jira) and link to Customer Care within Settings.


### 1.28 Accounts & Authentication (Login, Sign Up, Password Reset)
- What: Email/password Login and Sign Up screens. Sign Up collects full name, email, phone, date of birth, gender, address, city; password with minimum length and confirmation; mandatory checkbox to accept Terms & Conditions and Privacy Policy; links to toggle between Log in/Sign up. Prototype stubs a password reset flow and stores session/profile client‑side.
- Why: Enables personalization, saved preferences, loyalty, and order history while ensuring compliance and consent capture.
- User value: Secure access, faster repeat actions with saved profile info, and control over their data.
- Company value: Identified users for targeted experiences and offers, improved fraud prevention, and compliant data collection.
- KPIs: Sign‑up completion rate, login success rate, error rate by field, drop‑off step analytics, verified email/phone rate (if enabled), password reset success, returning user share.
  
	Notes: Production hardening includes secure password hashing, rate limiting, bot protection, email/OTP verification, and social login options. Accessibility for all form controls; clear privacy disclosures; regional compliance for consent and data retention. Optional SSO for enterprise/retail partner portals.


### 1.29 Promotions & Ads Center
- What: Centralized, brand-safe promotional surfaces for campaigns such as “Double IceCoins Week.” Supports hero banners, feed cards, and section headers with gradients/imagery, short copy, and a primary CTA. Campaigns can deep-link to wallet, offers, products, or challenges and respect frequency caps and scheduling windows.
- Why: A scalable way to broadcast offers and seasonal initiatives without app updates, driving attention to priority actions.
- User value: Clear visibility of active promotions and easy one-tap access to redeem or participate.
- Company value: Higher reach and measurable uplift for campaigns; flexible targeting and timing; no-code operations for marketers.
- KPIs: Banner viewable impressions, CTR, assist to conversion (orders, redemptions, wallet burns), incremental revenue vs. baseline, frequency cap hit rate, creative A/B test winner rate.
  
	Notes: Targeting by user attributes (e.g., city, new vs. returning, wallet balance), placement rules, start/end scheduling, and optional A/B testing. Creative spec guidance (ratio, max text). Ensure accessibility (contrast/alt text), and avoid intrusive interstitials in prototype. All creatives must adhere to brand guidelines and legal disclosures.



 
























