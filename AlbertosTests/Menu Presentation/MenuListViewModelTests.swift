//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

@testable import Albertos
import XCTest

final class MenuListViewModelTests: XCTestCase {
    func test_callsGivenGroupingFunction() {
        var called = false
        let inputSections = [MenuSection.fixture()]

        let spyClosure: ([MenuItem]) -> [MenuSection] = { _ in
            called = true
            return inputSections
        }

        let viewModel = MenuListViewModel(menu: [.fixture()], menuGrouping: spyClosure)

        let sections = viewModel.sections
        XCTAssertTrue(called)
        XCTAssertEqual(sections, inputSections)
    }
}
