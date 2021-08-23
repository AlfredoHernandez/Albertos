//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Combine
import Foundation

protocol MenuFetching {
    func fetchMenu() -> AnyPublisher<[MenuItem], Error>
}
