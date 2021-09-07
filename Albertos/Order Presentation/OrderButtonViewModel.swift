//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import AlbertosCore
import Combine
import Foundation
import SwiftUI

class OrderButtonViewModel: ObservableObject {
    @Published var text = "Your Order"
    let orderController: OrderController
    var cancellables = Set<AnyCancellable>()

    init(orderController: OrderController) {
        self.orderController = orderController
        orderController.$order.dropFirst().sink { [weak self] order in
            self?.text = "Your Order $\(String(format: "%.2f", order.total))"
        }.store(in: &cancellables)
    }
}
