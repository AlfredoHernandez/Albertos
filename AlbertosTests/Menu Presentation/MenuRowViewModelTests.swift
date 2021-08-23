//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

@testable import Albertos
import XCTest

final class MenuRowViewModelTests: XCTestCase {
    func test_whenItemIsNotSpicy_textIsItemNameOnly() {
        let item: MenuItem = .fixture(name: "a name", spicy: false)
        let viewModel = MenuRowViewModel(item: item)

        XCTAssertEqual(viewModel.text, "a name")
    }

    func test_whenItemIsSpicy_textIsItemWithChillyEmoji() {
        let item: MenuItem = .fixture(name: "a name", spicy: true)
        let viewModel = MenuRowViewModel(item: item)

        XCTAssertEqual(viewModel.text, "a name 🌶")
    }
}
