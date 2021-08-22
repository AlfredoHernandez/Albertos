//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Foundation

func groupMenuByCategory(_ menu: [MenuItem]) -> [MenuSection] {
    Dictionary(grouping: menu, by: { $0.category })
        .map { key, value in
            MenuSection(category: key, items: value)
        }.sorted(by: { $0.category > $1.category })
}
