//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import SwiftUI

struct MenuItemDetailView: View {
    @ObservedObject private(set) var viewModel: MenuItemDetailViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.name)
                .font(.title)
            if let spicy = viewModel.spicy {
                HStack {
                    Text(spicy).font(Font.body.bold())
                    Text("🔥")
                }
            }
            Text(viewModel.price)
            Stepper(
                viewModel.addOrRemoveFromOrderButtonText,
                onIncrement: {
                    viewModel.addOrRemoveFromOrder()
                },
                onDecrement: {}
            )
            Divider()
            Text("Description")
                .bold()
            Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
            )
            Spacer()
        }.padding(.horizontal)
            .navigationBarTitleDisplayMode(.inline)
    }
}
