//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import AlbertosCore

extension MenuItem {
    static func fixture(category: String = "a category", name: String = "a name", spicy: Bool = false, price: Double = 0.0) -> Self {
        MenuItem(category: category, name: name, spicy: spicy, price: price)
    }
}
