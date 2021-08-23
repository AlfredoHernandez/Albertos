//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

@testable import Albertos
import Foundation

extension MenuItem {
    static func jsonFixture(name: String = "any name", category: String = "any category", spicy: Bool = false) -> String {
        """
        {
            "name": "\(name)",
            "category": {
                "name": "\(category)",
                "id": 123
            },
        "spicy": \(spicy)
        }
        """
    }
}
