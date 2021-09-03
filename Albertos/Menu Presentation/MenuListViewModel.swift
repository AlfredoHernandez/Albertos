//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import AlbertosCore
import Combine
import Foundation

class MenuListViewModel: ObservableObject {
    @Published private(set) var sections: Result<[MenuSection], Error> = .success([])

    var cancellables = Set<AnyCancellable>()

    init(menuFetcher: AnyPublisher<[MenuItem], Error>, menuGrouping: @escaping ([MenuItem]) -> [MenuSection] = groupMenuByCategory) {
        menuFetcher
            .sink(
                receiveCompletion: { [weak self] completion in
                    guard case let .failure(error) = completion else {
                        return
                    }
                    self?.sections = .failure(error)
                },
                receiveValue: { [weak self] value in
                    self?.sections = .success(menuGrouping(value))
                }
            )
            .store(in: &cancellables)
    }
}

extension MenuSection: Identifiable {
    public var id: String { category }
}
