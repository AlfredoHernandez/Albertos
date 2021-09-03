//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

@testable import Albertos
import AlbertosCore
import Combine
import XCTest

final class MenuListViewModelTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()

    func test_whenFetchingStarts_publishesEmptyMenu() throws {
        let viewModel = MenuListViewModel(menuFetcher: MenuFetcherStub(returning: .success([.fixture()])))

        let sections = try viewModel.sections.get()
        XCTAssertTrue(sections.isEmpty)
    }

    func test_whenFecthingSucceeds_publishesSectionsBuiltFromReceivedMenuAndGivenGroupingClosure() {
        var receivedMenu: [MenuItem]?
        let expectedSections = [MenuSection.fixture()]
        let spyClosure: ([MenuItem]) -> [MenuSection] = { items in receivedMenu = items
            return expectedSections
        }

        let expectedMenu = [MenuItem.fixture()]
        let menuFetchingStub = MenuFetcherStub(returning: .success(expectedMenu))

        let viewModel = MenuListViewModel(menuFetcher: menuFetchingStub, menuGrouping: spyClosure)

        let expectation = XCTestExpectation(
            description: "Publishes sections built from received menu and given grouping closure"
        )
        viewModel
            .$sections
            .dropFirst()
            .sink { value in
                guard case let .success(sections) = value else {
                    return XCTFail("Expected a successful result, got \(value)")
                }
                XCTAssertEqual(receivedMenu, expectedMenu)
                XCTAssertEqual(sections, expectedSections)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }

    func test_whenFetchingFails_publishesAnError() {
        let expectedError = TestError(id: 123)
        let menuFetchingStub = MenuFetcherStub(returning: .failure(expectedError))
        let viewModel = MenuListViewModel(menuFetcher: menuFetchingStub, menuGrouping: { _ in [] })
        let exp = XCTestExpectation(description: "Publishes an error")

        viewModel.$sections.dropFirst().sink { value in
            guard case let .failure(error) = value else {
                return XCTFail("Expected a failing result, got \(value)")
            }
            XCTAssertEqual(error as? TestError, expectedError)
            exp.fulfill()
        }.store(in: &cancellables)
        wait(for: [exp], timeout: 1)
    }
}
