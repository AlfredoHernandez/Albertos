//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

@testable import Albertos
import XCTest

final class MenuGroupingTests: XCTestCase {
    func test_menuWithManyCategories_returnsOneSectionPerCategory() {
        let menu: [MenuItem] = [
            .fixture(category: "pastas"),
            .fixture(category: "drinks"),
            .fixture(category: "pastas"),
            .fixture(category: "desserts"),
        ]

        let sections = groupMenuByCategory(menu)

        XCTAssertEqual(sections.count, 3)
        XCTAssertEqual(sections[safe: 0]?.category, "pastas")
        XCTAssertEqual(sections[safe: 1]?.category, "drinks")
        XCTAssertEqual(sections[safe: 2]?.category, "desserts")
    }

    func test_menuWithOneCategory_returnsOneSection() throws {
        let menu: [MenuItem] = [
            .fixture(category: "pastas", name: "name"),
            .fixture(category: "pastas", name: "other name"),
        ]

        let sections = groupMenuByCategory(menu)

        XCTAssertEqual(sections.count, 1)
        let section = try XCTUnwrap(sections.first)
        XCTAssertEqual(section.items.count, 2)
        XCTAssertEqual(section.items.first?.name, "name")
        XCTAssertEqual(section.items.last?.name, "other name")
    }

    func test_emptyMenu_returnsEmptySections() {
        let menu = [MenuItem]()

        let sections = groupMenuByCategory(menu)

        XCTAssertTrue(sections.isEmpty)
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
