//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Combine
import Foundation

struct OrderDetailViewModel {
    let headerText = "Your Order"
    let emptyMenuFallbackText = "Add dishes to the order to see them here"
    var totalAmmount: String?
    var cancellables = Set<AnyCancellable>()
    var orderedItems: [MenuItem] = []

    init(orderController: OrderController) {
        totalAmmount = orderController.order.items.isEmpty ? nil : "$\(String(format: "%.2f", orderController.order.total))"
        orderedItems = orderController.order.items
    }
}
