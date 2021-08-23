//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

@testable import Albertos

extension MenuItem {
    static func fixture(category: String = "a category", name: String = "a name", spicy: Bool = false) -> Self {
        MenuItem(category: category, name: name, spicy: spicy)
    }
}
