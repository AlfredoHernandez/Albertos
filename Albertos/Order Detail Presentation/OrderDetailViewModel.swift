//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Combine
import Foundation

struct OrderDetailViewModel {
    let headerText = "Your Order"
    var totalAmmount: String?
    var cancellables = Set<AnyCancellable>()
    var orderedItems: [MenuItem] = []

    // TODO: Remove default value until WIP
    init(orderController: OrderController = OrderController()) {
        totalAmmount = orderController.order.items.isEmpty ? nil : "$\(String(format: "%.2f", orderController.order.total))"

        orderedItems = orderController.order.items
    }
}
