//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Foundation

struct MenuItem {
    let category: String
    let name: String
}

extension MenuItem: Identifiable {
    var id: String { name }
}
