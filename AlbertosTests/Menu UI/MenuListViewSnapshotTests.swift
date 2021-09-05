//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

@testable import Albertos
import AlbertosCore
import Combine
import SwiftUI
import XCTest

final class MenuListViewSnapshotTests: XCTestCase {
    func test_menu_withItems() {
        let (sut, loader) = makeSUT()

        loader.send([
            .fixture(category: "Desserts", name: "A dessert"),
            .fixture(category: "Drinks", name: "Water"),
            .fixture(category: "Pastas", name: "Tortellini"),
            .fixture(category: "Pastas", name: "Spaghetti", spicy: true),
        ])

        assert(snapshot: sut.snapshot(for: .device(style: .light)), named: "menu_withItems_light")
        assert(snapshot: sut.snapshot(for: .device(style: .dark)), named: "menu_withItems_dark")
        assert(
            snapshot: sut.snapshot(for: .device(style: .light, preferredContentSizeCategory: .extraExtraExtraLarge)),
            named: "menu_withItems_extraExtraExtraLarge_light"
        )
    }

    // MARK: - Helpers

    private func makeSUT() -> (UIHostingController<MenuListView>, PassthroughSubject<[MenuItem], Error>) {
        let publisher = PassthroughSubject<[MenuItem], Error>()
        let viewModel = MenuListViewModel(
            menuFetcher: publisher.eraseToAnyPublisher(),
            menuGroupingStrategy: groupMenuByCategory
        )

        let sut = MenuListView(viewModel: viewModel, orderController: OrderController())
        return (UIHostingController(rootView: sut), publisher)
    }
}
