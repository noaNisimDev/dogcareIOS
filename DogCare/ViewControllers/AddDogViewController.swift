//
//  AddDogViewController.swift
//  DogCare
//

import Foundation
import UIKit

class AddDogViewController: UIViewController {
    
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var trips:UISegmentedControl!
    @IBOutlet weak var feeds:UISegmentedControl!
    var numOfTrips: Int = 1
    var numOfFood: Int = 1
    var tripsArr = [Bool]()
    var feedsArr = [Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveBtn.isEnabled = false
        saveBtn.isHidden = true
        tripsArr.append(false)
        feedsArr.append(false)
        [textFieldName].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
        
        //Looks for single or multiple taps.
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func didTapSaveButton(){
        let uuid = UUID().uuidString
        let randomImage = Utils.images.randomElement()!
        let dog = Dog(id: uuid,image: randomImage, name: textFieldName.text!, numOfTrips: self.numOfTrips, numOfFood: self.numOfFood, trips: tripsArr, food: feedsArr, lastUpdate: Date())
        Utils.saveDog(dog:dog)
        showSavedDogDialog()
    }
    
    @IBAction func tripsChanged(_ sender: Any) {
        
        switch trips.selectedSegmentIndex
        {
        case 0:
            self.numOfTrips = 1
            tripsArr.removeAll()
            tripsArr.append(false)
        case 1:
            self.numOfTrips = 2
            tripsArr.removeAll()
            tripsArr.append(false)
            tripsArr.append(false)
        case 2:
            self.numOfTrips = 3
            tripsArr.removeAll()
            tripsArr.append(false)
            tripsArr.append(false)
            tripsArr.append(false)
            
        default:
            self.numOfTrips = 1
            tripsArr.removeAll()
            tripsArr.append(false)
        }
    }
    
    @IBAction func feedsChanged(_ sender: Any) {
        switch feeds.selectedSegmentIndex
        {
        case 0:
            self.numOfFood = 1
            feedsArr.removeAll()
            feedsArr.append(false)
        case 1:
            self.numOfFood = 2
            feedsArr.removeAll()
            feedsArr.append(false)
            feedsArr.append(false)
            
        case 2:
            self.numOfFood = 3
            feedsArr.removeAll()
            feedsArr.append(false)
            feedsArr.append(false)
            feedsArr.append(false)
            
        default:
            self.numOfFood = 1
            feedsArr.removeAll()
            feedsArr.append(false)
        }
    }
    
    func showSavedDogDialog(){
        let alertController = UIAlertController(
            title: "Woof Woof!",
            message: "Dog added to DogCare",
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Great", style: .cancel) { [weak self] (action) in
            // self!.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(okAction)
        
        present(alertController, animated: true) { }
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        if textFieldName.text?.count == 1 {
            if textFieldName.text?.first == " " {
                textFieldName.text = ""
                return
            }
        }
        guard
            let name = textFieldName.text, !name.isEmpty
        else {
            saveBtn.isEnabled = false
            saveBtn.isHidden = true
            return
        }
        saveBtn.isEnabled = true
        saveBtn.isHidden = false
        
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    
}
