//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import SwiftUI

struct AlertViewModel: Identifiable {
    let title: String
    let message: String
    let buttonText: String

    var id: String { title + message + buttonText }
}
