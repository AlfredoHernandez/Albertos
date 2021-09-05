//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Foundation

public struct Order: Equatable {
    public let items: [MenuItem]

    public var total: Double { items.reduce(0) { $0 + $1.price } }

    public init(items: [MenuItem]) {
        self.items = items
    }
}
