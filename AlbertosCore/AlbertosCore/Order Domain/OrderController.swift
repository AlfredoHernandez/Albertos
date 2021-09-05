//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Combine

public class OrderController: OrderHandler, ObservableObject {
    public var items: [MenuItem] { order.items }
    public var total: Double { order.total }

    @Published public private(set) var order: Order

    public init(order: Order = Order(items: [])) {
        self.order = order
    }

    public func isItemInOrder(_ item: MenuItem) -> Bool {
        order.items.contains { $0 == item }
    }

    public func addMenuItem(_ item: MenuItem) {
        order = Order(items: order.items + [item])
    }

    public func removeMenuItem(_ item: MenuItem) {
        let items = order.items
        guard let indexToRemove = items.firstIndex(where: { $0.name == item.name }) else { return }

        let newItems = items.enumerated().compactMap { (index, element) -> MenuItem? in
            guard index == indexToRemove else { return element }
            return .none
        }

        order = Order(items: newItems)
    }

    public func resetOrder() {
        order = Order(items: [])
    }
}
