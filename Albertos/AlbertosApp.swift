//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Combine
import SwiftUI

@main
struct AlbertosApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MenuList(viewModel: .init(menuFetcher: MenuFetcherPlaceholder()))
                    .navigationTitle("Alberto's 🇮🇹")
            }
        }
    }
}

let menu: [MenuItem] = [
    MenuItem(category: "starters", name: "Caprese Salad", spicy: false, price: 0.0),
    MenuItem(category: "starters", name: "Arancini Balls", spicy: false, price: 0.0),
    MenuItem(category: "pastas", name: "Penne all'Arrabbiata", spicy: true, price: 0.0),
    MenuItem(category: "pastas", name: "Spaghetti Carbonara", spicy: false, price: 0.0),
    MenuItem(category: "drinks", name: "Water", spicy: false, price: 0.0),
    MenuItem(category: "drinks", name: "Red Wine", spicy: false, price: 0.0),
    MenuItem(category: "desserts", name: "Tiramisù", spicy: false, price: 0.0),
    MenuItem(category: "desserts", name: "Crema Catalana", spicy: false, price: 0.0),
]

class MenuFetcherPlaceholder: MenuFetching {
    func fetchMenu() -> AnyPublisher<[MenuItem], Error> {
        Future { completion in
            completion(.success(menu))
        }
        // .delay(for: 0.5, scheduler: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
