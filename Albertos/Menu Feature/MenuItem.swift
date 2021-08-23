//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Foundation

struct MenuItem: Equatable {
    let name: String
    let spicy: Bool
    private let categoryObject: Category
    var category: String { categoryObject.name }

    enum CodingKeys: String, CodingKey {
        case name, spicy
        case categoryObject = "category"
    }

    struct Category: Equatable, Decodable {
        let name: String
    }
}

extension MenuItem: Identifiable {
    var id: String { name }
}

extension MenuItem: Decodable {}

extension MenuItem {
    init(category: String, name: String, spicy: Bool) {
        categoryObject = Category(name: category)
        self.name = name
        self.spicy = spicy
    }
}
