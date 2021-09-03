//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Foundation

public class ManageOrderUseCase {
    private let store: OrderStore

    init(store: OrderStore) {
        self.store = store
    }

    func addMenuItem(_ item: MenuItem) {
        store.add(item: item)
    }
}
