//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Foundation

@testable import Albertos
import XCTest

class OrderDetailViewModelTests: XCTestCase {
    func test_headerText() {
        let viewModel = OrderDetailViewModel()

        XCTAssertEqual(viewModel.headerText, "Your Order")
    }

    func test_whenOrderIsEmpty_shouldNotShowTotalAmount() {
        let orderController = OrderController()
        let viewModel = OrderDetailViewModel(orderController: orderController)

        XCTAssertNil(viewModel.totalAmmount)
    }

    func test_whenOrderIsWithOneItem_shouldShowTotalAmount() {
        let orderController = OrderController(order: Order(items: [
            .fixture(price: 1.0),
        ]))

        let viewModel = OrderDetailViewModel(orderController: orderController)

        XCTAssertEqual(viewModel.totalAmmount, "$1.00")
    }

    func test_whenOrderIsWithSeveralItems_shouldShowTotalAmount() {
        let orderController = OrderController(order: Order(items: [
            .fixture(price: 1.0),
            .fixture(price: 2.0),
        ]))

        let viewModel = OrderDetailViewModel(orderController: orderController)

        XCTAssertEqual(viewModel.totalAmmount, "$3.00")
    }

    func test_whenOrderIsEmpty_hasNotItemNamesToShow() {
        let orderController = OrderController()
        let viewModel = OrderDetailViewModel(orderController: orderController)

        XCTAssertTrue(viewModel.orderedItems.isEmpty)
    }

    func test_whenOrderIsNonEmpty_menuListItemIsOrderItems() {
        let orderController = OrderController(order: Order(items: [
            .fixture(name: "an item"),
            .fixture(name: "another item"),
        ]))

        let viewModel = OrderDetailViewModel(orderController: orderController)

        XCTAssertEqual(viewModel.orderedItems.count, 2)
        XCTAssertEqual(viewModel.orderedItems.first?.name, "an item")
        XCTAssertEqual(viewModel.orderedItems.last?.name, "another item")
    }
}
