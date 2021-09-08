//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

@testable import Albertos
import AlbertosCore
import XCTest

class OrderButtonViewModelTests: XCTestCase {
    func test_whenOrderIsEmpty_doesNotShowTotal() {
        let (sut, _) = makeSUT()

        XCTAssertEqual(sut.text, "Your Order")
    }

    func test_whenOrderIsNotEmpty_showsTotal() {
        let (sut, order) = makeSUT()

        order.addMenuItem(.fixture(price: 5.45))
        XCTAssertEqual(sut.text, "Your Order $5.45")

        order.addMenuItem(.fixture(price: 1.00))
        XCTAssertEqual(sut.text, "Your Order $6.45")

        order.addMenuItem(.fixture(price: 3.55))
        XCTAssertEqual(sut.text, "Your Order $10.00")
    }

    // MARK: - Helpers

    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (OrderButtonViewModel, OrderController) {
        let orderController = OrderController()
        let sut = OrderButtonViewModel(orderController: orderController)
        trackForMemoryLeaks(orderController, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, orderController)
    }
}
