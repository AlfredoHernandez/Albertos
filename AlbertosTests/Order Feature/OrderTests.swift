//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

@testable import Albertos
import XCTest

class OrderTests: XCTestCase {
    func testTotalSumsPricesOfEachItem() {
        let order = Order(
            items: [.fixture(price: 1.0), .fixture(price: 2.0), .fixture(price: 3.5)]
        )

        XCTAssertEqual(order.total, 6.5)
    }
}
