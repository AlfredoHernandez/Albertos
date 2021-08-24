//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Combine
import SwiftUI

@main
struct AlbertosApp: App {
    let orderController = OrderController()

    var body: some Scene {
        WindowGroup {
            ZStack(alignment: .bottom) {
                NavigationView {
                    MenuList(viewModel: .init(menuFetcher: MenuFetcher()))
                        .navigationTitle("Alberto's 🇮🇹")
                }
                OrderButton(viewModel: .init(orderController: orderController))
                    .padding(6)
            }
            .environmentObject(orderController)
        }
    }
}
