//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

@testable import Albertos
import AlbertosCore
import XCTest

class MenuItemDetailViewModelTests: XCTestCase {
    func test_nameIsItemName() {
        let (sut, _) = makeSUT(item: .fixture(name: "a name"))

        XCTAssertEqual(sut.name, "a name")
    }

    func test_whenItemIsSpicy_showsSpicyMessage() {
        let (sut, _) = makeSUT(item: .fixture(spicy: true))

        XCTAssertEqual(sut.spicy, "Spicy")
    }

    func test_whenItemIsNotSpicy_doesNotShowSpicyMessage() {
        let (sut, _) = makeSUT(item: .fixture(spicy: false))

        XCTAssertNil(sut.spicy)
    }

    func test_price_isFormattedItemPrice() {
        XCTAssertEqual(sut(item: .fixture(price: 1.0)).price, "$1.00")
        XCTAssertEqual(sut(item: .fixture(price: 2.5)).price, "$2.50")
        XCTAssertEqual(sut(item: .fixture(price: 3.45)).price, "$3.45")
        XCTAssertEqual(sut(item: .fixture(price: 4.123)).price, "$4.12")
    }

    func test_numberOfItemsInOrder_excludesOtherItems() {
        let item: MenuItem = .fixture(name: "an item")
        let (sut, _) = makeSUT(item: item, order: [.fixture(name: "another item")])

        XCTAssertEqual(sut.numberOfItemsInOrder, "0 items in order")

        sut.addItem()
        XCTAssertEqual(sut.numberOfItemsInOrder, "1 items in order")

        sut.addItem()
        XCTAssertEqual(sut.numberOfItemsInOrder, "2 items in order")

        sut.removeItem()
        XCTAssertEqual(sut.numberOfItemsInOrder, "1 items in order")
    }

    // MARK: - Helpers

    private func makeSUT(
        item: MenuItem = .fixture(),
        order: [MenuItem] = [],
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (MenuItemDetailViewModel, OrderController) {
        let orderController = OrderController(order: .init(items: order))
        let sut = MenuItemDetailViewModel(item: item, orderController: orderController)
        trackForMemoryLeaks(orderController, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, orderController)
    }

    private func sut(item: MenuItem = .fixture()) -> MenuItemDetailViewModel {
        makeSUT(item: item).0
    }
}
