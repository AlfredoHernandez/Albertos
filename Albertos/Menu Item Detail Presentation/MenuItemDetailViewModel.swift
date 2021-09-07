//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import AlbertosCore
import Combine
import Foundation

class MenuItemDetailViewModel: ObservableObject {
    private let item: MenuItem
    let name: String
    let spicy: String?
    let price: String
    let addToOrderText = "Add to order"

    @Published private(set) var numberOfItemsInOrder = ""
    @Published private var items: [MenuItem] = []

    private let orderController: OrderController
    private var cancellables = Set<AnyCancellable>()

    init(item: MenuItem, orderController: OrderController) {
        self.item = item
        self.orderController = orderController
        name = item.name
        spicy = item.spicy ? "Spicy" : .none
        price = "$\(String(format: "%.2f", item.price))"

        syncItems(from: orderController)

        $items.sink { [weak self] in
            self?.numberOfItemsInOrder = String(format: "%d items in order", $0.count)
        }.store(in: &cancellables)
    }

    func addItem() {
        orderController.addMenuItem(item)
        syncItems(from: orderController)
    }

    func removeItem() {
        orderController.removeMenuItem(item)
        syncItems(from: orderController)
    }

    private func syncItems(from orderController: OrderController) {
        items = orderController.items.filter { $0 == item }
    }
}
