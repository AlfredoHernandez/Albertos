//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

@testable import Albertos
import Foundation

extension MenuItem {
    static func jsonFixture(name: String = "any name", category: String = "any category", spicy: Bool = false, price: Double = 0.0) -> String {
        """
        {
            "name": "\(name)",
            "category": "\(category)",
            "spicy": \(spicy),
            "price": \(price)
        }
        """
    }
}
