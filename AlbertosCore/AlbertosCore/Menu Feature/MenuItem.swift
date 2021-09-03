//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Foundation

public struct MenuItem: Equatable {
    public let category: String
    public let name: String
    public let spicy: Bool
    public let price: Double

    public init(category: String, name: String, spicy: Bool, price: Double) {
        self.category = category
        self.name = name
        self.spicy = spicy
        self.price = price
    }
}

extension MenuItem: Identifiable {
    public var id: String { name }
}

extension MenuItem: Decodable {}
