//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Combine
import Foundation

protocol MenuFetching {
    func fetchMenu() -> AnyPublisher<[MenuItem], Error>
}

class MenuListViewModel: ObservableObject {
    @Published private(set) var sections: Result<[MenuSection], Error> = .success([])

    var cancellables = Set<AnyCancellable>()

    init(menuFetcher: MenuFetching, menuGrouping: @escaping ([MenuItem]) -> [MenuSection] = groupMenuByCategory) {
        menuFetcher
            .fetchMenu()
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
