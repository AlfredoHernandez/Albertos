//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Foundation

@testable import Albertos
import Combine
import HippoPayments
import XCTest

class OrderDetailViewModelTests: XCTestCase {
    var timeoutForPredicateExpectations: Double { 2 }

    func test_headerText() {
        let viewModel = OrderDetailViewModel(orderController: OrderController(), paymentProcessor: PaymentProcessingSpy())

        XCTAssertEqual(viewModel.headerText, "Your Order")
    }

    func test_emptyMenuFallbackText() {
        let viewModel = OrderDetailViewModel(orderController: OrderController(), paymentProcessor: PaymentProcessingSpy())

        XCTAssertEqual(viewModel.emptyMenuFallbackText, "Add dishes to the order to see them here")
    }

    func test_whenOrderIsEmpty_shouldNotShowTotalAmount() {
        let orderController = OrderController()
        let viewModel = OrderDetailViewModel(orderController: orderController, paymentProcessor: PaymentProcessingSpy())

        XCTAssertNil(viewModel.totalAmmount)
    }

    func test_whenOrderIsWithOneItem_shouldShowTotalAmount() {
        let orderController = OrderController(order: Order(items: [
            .fixture(price: 1.0),
        ]))

        let viewModel = OrderDetailViewModel(orderController: orderController, paymentProcessor: PaymentProcessingSpy())

        XCTAssertEqual(viewModel.totalAmmount, "Total: $1.00")
    }

    func test_whenOrderIsWithSeveralItems_shouldShowTotalAmount() {
        let orderController = OrderController(order: Order(items: [
            .fixture(price: 1.0),
            .fixture(price: 2.0),
        ]))

        let viewModel = OrderDetailViewModel(orderController: orderController, paymentProcessor: PaymentProcessingSpy())

        XCTAssertEqual(viewModel.totalAmmount, "Total: $3.00")
    }

    func test_whenOrderIsEmpty_hasNotItemNamesToShow() {
        let orderController = OrderController()
        let viewModel = OrderDetailViewModel(orderController: orderController, paymentProcessor: PaymentProcessingSpy())

        XCTAssertTrue(viewModel.orderedItems.isEmpty)
    }

    func test_whenOrderIsNonEmpty_menuListItemIsOrderItems() {
        let orderController = OrderController(order: Order(items: [
            .fixture(name: "an item"),
            .fixture(name: "another item"),
        ]))

        let viewModel = OrderDetailViewModel(orderController: orderController, paymentProcessor: PaymentProcessingSpy())

        XCTAssertEqual(viewModel.orderedItems.count, 2)
        XCTAssertEqual(viewModel.orderedItems.first?.name, "an item")
        XCTAssertEqual(viewModel.orderedItems.last?.name, "another item")
    }

    func test_whenCheckoutButtonTapped_startsPaymentProcessingFlow() {
        let orderController = OrderController()
        orderController.addToOrder(item: .fixture(name: "name"))
        orderController.addToOrder(item: .fixture(name: "other name"))

        let paymentProcessingSpy = PaymentProcessingSpy()

        let viewModel = OrderDetailViewModel(orderController: orderController, paymentProcessor: paymentProcessingSpy)

        viewModel.checkOut()

        XCTAssertEqual(paymentProcessingSpy.receivedOrder, orderController.order)
    }

    func testWhenOrderIsEmptyDoesNotShowCheckoutButton() {
        let viewModel = OrderDetailViewModel(
            orderController: OrderController(),
            paymentProcessor: PaymentProcessingSpy()
        )

        XCTAssertFalse(viewModel.shouldShowCheckoutButton)
    }

    func testWhenOrderIsNonEmptyShowsCheckoutButton() {
        let orderController = OrderController()
        orderController.addToOrder(item: .fixture(name: "a name"))
        let viewModel = OrderDetailViewModel(
            orderController: orderController,
            paymentProcessor: PaymentProcessingSpy()
        )

        XCTAssertTrue(viewModel.shouldShowCheckoutButton)
    }

    func test_whenPaymentSucceeds_updatesPropertyToShowConfirmationAlert() {
        let viewModel = OrderDetailViewModel(
            orderController: OrderController(),
            paymentProcessor: PaymentProcessingStub(returning: .success(()))
        )
        let predicate = NSPredicate { _, _ in viewModel.alertToShow != nil }
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: .none)
        viewModel.checkOut()
        wait(for: [expectation], timeout: timeoutForPredicateExpectations)
        XCTAssertEqual(viewModel.alertToShow?.title, "")
        XCTAssertEqual(
            viewModel.alertToShow?.message,
            "The payment was successful. Your food will be with you shortly."
        )
        XCTAssertEqual(viewModel.alertToShow?.buttonText, "Ok")
    }

    func test_whenPaymentFails_updatesPropertyToShowErrorAlert() {
        let viewModel = OrderDetailViewModel(
            orderController: OrderController(),
            paymentProcessor: PaymentProcessingStub(
                returning: .failure(TestError(id: 123))
            )
        )
        let predicate = NSPredicate { _, _ in viewModel.alertToShow != nil }
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: .none)

        viewModel.checkOut()
        wait(for: [expectation], timeout: timeoutForPredicateExpectations)

        XCTAssertEqual(viewModel.alertToShow?.title, "")
        XCTAssertEqual(
            viewModel.alertToShow?.message,
            "There's been an error with your order. Please contact a waiter."
        )
        XCTAssertEqual(viewModel.alertToShow?.buttonText, "Ok")
    }

    // MARK: - Helpers

    class PaymentProcessingSpy: PaymentProcessing {
        private(set) var receivedOrder: Order?

        func process(order: Order) -> AnyPublisher<Void, Error> {
            receivedOrder = order
            return Result<Void, Error>.success(()).publisher.eraseToAnyPublisher()
        }
    }

    class PaymentProcessingStub: PaymentProcessing {
        let result: Result<Void, Error>
        init(returning result: Result<Void, Error>) {
            self.result = result
        }

        func process(order _: Order) -> AnyPublisher<Void, Error> {
            result
                .publisher
                .delay(for: 0.1, scheduler: RunLoop.main)
                .eraseToAnyPublisher()
        }
    }
}
