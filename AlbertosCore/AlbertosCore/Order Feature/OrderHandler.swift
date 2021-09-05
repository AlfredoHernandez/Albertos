//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Foundation

public protocol OrderHandler {
    var items: [MenuItem] { get }
    var total: Double { get }
    func addMenuItem(_ item: MenuItem)
    func removeMenuItem(_ item: MenuItem) throws
    func resetOrder()
    func isItemInOrder(_ item: MenuItem) -> Bool
}
