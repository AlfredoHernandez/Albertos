//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import SwiftUI

@main
struct AlbertosApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MenuList(sections: groupMenuByCategory(menu))
                    .navigationTitle("Alberto's 🇮🇹")
            }
        }
    }
}

let menu = [
    MenuItem(category: "starters", name: "Caprese Salad", spicy: false),
    MenuItem(category: "starters", name: "Arancini Balls", spicy: false),
    MenuItem(category: "pastas", name: "Penne all'Arrabbiata", spicy: false),
    MenuItem(category: "pastas", name: "Spaghetti Carbonara", spicy: false),
    MenuItem(category: "drinks", name: "Water", spicy: false),
    MenuItem(category: "drinks", name: "Red Wine", spicy: false),
    MenuItem(category: "desserts", name: "Tiramisù", spicy: false),
    MenuItem(category: "desserts", name: "Crema Catalana", spicy: false),
]
