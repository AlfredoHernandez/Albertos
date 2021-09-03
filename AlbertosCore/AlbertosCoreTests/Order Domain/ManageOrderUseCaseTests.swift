//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

@testable import AlbertosCore
import XCTest

final class ManageOrderUseCaseTests: XCTestCase {
    func test_init_hasNoMenuItems() {
        let (_, store) = makeSUT()

        XCTAssertTrue(store.items.isEmpty)
    }

    func test_add_storesItemInOrder() {
        let (sut, store) = makeSUT()
        let item = MenuItem.fixture()

        sut.addMenuItem(item)

        XCTAssertEqual(store.items, [item])
    }

    // MARK: - Helpers

    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (ManageOrderUseCase, InMemoryOrderStoreSpy) {
        let store = InMemoryOrderStoreSpy()
        let sut = ManageOrderUseCase(store: store)
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, store)
    }

    private class InMemoryOrderStoreSpy: OrderStore {
        var items = [MenuItem]()

        func add(item: MenuItem) {
            items.append(item)
        }

        func remove(item _: MenuItem) {}

        func reset() {}

        func exists(_: MenuItem) -> Bool {
            false
        }
    }
}
