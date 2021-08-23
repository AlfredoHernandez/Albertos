//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import SwiftUI

struct MenuList: View {
    @ObservedObject var viewModel: MenuListViewModel

    var body: some View {
        switch viewModel.sections {
        case let .success(menuSections):
            List {
                ForEach(menuSections) { section in
                    Section(header: Text(section.category)) {
                        ForEach(section.items) { item in
                            NavigationLink(destination: MenuItemDetail(viewModel: .init(item: item))) {
                                MenuRow(viewModel: .init(item: item))
                            }
                        }
                    }
                }
            }
        case let .failure(error):
            Text("An error occurred: ")
            Text(error.localizedDescription).italic()
        }
    }
}
