//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Foundation

struct MenuItemDetailViewModel {
    let name: String
    let spicy: String?
    let price: String

    init(item: MenuItem) {
        name = item.name
        spicy = item.spicy ? "Spicy" : .none
        price = "$\(String(format: "%.2f", item.price))"
    }
}
