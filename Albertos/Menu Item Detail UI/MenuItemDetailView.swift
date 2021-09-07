//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import SwiftUI

struct MenuItemDetailView: View {
    @ObservedObject private(set) var viewModel: MenuItemDetailViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.name)
                .fontWeight(.bold)

            if let spicy = viewModel.spicy {
                Text(spicy)
                    .font(Font.body.italic())
            }

            Text(viewModel.price)
            Button(viewModel.addOrRemoveFromOrderButtonText) {
                viewModel.addOrRemoveFromOrder()
            }
            Spacer()
        }
        .padding(8)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}
