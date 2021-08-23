//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Foundation

struct MenuSection: Equatable {
    let category: String
    let items: [MenuItem]
}

extension MenuSection: Identifiable {
    var id: String { category }
}
