//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Combine
import Foundation
import HippoPayments

struct OrderDetailViewModel {
    let headerText = "Your Order"
    let emptyMenuFallbackText = "Add dishes to the order to see them here"
    let checkoutButtonText = "Check Out"
    var totalAmmount: String?
    var cancellables = Set<AnyCancellable>()
    var orderedItems: [MenuItem] = []
    let paymentProcessor: PaymentProcessing
    let orderController: OrderController
    let shouldShowCheckoutButton: Bool

    init(orderController: OrderController, paymentProcessor: PaymentProcessing) {
        self.orderController = orderController
        self.paymentProcessor = paymentProcessor

        if orderController.order.items.isEmpty {
            totalAmmount = .none
            shouldShowCheckoutButton = false
        } else {
            totalAmmount = "Total: $\(String(format: "%.2f", orderController.order.total))"
            shouldShowCheckoutButton = true
        }

        orderedItems = orderController.order.items
    }

    func checkOut() {
        _ = paymentProcessor.process(order: orderController.order)
    }
}
