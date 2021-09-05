//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import AlbertosCore
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
    let orderHandler: OrderHandler
    let shouldShowCheckoutButton: Bool
    @Published var alertToShow: AlertViewModel?
    private let onAlertDismiss: () -> Void

    init(orderHandler: OrderHandler, paymentProcessor: PaymentProcessing, onAlertDismiss: @escaping () -> Void) {
        self.orderHandler = orderHandler
        self.paymentProcessor = paymentProcessor
        self.onAlertDismiss = onAlertDismiss

        if orderHandler.items.isEmpty {
            totalAmmount = .none
            shouldShowCheckoutButton = false
        } else {
            totalAmmount = "Total: $\(String(format: "%.2f", orderHandler.total))"
            shouldShowCheckoutButton = true
        }

        orderedItems = orderHandler.items
    }

    func checkOut() {
        paymentProcessor.process(order: (orderHandler as! OrderController).order)
            .sink(receiveCompletion: { [weak self] completion in
                guard case .failure = completion else { return }
                self?.alertToShow = AlertViewModel(
                    title: "",
                    message: "There's been an error with your order. Please contact a waiter.",
                    buttonText: "Ok",
                    buttonAction: self?.onAlertDismiss
                )
            }, receiveValue: { [weak self] _ in
                guard let self = self else { return }
                self.alertToShow = AlertViewModel(
                    title: "",
                    message: "The payment was successful. Your food will be with you shortly.",
                    buttonText: "Ok",
                    buttonAction: {
                        self.onAlertDismiss()
                        self.orderHandler.resetOrder()
                    }
                )
            })
            .store(in: &cancellables)
    }
}

extension MenuItem: Identifiable {
    public var id: String { name }
}
