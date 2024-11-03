//
//  BeerManager.swift
//  BeerApp
//
//  Created by Павел Градов on 31.10.2024.
//

import Foundation

enum BeerType: Int {
    case lightBeer = 0, mediumBeer, heavyBeer
}

final class BeerManager {
    static let shared = BeerManager()
    
    private var beerPack: [Beer] = [
        Beer(name: "Old Boy", price: 2.0),
        Beer(name: "Star Wars", price: 3.0),
        Beer(name: "True Man", price: 4.0)
    ]
    
    var currentOrder: [Int] = [0, 0, 0] // текущий заказ, индекс 0 - первое пиво, 1 - второе, 2 - третье
    var soldBeers: [Int] = [0, 0, 0] // исполненные заказы, индексы те же
    
    private init() { }
    
    // MARK: функция добавления пива в заказ
    func addBeer(beerType beer: BeerType) {
        if beerPack[beer.rawValue].balance > 0 { // проверяем, есть ли ещё пиво в запасе
            beerPack[beer.rawValue].balance -= 1 // уменьшаем запас
            currentOrder[beer.rawValue] += 1 // добавляем в текущий заказ
        }
    }
    
    // MARK: функция удаления пива из заказа
    func removeBeer(beerType beer: BeerType) {
        if currentOrder[beer.rawValue] > 0 {
            currentOrder[beer.rawValue] -= 1
            beerPack[beer.rawValue].balance += 1
        }
    }
    
    // MARK: функиця обнуления текущего заказа и баланса каждого из пива
    func startDay() -> String {
        for index in 0..<currentOrder.count {
            currentOrder[index] = 0
        }
        
        for index in 0..<beerPack.count {
            beerPack[index].balance = 100
        }
        
        return "New day begins"
    }
    
    // MARK: функция подсчета выручки за текущий день
    func endDay() -> String {
        var soldString = ""
        var totalPrice = 0.0
        
        for index in 0..<soldBeers.count {
            totalPrice += beerPack[index].price * Double(soldBeers[index])
            soldString += "\(soldBeers[index]) бутылки * \(beerPack[index].price) - \"\(beerPack[index].name)\"\n"
        }
        
        soldString += "Total price: \(totalPrice)$"
        soldBeers = [0, 0, 0]
        
        return soldString
    }
    
    // MARK: функция покупки текущего заказа
    func sell() -> String {
        guard isOrderEmpty() == false else { return "Order is empty" }
        var orderString = ""
        var orderPrice = 0.0
        
        for index in 0..<currentOrder.count {
            orderPrice += beerPack[index].price * Double(currentOrder[index])
            orderString += "\(currentOrder[index]) бутылки * \(beerPack[index].price) - \"\(beerPack[index].name)\"\n"
        }
        
        orderString += "Order price: \(orderPrice)$"
        for index in 0..<currentOrder.count {
            soldBeers[index] += currentOrder[index]
        }
        currentOrder = [0, 0, 0]
        
        return orderString
    }
    
    private func isOrderEmpty() -> Bool {
        var isEmpty: Bool = true
        for beer in currentOrder {
            if beer > 0 {
                isEmpty = false
                break
            }
        }
        return isEmpty
    }
}
