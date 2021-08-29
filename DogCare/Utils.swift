//
//  Utils.swift
//  DogCare
// replace UserDefaults to firebase here


import Foundation
class Utils{
    static public var images: [String] = ["dog1", "dog2", "dog3"]
    
    static func getDogs() -> [Dog] {
        if let data = UserDefaults.standard.data(forKey: "dogs"){
            do {
                let decoder = JSONDecoder()
                let dogs = try decoder.decode([Dog].self, from: data)
                return dogs
            } catch {
                print("Error")
            }
        }
        return []
    }
    
    static func clearAllDogsData(){
        
    }
    
    static func saveMultiDogs(dogs: [Dog]){
        for dog in dogs {
            saveDog(dog:dog)
        }
    }
    
    static func saveDog(dog: Dog) {
        var dogs = getDogs()
        dogs.append(dog)
        
        do{
            let encoder = JSONEncoder()
            let data = try encoder.encode(dogs)
            UserDefaults.standard.set(data, forKey: "dogs")
        } catch {
            print("Error")
        }
    }
}
