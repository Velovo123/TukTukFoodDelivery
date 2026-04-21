//
//  Strings.swift
//  TukTuk
//
//  Created by Anatolii Semenchuk on 18.04.2026.
//

import Foundation

enum L10n {
    
    enum Tab {
        static let food    = String(localized: "tab.food")
        static let taxi    = String(localized: "tab.taxi")
        static let orders  = String(localized: "tab.orders")
        static let profile = String(localized: "tab.profile")
    }
    
    enum Food {
        static let title    = String(localized: "food.title")
        static let greeting = String(localized: "food.greeting")
        static let question = String(localized: "food.question")
        static let venues   = String(localized: "food.venues")
        static let new      = String(localized: "food.new")
        static let all      = String(localized: "food.category.all")
        static let shawarma = String(localized: "food.category.shawarma")
        static let pizza    = String(localized: "food.category.pizza")
        static let sushi    = String(localized: "food.category.sushi")
        static let burgers  = String(localized: "food.category.burgers")
        static let cafe     = String(localized: "food.category.cafe")
    }
    
    enum Taxi {
        static let title              = String(localized: "taxi.title")
        static let subtitle           = String(localized: "taxi.subtitle")
        static let from               = String(localized: "taxi.from")
        static let to                 = String(localized: "taxi.to")
        static let today              = String(localized: "taxi.today")
        static let now                = String(localized: "taxi.now")
        static let comment            = String(localized: "taxi.comment")
        static let commentPlaceholder = String(localized: "taxi.comment.placeholder")
        static let cta                = String(localized: "taxi.cta")
        static let paymentCard        = String(localized: "taxi.payment.card")
        static let paymentCash        = String(localized: "taxi.payment.cash")
        static let paymentChange      = String(localized: "taxi.payment.change")
        static let location           = String(localized: "taxi.location")
    }
    
    enum Orders {
        static let title    = String(localized: "orders.title")
        static let empty    = String(localized: "orders.empty")
        static let emptySub = String(localized: "orders.empty.sub")
    }
    
    enum Profile {
        static let title         = String(localized: "profile.title")
        static let cabinet       = String(localized: "profile.cabinet")
        static let bonus         = String(localized: "profile.bonus")
        static let bonusAvailable = String(localized: "profile.bonus.available")
        static let orders        = String(localized: "profile.orders")
        static let ordersSub     = String(localized: "profile.orders.sub")
        static let personal      = String(localized: "profile.personal")
        static let personalSub   = String(localized: "profile.personal.sub")
        static let addresses     = String(localized: "profile.addresses")
        static let addressesSub  = String(localized: "profile.addresses.sub")
        static let notifications = String(localized: "profile.notifications")
        static let notifOn       = String(localized: "profile.notif.on")
        static let notifOff      = String(localized: "profile.notif.off")
        static let logout        = String(localized: "profile.logout")
        static let delete        = String(localized: "profile.delete")
    }
    
    enum Error {
        static let noInternet = String(localized: "error.no_internet")
        static let unknown    = String(localized: "error.unknown")
        static let tryAgain   = String(localized: "error.try_again")
    }
    
    enum Alert {
        static let signOutTitle   = String(localized: "alert.signout.title")
        static let signOutMessage = String(localized: "alert.signout.message")
        static let deleteTitle    = String(localized: "alert.delete.title")
        static let deleteMessage  = String(localized: "alert.delete.message")
        static let cancel         = String(localized: "alert.cancel")
        static let confirm        = String(localized: "alert.confirm")
    }
    
    enum Auth {
        static let signInTitle      = String(localized: "auth.signin.title")
        static let phoneLabel       = String(localized: "auth.phone.label")
        static let phonePlaceholder = String(localized: "auth.phone.placeholder")
        static let continueButton   = String(localized: "auth.continue")
    }
    
    enum Splash {
        static let tagline = String(localized: "splash.tagline")
    }
}
