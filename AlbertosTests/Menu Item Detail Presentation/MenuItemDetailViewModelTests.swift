//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

@testable import Albertos
import XCTest

class MenuItemDetailViewModelTests: XCTestCase {
    func testNameIsItemName() {
        XCTAssertEqual(
            MenuItemDetailViewModel(item: .fixture(name: "a name")).name,
            "a name"
        )
    }

    func testWhenItemIsSpicyShowsSpicyMessage() {
        XCTAssertEqual(
            MenuItemDetailViewModel(item: .fixture(spicy: true)).spicy,
            "Spicy"
        )
    }

    func testWhenItemIsNotSpicyDoesNotShowSpicyMessage() {
        XCTAssertNil(MenuItemDetailViewModel(item: .fixture(spicy: false)).spicy)
    }

    func testPriceIsFormattedItemPrice() {
        XCTAssertEqual(
            MenuItemDetailViewModel(item: .fixture(price: 1.0)).price,
            "$1.00"
        )
        XCTAssertEqual(
            MenuItemDetailViewModel(item: .fixture(price: 2.5)).price,
            "$2.50"
        )
        XCTAssertEqual(
            MenuItemDetailViewModel(item: .fixture(price: 3.45)).price,
            "$3.45"
        )
        XCTAssertEqual(
            MenuItemDetailViewModel(item: .fixture(price: 4.123)).price,
            "$4.12"
        )
    }
}
