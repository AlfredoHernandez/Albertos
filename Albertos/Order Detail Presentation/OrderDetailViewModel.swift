//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Combine
import Foundation
import HippoPayments

struct OrderDetailViewModel {
    let headerText = "Your Order"
    let emptyMenuFallbackText = "Add dishes to the order to see them here"
    var totalAmmount: String?
    var cancellables = Set<AnyCancellable>()
    var orderedItems: [MenuItem] = []
    let paymentProcessor: PaymentProcessing
    let orderController: OrderController

    init(orderController: OrderController, paymentProcessor: PaymentProcessing = HippoPaymentsProcessor(apiKey: "A1B2C3")) {
        self.orderController = orderController
        self.paymentProcessor = paymentProcessor
        totalAmmount = orderController.order.items.isEmpty ? nil : "$\(String(format: "%.2f", orderController.order.total))"
        orderedItems = orderController.order.items
    }

    func checkOut() {
        _ = paymentProcessor.process(order: orderController.order)
    }
}
