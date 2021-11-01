//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import AlbertosCore
import XCTest

class OrderControllerTests: XCTestCase {
    func test_initsWithEmptyOrder() {
        let sut = makeSUT()

        XCTAssertTrue(sut.order.items.isEmpty)
    }

    func test_whenItemNotInOrder_returnsFalse() {
        let sut = makeSUT()
        sut.addMenuItem(.fixture(name: "a name"))

        XCTAssertFalse(sut.isItemInOrder(.fixture(name: "another name")))
    }

    func test_whenItemInOrder_returnsTrue() {
        let sut = makeSUT()
        sut.addMenuItem(.fixture(name: "a name"))

        XCTAssertTrue(sut.isItemInOrder(.fixture(name: "a name")))
    }

    func test_addingItem_updatesOrder() {
        let sut = makeSUT()

        let item = MenuItem.fixture()
        sut.addMenuItem(item)

        XCTAssertEqual(sut.order.items.count, 1)
        XCTAssertEqual(sut.order.items.first, item)
    }

    func test_removingItem_updatesOrder() {
        let item = MenuItem.fixture(name: "a name")
        let otherItem = MenuItem.fixture(name: "another name")
        let sut = makeSUT()
        sut.addMenuItem(item)
        sut.addMenuItem(otherItem)

        sut.removeMenuItem(item)

        XCTAssertEqual(sut.order.items.count, 1)
        XCTAssertEqual(sut.order.items.first, otherItem)
    }

    func test_resetOrder_removesAllItemsInOrder() {
        let sut = makeSUT()
        sut.addMenuItem(.fixture())
        sut.addMenuItem(.fixture())

        XCTAssertEqual(sut.order.items.count, 2)

        sut.resetOrder()
        XCTAssertEqual(sut.order.items.count, 0)
    }

    // MARK: - Helpers

    private func makeSUT() -> OrderController {
        let controller = OrderController()
        return controller
    }
}
