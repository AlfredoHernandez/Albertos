//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Foundation

public struct MenuSection: Equatable {
    public let category: String
    public let items: [MenuItem]

    public init(category: String, items: [MenuItem]) {
        self.category = category
        self.items = items
    }
}

extension MenuSection: Identifiable {
    public var id: String { category }
}
