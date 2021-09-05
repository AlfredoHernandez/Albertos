//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import AlbertosCore
import SwiftUI

struct MenuListView: View {
    @ObservedObject var viewModel: MenuListViewModel
    var orderController: OrderController

    var body: some View {
        switch viewModel.sections {
        case let .success(menuSections):
            List {
                ForEach(menuSections) { section in
                    Section(header: Text(section.category)) {
                        ForEach(section.items) { item in
                            NavigationLink(destination: destination(for: item)) {
                                MenuRow(viewModel: .init(item: item))
                            }
                        }
                    }
                }
            }.listStyle(PlainListStyle())
        case let .failure(error):
            Text("An error occurred: ")
            Text(error.localizedDescription).italic()
        }
    }

    func destination(for item: MenuItem) -> MenuItemDetail {
        MenuItemDetail(viewModel: .init(item: item, orderController: orderController))
    }
}
