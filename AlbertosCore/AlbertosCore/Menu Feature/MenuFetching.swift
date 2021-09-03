//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Combine
import Foundation

public protocol MenuFetching {
    func fetchMenu() -> AnyPublisher<[MenuItem], Error>
}
