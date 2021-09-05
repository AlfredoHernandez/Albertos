//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Foundation

public class ManageOrderUseCase: OrderHandler {
    public private(set) var items = [MenuItem]()

    public var total: Double {
        items.reduce(0) { partialResult, menuItem in
            partialResult + menuItem.price
        }
    }

    enum Error: Swift.Error {
        case itemNotFound
    }

    public init(items: [MenuItem] = []) {
        self.items = items
    }

    public func addMenuItem(_ item: MenuItem) {
        items.append(item)
    }

    public func removeMenuItem(_ item: MenuItem) throws {
        guard let index = items.firstIndex(where: { $0.name == item.name }) else {
            throw Error.itemNotFound
        }
        items.remove(at: index)
    }

    public func resetOrder() {
        items.removeAll()
    }

    public func isItemInOrder(_ item: MenuItem) -> Bool {
        items.contains(where: { $0.name == item.name })
    }
}
