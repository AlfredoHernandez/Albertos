//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Foundation

struct Order {
    let items: [MenuItem]

    var total: Double { items.reduce(0) { $0 + $1.price } }
}
