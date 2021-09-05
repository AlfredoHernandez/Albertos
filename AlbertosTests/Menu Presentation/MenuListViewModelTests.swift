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
        let (sut, _) = makeSUT()

        let sections = try sut.sections.get()
        XCTAssertTrue(sections.isEmpty)
    }

    func test_whenFecthingSucceeds_publishesSectionsBuiltFromReceivedMenuAndGivenGroupingClosure() {
        var receivedMenu: [MenuItem]?
        let expectedSections = [MenuSection.fixture()]
        let spyClosure: ([MenuItem]) -> [MenuSection] = { items in receivedMenu = items
            return expectedSections
        }
        let expectedMenu = [MenuItem.fixture()]
        let (sut, fetcher) = makeSUT(menuGrouping: spyClosure)

        let expectation = XCTestExpectation(
            description: "Publishes sections built from received menu and given grouping closure"
        )
        sut
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

        fetcher.complete(with: expectedMenu)
        wait(for: [expectation], timeout: 1)
    }

    func test_whenFetchingFails_publishesAnError() {
        let expectedError = TestError(id: 123)
        let (sut, fetcher) = makeSUT()
        let exp = XCTestExpectation(description: "Publishes an error")

        sut.$sections.dropFirst().sink { value in
            guard case let .failure(error) = value else {
                return XCTFail("Expected a failing result, got \(value)")
            }
            XCTAssertEqual(error as? TestError, expectedError)
            exp.fulfill()
        }.store(in: &cancellables)

        fetcher.complete(with: expectedError)
        wait(for: [exp], timeout: 1)
    }

    // MARK: - Helpers

    private func makeSUT(
        menuGrouping: @escaping ([MenuItem]) -> [MenuSection] = { _ in [] },
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (MenuListViewModel, MenuFetcherSpy) {
        let fetcherSpy = MenuFetcherSpy()
        let sut = MenuListViewModel(menuFetcher: fetcherSpy.publisher(), menuGrouping: menuGrouping)
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(fetcherSpy, file: file, line: line)
        return (sut, fetcherSpy)
    }
}
