# SavoyConnect Web Application

## Overview
Responsive web application prototype built with "Build Once, Deploy Everywhere" approach.

## Features
✅ **Fully Responsive Design**
- Mobile: < 768px (Bottom navigation)
- Tablet: 768px - 1023px (Top bar + Bottom nav)
- Desktop: 1024px+ (Sidebar navigation)

✅ **Cross-Platform Compatible**
- Works on mobile browsers
- Works on tablet browsers
- Works on desktop browsers
- Can be converted to PWA (Progressive Web App)

✅ **Adaptive Layouts**
- Mobile: Single column, bottom navigation
- Tablet: 2-column grids, responsive cards
- Desktop: Sidebar + multi-column layouts

## File Structure
```
web-app/
├── index.html          # Main HTML structure
├── css/
│   ├── tokens.css      # Design system variables
│   ├── base.css        # Reset, utilities, responsive framework
│   ├── layout.css      # Layout system (sidebar, nav, screens)
│   └── components.css  # Component styles (cards, buttons, etc)
├── js/
│   └── app.js          # Navigation & interaction logic
└── assets/             # Images, icons (reuse from parent)
```

## How to Test

### Option 1: Direct Browser
1. Open `web-app/index.html` in your browser
2. Test responsive behavior:
   - Press `F12` to open DevTools
   - Click device toolbar icon (or `Ctrl+Shift+M`)
   - Test different screen sizes:
     - iPhone: 375px × 812px
     - iPad: 768px × 1024px
     - Desktop: 1440px × 900px

### Option 2: Live Server
1. Install Live Server extension in VS Code
2. Right-click `web-app/index.html`
3. Select "Open with Live Server"
4. Resize browser to test responsive breakpoints

## Key Features Implemented

### Desktop (≥1024px)
- ✅ Fixed sidebar navigation (collapsible)
- ✅ Top bar with search and notifications
- ✅ Multi-column grid layouts
- ✅ Hover effects and transitions

### Tablet (768px - 1023px)
- ✅ Top bar navigation
- ✅ Bottom navigation bar
- ✅ 2-3 column grids
- ✅ Touch-friendly UI

### Mobile (<768px)
- ✅ Hamburger menu
- ✅ Bottom navigation (5 items)
- ✅ Single column layouts
- ✅ Touch-optimized buttons

## Navigation System
- **Desktop**: Sidebar links (left side)
- **Mobile/Tablet**: Bottom nav + Hamburger menu
- **All platforms**: Smooth transitions between screens

## Keyboard Shortcuts
- `Esc`: Close menus/modals
- `Ctrl+K` / `Cmd+K`: Open search (coming soon)

## Next Steps
1. ✅ Test on real devices
2. Add more screens (Explore, Wallet, etc.)
3. Implement data from mobile prototype
4. Add animations and transitions
5. Convert to PWA (offline support)
6. Add backend integration

## Browser Support
- Chrome/Edge: ✅ Full support
- Firefox: ✅ Full support  
- Safari: ✅ Full support
- Mobile browsers: ✅ Optimized

## Notes
- Logo path references `../assets/savoy.png` (parent directory)
- Can reuse all assets from mobile prototype
- CSS uses CSS variables for easy theming
- Mobile-first approach (starts mobile, scales up)
