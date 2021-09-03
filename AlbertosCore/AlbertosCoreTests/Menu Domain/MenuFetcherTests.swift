//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import AlbertosCore
import Combine
import XCTest

final class MenuFetcherTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()

    func testWhenRequestSucceedsPublishesDecodeMenuItems() throws {
        let json = """
        [
            { "name": "a name", "category": "a category", "spicy": true, "price": 1.0 },
            { "name": "another name", "category": "a category", "spicy": true, "price": 2.0 }
        ]
        """
        let data = try XCTUnwrap(json.data(using: .utf8))
        let menuFetcher = MenuFetcher(networkFetching: NetworkFetchingStub(returning: .success(data)))
        let expectation = XCTestExpectation(description: "Publishes decoded [MenuItem]")
        menuFetcher.fetchMenu()
            .sink(
                receiveCompletion: { completion in
                    print(completion)
                },
                receiveValue: { items in
                    XCTAssertEqual(items.count, 2)
                    XCTAssertEqual(items.first?.name, "a name")
                    XCTAssertEqual(items.last?.name, "another name")
                    expectation.fulfill()
                }
            )
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 5)
    }

    func test_whenRequestFails_publishesReceivedError() {
        let expectedError = URLError(.badServerResponse)
        let menuFetcher = MenuFetcher(networkFetching: NetworkFetchingStub(returning: .failure(expectedError)))
        let expectation = XCTestExpectation(description: "Publishes received URLError")
        menuFetcher.fetchMenu()
            .sink(
                receiveCompletion: { completion in
                    guard case let .failure(error) = completion else { return }
                    XCTAssertEqual(error as? URLError, expectedError)
                    expectation.fulfill()
                },
                receiveValue: { items in
                    XCTFail("Expected to fail, succeeded with \(items)")
                }
            )
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 1)
    }
}
