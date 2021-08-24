//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import SwiftUI

struct OrderDetail: View {
    let viewModel: OrderDetailViewModel

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text(viewModel.headerText)
            if viewModel.orderedItems.isEmpty {
                Text(viewModel.emptyMenuFallbackText).multilineTextAlignment(.center)
            } else {
                List(viewModel.orderedItems) { Text($0.name) }
            }
            if let totalAmount = viewModel.totalAmmount {
                Text(totalAmount)
            }
            Spacer()
        }
        .padding(8)
    }
}
