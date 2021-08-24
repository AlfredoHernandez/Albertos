//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Combine
import Foundation
import HippoPayments

class OrderDetailViewModel: ObservableObject {
    let headerText = "Your Order"
    let emptyMenuFallbackText = "Add dishes to the order to see them here"
    let checkoutButtonText = "Check Out"
    var totalAmmount: String?
    var cancellables = Set<AnyCancellable>()
    var orderedItems: [MenuItem] = []
    let paymentProcessor: PaymentProcessing
    let orderController: OrderController
    let shouldShowCheckoutButton: Bool
    @Published var alertToShow: AlertViewModel?

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
        paymentProcessor.process(order: orderController.order)
            .sink(receiveCompletion: { [weak self] completion in
                guard case .failure = completion else { return }
                self?.alertToShow = AlertViewModel(
                    title: "",
                    message: "There's been an error with your order. Please contact a waiter.",
                    buttonText: "Ok"
                )
            }, receiveValue: { [weak self] _ in
                self?.alertToShow = AlertViewModel(
                    title: "",
                    message: "The payment was successful. Your food will be with you shortly.",
                    buttonText: "Ok"
                )
            })
            .store(in: &cancellables)
    }
}
