//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import AlbertosCore
import XCTest

final class MenuItemsTests: XCTestCase {
    func test_whenDecodedFromJSONData_hasAllTheInputProperties() throws {
        let json = MenuItem.jsonFixture(name: "a name", category: "a category", spicy: false)
        let data = try XCTUnwrap(json.data(using: .utf8))
        let item = try JSONDecoder().decode(MenuItem.self, from: data)
        XCTAssertEqual(item.name, "a name")
        XCTAssertEqual(item.category, "a category")
        XCTAssertEqual(item.spicy, false)
    }
}
