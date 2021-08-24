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
            if viewModel.shouldShowCheckoutButton {
                Button {
                    viewModel.checkOut()
                } label: {
                    Text(viewModel.checkoutButtonText)
                        .font(Font.callout.bold())
                        .padding(12)
                        .foregroundColor(.white)
                        .background(Color.crimson)
                        .cornerRadius(10.0)
                }
            }
            Spacer()
        }
        .padding(8)
    }
}
