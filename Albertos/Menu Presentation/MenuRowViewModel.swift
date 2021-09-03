//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import AlbertosCore
import Foundation

class MenuRowViewModel {
    let text: String

    init(item: MenuItem) {
        text = item.spicy ? "\(item.name) 🔥" : item.name
    }
}
