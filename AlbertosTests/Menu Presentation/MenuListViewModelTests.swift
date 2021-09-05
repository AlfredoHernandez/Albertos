//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

@testable import Albertos
import AlbertosCore
import Combine
import XCTest

final class MenuListViewModelTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()

    func test_hasErrorMessage() {
        XCTAssertEqual(MenuListViewModel.errorMessage, "An error occurred: ")
    }

    func test_whenFetchingStarts_publishesEmptyMenu() throws {
        let (sut, _) = makeSUT()

        let sections = try sut.sections.get()
        XCTAssertTrue(sections.isEmpty)
    }

    func test_whenFecthingMenuSucceedsAndGroupingByCategory_publishesSectionsBuiltFromReceivedMenu() {
        let menu: [MenuItem] = [
            .fixture(category: "category A", name: "item 1"),
            .fixture(category: "category B", name: "item 2"),
        ]
        let (sut, fetcher) = makeSUT(menuGrouping: groupMenuByCategory)

        let expectedMenu: [MenuSection] = [
            .fixture(category: "category B", items: [menu.last!]),
            .fixture(category: "category A", items: [menu.first!]),
        ]
        assertThat(sut, completesWith: .success(expectedMenu), when: {
            fetcher.complete(with: menu)
        })
    }

    func test_whenFetchingFails_publishesAnError() {
        let (sut, fetcher) = makeSUT()

        assertThat(sut, completesWith: .failure(anyNSError()), when: {
            fetcher.complete(with: anyNSError())
        })
    }

    // MARK: - Helpers

    private func makeSUT(
        menuGrouping: @escaping ([MenuItem]) -> [MenuSection] = { _ in [] },
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (MenuListViewModel, MenuFetcherSpy) {
        let fetcherSpy = MenuFetcherSpy()
        let sut = MenuListViewModel(menuFetcher: fetcherSpy.publisher(), menuGroupingStrategy: menuGrouping)
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(fetcherSpy, file: file, line: line)
        return (sut, fetcherSpy)
    }

    private func assertThat(
        _ sut: MenuListViewModel,
        completesWith expectedResult: Result<[MenuSection], Error>,
        when action: () -> Void,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        let expectation = XCTestExpectation(description: "Wait for loader to complete")
        sut
            .$sections
            .dropFirst()
            .sink { receivedResult in
                switch (receivedResult, expectedResult) {
                case let (.success(receivedMenu), .success(expectedMenu)):
                    XCTAssertEqual(receivedMenu, expectedMenu, file: file, line: line)
                case let (.failure(receivedError), .failure(expectedError)):
                    XCTAssertEqual(receivedError as NSError, expectedError as NSError, file: file, line: line)
                default:
                    XCTFail("Expected \(expectedResult), got \(receivedResult) instead.", file: file, line: line)
                }
                expectation.fulfill()
            }
            .store(in: &cancellables)

        action()
        wait(for: [expectation], timeout: 1)
    }
}
