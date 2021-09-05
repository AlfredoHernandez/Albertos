//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

@testable import AlbertosCore
import XCTest

final class ManageOrderUseCaseTests: XCTestCase {
    func test_init_hasNoMenuItems() {
        let sut = makeSUT()

        XCTAssertTrue(sut.items.isEmpty)
    }

    func test_add_storesItemInOrder() {
        let sut = makeSUT()
        let item: MenuItem = .fixture()

        sut.addMenuItem(item)

        XCTAssertEqual(sut.items, [item])
    }

    func test_removeMenuItem_whenItemDoesntExist_throwsItemNotFoundError() throws {
        let sut = makeSUT()
        let item: MenuItem = .fixture(name: "a name")

        XCTAssertThrowsError(try sut.removeMenuItem(.fixture())) { error in
            XCTAssertEqual(error as? ManageOrderUseCase.Error, ManageOrderUseCase.Error.itemNotFound)
        }

        sut.addMenuItem(item)
        XCTAssertThrowsError(try sut.removeMenuItem(.fixture(name: "another item")))
    }

    func test_remove_removesItemInOrder() throws {
        let sut = makeSUT()
        let item: MenuItem = .fixture(name: "a name")

        sut.addMenuItem(item)
        sut.addMenuItem(item)
        XCTAssertEqual(sut.items, [item, item])

        try sut.removeMenuItem(item)
        XCTAssertEqual(sut.items, [item])
    }

    func test_resetOrder_removesAllItemsInOrder() {
        let one: MenuItem = .fixture(name: "one")
        let two: MenuItem = .fixture(name: "two")
        let three: MenuItem = .fixture(name: "three")
        let sut = makeSUT(items: [one, two, three])

        XCTAssertEqual(sut.items, [one, two, three])

        sut.resetOrder()
        XCTAssertEqual(sut.items, [])
    }

    func test_total_sumsPricesOfEachMenuItem() {
        let sut = makeSUT(items: [
            .fixture(price: 1.0),
            .fixture(price: 2.0),
            .fixture(price: 3.0),
        ])

        XCTAssertEqual(sut.total, 6.0)

        sut.addMenuItem(.fixture(name: "a product", price: 1.0))
        sut.addMenuItem(.fixture(name: "a product", price: 1.0))

        XCTAssertEqual(sut.total, 8.0)
    }

    func test_isItemInOrder_whenIsInOrder_returnsTrue() throws {
        let item: MenuItem = .fixture(name: "item in order")
        let sut = makeSUT(items: [item, item])

        XCTAssertTrue(sut.isItemInOrder(item))
        XCTAssertFalse(sut.isItemInOrder(.fixture(name: "item not in order")))

        try sut.removeMenuItem(item)
        XCTAssertTrue(sut.isItemInOrder(item))

        try sut.removeMenuItem(item)
        XCTAssertFalse(sut.isItemInOrder(item))
    }

    // MARK: - Helpers

    private func makeSUT(items: [MenuItem] = [], file: StaticString = #filePath, line: UInt = #line) -> ManageOrderUseCase {
        let sut = ManageOrderUseCase(items: items)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}
