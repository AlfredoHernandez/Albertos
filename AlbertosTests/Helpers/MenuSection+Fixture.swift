//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

@testable import Albertos

extension MenuSection {
    static func fixture(category: String = "any category", items: [MenuItem] = [.fixture()]) -> Self {
        MenuSection(category: category, items: items)
    }
}
