//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import AlbertosCore
import Combine
import Foundation

class MenuItemDetailViewModel: ObservableObject {
    let item: MenuItem
    let name: String
    let spicy: String?
    let price: String
    let addToOrderText = "Add to order"

    var items: [MenuItem] = []
    @Published private(set) var numberOfItemsInOrder = ""

    private let orderController: OrderController
    private var cancellables = Set<AnyCancellable>()

    init(item: MenuItem, orderController: OrderController) {
        self.item = item
        self.orderController = orderController
        name = item.name
        spicy = item.spicy ? "Spicy" : .none
        price = "$\(String(format: "%.2f", item.price))"

        numberOfItemsInOrder = String(format: "%d items in order", items.count)
        items = orderController.items.filter { $0 == item }
    }

    func addItem() {
        orderController.addMenuItem(item)
        items = orderController.items.filter { $0 == item }
        numberOfItemsInOrder = String(format: "%d items in order", items.count)
    }

    func removeItem() {
        orderController.removeMenuItem(item)
        items = orderController.items.filter { $0 == item }
        numberOfItemsInOrder = String(format: "%d items in order", items.count)
    }
}
