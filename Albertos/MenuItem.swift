//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Foundation

struct MenuItem {
    let category: String
    let name: String
    let spicy: Bool
}

extension MenuItem: Identifiable {
    var id: String { name }
}
