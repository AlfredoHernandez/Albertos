//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

@testable import Albertos
import XCTest

class MenuItemDetailViewModelTests: XCTestCase {
    func test_nameIsItemName() {
        XCTAssertEqual(
            MenuItemDetailViewModel(item: .fixture(name: "a name"), orderController: OrderController()).name,
            "a name"
        )
    }

    func test_whenItemIsSpicy_showsSpicyMessage() {
        XCTAssertEqual(
            MenuItemDetailViewModel(item: .fixture(spicy: true), orderController: OrderController()).spicy,
            "Spicy"
        )
    }

    func test_whenItemIsNotSpicy_doesNotShowSpicyMessage() {
        XCTAssertNil(MenuItemDetailViewModel(item: .fixture(spicy: false), orderController: OrderController()).spicy)
    }

    func test_price_isFormattedItemPrice() {
        XCTAssertEqual(
            MenuItemDetailViewModel(item: .fixture(price: 1.0), orderController: OrderController()).price,
            "$1.00"
        )
        XCTAssertEqual(
            MenuItemDetailViewModel(item: .fixture(price: 2.5), orderController: OrderController()).price,
            "$2.50"
        )
        XCTAssertEqual(
            MenuItemDetailViewModel(item: .fixture(price: 3.45), orderController: OrderController()).price,
            "$3.45"
        )
        XCTAssertEqual(
            MenuItemDetailViewModel(item: .fixture(price: 4.123), orderController: OrderController()).price,
            "$4.12"
        )
    }

    func test_whenItemIsInOrder_buttonSaysRemove() {
        let menuItem = MenuItem.fixture()
        let orderController = OrderController()
        orderController.addToOrder(item: menuItem)

        let viewModel = MenuItemDetailViewModel(item: menuItem, orderController: orderController)

        let text = viewModel.addOrRemoveFromOrderButtonText
        XCTAssertEqual(text, "Remove from order")
    }

    func test_whenItemIsNotInOrder_buttonSaysAdd() {
        let menuItem = MenuItem.fixture()
        let orderController = OrderController()

        let viewModel = MenuItemDetailViewModel(item: menuItem, orderController: orderController)

        let text = viewModel.addOrRemoveFromOrderButtonText
        XCTAssertEqual(text, "Add to order")
    }

    func test_whenItemIsInOrder_buttonActionRemovesIt() {
        let item = MenuItem.fixture()
        let orderController = OrderController()
        orderController.addToOrder(item: item)

        let viewModel = MenuItemDetailViewModel(item: item, orderController: orderController)
        viewModel.addOrRemoveFromOrder()

        XCTAssertFalse(orderController.order.items.contains { $0 == item })
    }

    func test_whenItemIsNotInOrder_buttonActionAddsIt() {
        let item = MenuItem.fixture()
        let orderController = OrderController()

        let viewModel = MenuItemDetailViewModel(item: item, orderController: orderController)
        viewModel.addOrRemoveFromOrder()

        XCTAssertTrue(orderController.order.items.contains { $0 == item })
    }
}
