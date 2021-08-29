//
//  Dog.swift
//  DogCare
//

import Foundation
class Dog : Codable, CustomStringConvertible {
    
    //TODO: add image
    var id: String
    var image: String
    var name: String
    var numOfTrips: Int
    var numOfFood: Int
    var trips = [Bool]()
    var food = [Bool]()
    var lastUpdate: Date
    
    internal init(id: String,image: String, name: String, numOfTrips: Int, numOfFood: Int, trips: [Bool] = [Bool](), food: [Bool] = [Bool](), lastUpdate: Date) {
        self.id = id
        self.image = image
        self.name = name
        self.numOfTrips = numOfTrips
        self.numOfFood = numOfFood
        self.trips = trips
        self.food = food
        self.lastUpdate = lastUpdate
    }
    
    public var description: String { return "Dog: \(name) Needs to go for \(numOfTrips) Trips and eats \(numOfFood) Times last update: \(lastUpdate)" }
    
    
}
