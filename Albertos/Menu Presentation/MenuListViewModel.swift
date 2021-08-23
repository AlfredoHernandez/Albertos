//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Foundation

class MenuListViewModel {
    let sections: [MenuSection]

    init(menu: [MenuItem], menuGrouping: ([MenuItem]) -> [MenuSection] = groupMenuByCategory) {
        sections = menuGrouping(menu)
    }
}
