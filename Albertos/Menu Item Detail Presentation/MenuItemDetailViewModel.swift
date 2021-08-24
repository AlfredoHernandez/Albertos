//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Combine
import Foundation

class MenuItemDetailViewModel {
    let item: MenuItem
    @Published private(set) var addOrRemoveFromOrderButtonText = ""
    let name: String
    let spicy: String?
    let price: String

    private let orderController: OrderController
    private var cancellables = Set<AnyCancellable>()

    // TODO: Remove default value until WIP
    init(item: MenuItem, orderController: OrderController = OrderController()) {
        self.item = item
        self.orderController = orderController
        name = item.name
        spicy = item.spicy ? "Spicy" : .none
        price = "$\(String(format: "%.2f", item.price))"

        self.orderController.$order.sink { [weak self] order in
            guard let self = self else { return }
            if (order.items.contains { $0 == item }) {
                self.addOrRemoveFromOrderButtonText = "Remove from order"
            } else {
                self.addOrRemoveFromOrderButtonText = "Add to order"
            }
        }.store(in: &cancellables)
    }

    func addOrRemoveFromOrder() {
        if orderController.isItemInOrder(item) {
            orderController.removeFromOrder(item: item)
        } else {
            orderController.addToOrder(item: item)
        }
    }
}
