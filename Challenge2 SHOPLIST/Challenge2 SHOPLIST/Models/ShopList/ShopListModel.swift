//
//  ShopListModel.swift
//  Challenge2 SHOPLIST
//
//  Created by Carlos Barcelos on 09/06/21.
//

import Foundation

protocol ShopListProtocol {
    var name: String { get set }
}
struct Item: ShopListProtocol {
    var name: String
    
    init(_ name: String) {
        self.name = name
    }
}
