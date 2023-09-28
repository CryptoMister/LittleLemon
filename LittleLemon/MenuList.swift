//
//  MenuList.swift
//  LittleLemon
//
//  Created by Marco Eckey on 28.09.23.
//

import Foundation


struct MenuList : Decodable {
    var menu : [MenuItem]
}

struct MenuItem : Decodable {
    var title : String
    var price : String
    var image : String 
}
