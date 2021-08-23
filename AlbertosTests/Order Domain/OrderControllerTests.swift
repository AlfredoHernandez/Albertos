//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

@testable import Albertos
import XCTest

class OrderControllerTests: XCTestCase {
    func test_initsWithEmptyOrder() {
        let controller = OrderController()

        XCTAssertTrue(controller.order.items.isEmpty)
    }

    func test_whenItemNotInOrder_returnsFalse() {
        let controller = OrderController()
        controller.addToOrder(item: .fixture(name: "a name"))

        XCTAssertFalse(controller.isItemInOrder(.fixture(name: "another name")))
    }

    func test_whenItemInOrder_returnsTrue() {
        let controller = OrderController()
        controller.addToOrder(item: .fixture(name: "a name"))

        XCTAssertTrue(controller.isItemInOrder(.fixture(name: "a name")))
    }

    func test_addingItem_updatesOrder() {
        let controller = OrderController()

        let item = MenuItem.fixture()
        controller.addToOrder(item: item)

        XCTAssertEqual(controller.order.items.count, 1)
        XCTAssertEqual(controller.order.items.first, item)
    }

    func test_removingItem_updatesOrder() {
        let item = MenuItem.fixture(name: "a name")
        let otherItem = MenuItem.fixture(name: "another name")
        let controller = OrderController()
        controller.addToOrder(item: item)
        controller.addToOrder(item: otherItem)

        controller.removeFromOrder(item: item)

        XCTAssertEqual(controller.order.items.count, 1)
        XCTAssertEqual(controller.order.items.first, otherItem)
    }
}