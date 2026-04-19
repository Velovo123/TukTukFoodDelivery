# 🚗 Тук-Тук

> Local food delivery & taxi app for Zolochiv, Ukraine

<div align="center">

[![Swift](https://img.shields.io/badge/Swift-5.9-orange?logo=swift&logoColor=white)](https://swift.org)
[![iOS](https://img.shields.io/badge/iOS-26.2+-black?logo=apple&logoColor=white)](https://apple.com/ios)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-5.0-green)](https://developer.apple.com/swiftui)
[![Xcode](https://img.shields.io/badge/Xcode-16+-blue?logo=xcode&logoColor=white)](https://developer.apple.com/xcode)

</div>

---

## 📱 Demo

<!-- Drag your screen recording into a GitHub Issue to get a URL, then paste it here -->
<!-- https://github.com/user/repo/assets/your-video.mp4 -->

---

## ✨ Features

### 🍔 Food
- Browse local restaurants by category
- Featured card for newly added places
- Restaurant detail with menu
- Add to cart from multiple restaurants
- Multi-restaurant cart grouped by restaurant
- Skeleton loading animation
- Pull to refresh

### 🚕 Taxi
- Interactive Apple Maps integration
- Address input with local suggestions
- Date & time scheduling
- Payment method selection
- Form validation before booking

### 📋 Orders
- Active / History segmented view
- Order status badges (Pending, Active, Completed, Cancelled)
- Payment method display per order

### 👤 Profile
- Phone number authentication
- Bonus points balance card
- Saved delivery addresses
- Push notification preferences
- Personal data management
- Sign out & delete account

---

## 🏗 Architecture

```
MVVM — Model · View · ViewModel
```

```
TukTukApp/
├── App/                        # Entry point, tab bar
├── Core/
│   ├── Network/                # API client, error types
│   ├── Storage/                # UserDefaults, Keychain stubs
│   ├── Extensions/             # View, Color helpers
│   └── DI/                     # AppContainer, Environment keys
├── Features/
│   ├── Food/
│   │   ├── Views/              # FoodView, RestaurantDetailView
│   │   ├── ViewModels/         # FoodViewModel, RestaurantDetailViewModel
│   │   └── Components/         # RestaurantCard, CategoryChip, MenuItemRow, CartButton
│   ├── Taxi/
│   │   ├── Views/              # TaxiView
│   │   ├── ViewModels/         # TaxiViewModel
│   │   └── Components/         # AddressField
│   ├── Orders/
│   │   ├── Views/              # OrdersView
│   │   ├── ViewModels/         # OrdersViewModel
│   │   └── Components/         # OrderRow, StatusBadge
│   ├── Profile/
│   │   ├── Views/              # ProfileView, PersonalDataView, AddressesView, LoginView
│   │   ├── ViewModels/         # ProfileViewModel
│   │   └── Components/         # ProfileMenuRow, BonusCard
│   └── Splash/                 # SplashView
├── Models/                     # Restaurant, TaxiOrder, User, MenuItem, CartItem
├── DesignSystem/               # Colors, Typography, Spacing, Shimmer, Strings (L10n)
└── Resources/
    ├── en.lproj/               # English strings
    └── uk.lproj/               # Ukrainian strings
```

---

## 🛠 Tech Stack

| Layer | Technology |
|---|---|
| UI Framework | SwiftUI |
| State Management | `@Observable` (iOS 17+) |
| Navigation | `NavigationStack` |
| Maps | MapKit |
| Local Storage | UserDefaults, Keychain (stubs) |
| Persistence | SwiftData (planned) |
| Networking | URLSession / `async-await` (stubs) |
| Minimum iOS | 26.2 |

---

## 📦 Data Source

> ⚠️ Currently the app runs entirely on **preview / mock data**. No backend is connected yet.

All data is defined in `Models/PreviewData.swift`:

```swift
Restaurant.previews     // 6 local restaurants
MenuItem.previews       // 6 menu items per restaurant
TaxiOrder.previews      // 3 sample orders
User.preview            // 1 mock user (Oleksiy, 60₴ bonus)
SavedAddress.previews   // Home + Work addresses
AddressSuggestions.mock // 15 Zolochiv street addresses
```

Cart state lives **in-memory only** via `CartManager` — it resets on app restart.

Auth is **simulated** — entering any phone number with 10+ digits signs you in as the preview user.

---

## 🎨 Design System

### Color Palette

| Token | Light | Dark | Usage |
|---|---|---|---|
| `AppGreen` | `#5CA85A` | `#7CC87A` | Primary, buttons, active states |
| `AppGreenDark` | `#4A9048` | `#6AB868` | Pressed states, gradients |
| `AppGreenTint` | `#EBF7EA` | `#1E3B1C` | Backgrounds, chips, badges |
| `BgSurface` | `#F4FAF4` | `#141614` | Page background |
| `BgPrimary` | `#FFFFFF` | `#1C1C1E` | Cards, sheets |
| `TextPrimary` | `#1A2E1A` | `#ECFAEB` | Headlines |
| `TextSecondary` | `#527252` | `#8FB88E` | Subtitles |
| `Destructive` | `#D94F4F` | `#FF6B6B` | Logout, delete |

### Typography
SF Pro system font — follows Apple HIG type scale.

### Spacing
4pt base grid — `Spacing.xs (4)` → `Spacing.xxxl (64)`

### Localization
- 🇬🇧 English
- 🇺🇦 Ukrainian

All strings accessed via type-safe `L10n` enum — no hardcoded text in views.

---

## 🗺 Roadmap / TODO

### 🔴 Critical (before beta)
- [ ] Connect real backend API
- [ ] Real SMS OTP authentication
- [ ] SwiftData persistence for cart & orders
- [ ] Push notifications (APNs)
- [ ] Real-time taxi tracking with MapKit

### 🟡 Features
- [ ] Search restaurants & menu items
- [ ] Restaurant ratings & reviews
- [ ] Order tracking screen with live status
- [ ] Promo codes & bonus redemption
- [ ] Multiple payment methods (Apple Pay)
- [ ] Scheduled taxi rides
- [ ] Favorite restaurants
- [ ] Order history with reorder button

### 🟢 Polish
- [ ] Dark mode full pass
- [ ] Haptic feedback on cart actions
- [ ] Accessibility (VoiceOver labels)
- [ ] iPad layout
- [ ] Widget — active order status
- [ ] App Clip for quick taxi booking

### 🔵 Infrastructure
- [ ] Unit tests for ViewModels
- [ ] UI tests for critical flows
- [ ] CI/CD with Xcode Cloud
- [ ] Crash reporting (Sentry / Firebase)
- [ ] Analytics (order funnel)
- [ ] App Store Connect setup

---

## 🚀 Getting Started

```bash
# Clone the repo
git clone https://github.com/yourusername/tuktuk-ios.git

# Open in Xcode
cd tuktuk-ios
open TukTuk.xcodeproj
```

Requirements:
- Xcode 16+
- iOS 17+ simulator or device
- No dependencies — pure SwiftUI, no SPM packages

---

## 📍 About

Built for **Zolochiv, Lviv Oblast, Ukraine** 🇺🇦

A local alternative to Bolt/Glovo — connecting residents with nearby restaurants and taxi drivers without big-platform fees.

---

*Made with SwiftUI · Zolochiv, Ukraine 🇺🇦*
