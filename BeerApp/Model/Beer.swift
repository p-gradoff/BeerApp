//
//  Beer.swift
//  BeerApp
//
//  Created by Павел Градов on 31.10.2024.
//

import Foundation

class Beer {
    var name: String
    var price: Double
    var balance: Int
    
    init(name: String, price: Double, balance: Int = 100) {
        self.name = name
        self.price = price
        self.balance = balance
    }
}
