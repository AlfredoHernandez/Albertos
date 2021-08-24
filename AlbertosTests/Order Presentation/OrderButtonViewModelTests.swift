//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

@testable import Albertos
import XCTest

class OrderButtonViewModelTests: XCTestCase {
    func test_whenOrderIsEmpty_doesNotShowTotal() {
        let orderController = OrderController()
        let viewModel = OrderButtonViewModel(orderController: orderController)

        XCTAssertEqual(viewModel.text, "Your Order")
    }

    func test_whenOrderIsNotEmpty_showsTotal() {
        let orderController = OrderController()
        let viewModel = OrderButtonViewModel(orderController: orderController)

        orderController.addToOrder(item: .fixture(price: 5.45))
        XCTAssertEqual(viewModel.text, "Your Order $5.45")

        orderController.addToOrder(item: .fixture(price: 1.00))
        XCTAssertEqual(viewModel.text, "Your Order $6.45")

        orderController.addToOrder(item: .fixture(price: 3.55))
        XCTAssertEqual(viewModel.text, "Your Order $10.00")
    }
}
