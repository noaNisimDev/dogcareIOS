//
//  DeleteDogViewController.swift
//  DogCare
//

import Foundation
import UIKit

class DeleteDogViewController: UIViewController {
    @IBOutlet var table : UITableView!
    @IBOutlet var deleteBtn : UIButton!
    var dogs:[Dog]? = nil
    var dogToDelete:Dog? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dogs = Utils.getDogs()
        table.delegate = self
        table.dataSource = self
        deleteBtn.isHidden = true
        deleteBtn.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // this line need
        dogs = Utils.getDogs()
        UIView.transition(with: self.table, duration: 0.2, options: .transitionCrossDissolve, animations: {self.table.reloadData()}, completion: nil)
        
    }
    
    @IBAction func didTapDelete(){
        showDeleteDogDialog()
    }
    
    func showDeleteDogDialog(){
        let alertController = UIAlertController(
            title: "Are you sure you want to remove \(dogToDelete!.name)?",
            message: "This action is irreversible",
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Yes, DELETE", style: .default) { [weak self] (action) in
            let index = self!.dogs?.firstIndex(where: {$0 === self!.dogToDelete!})
            self!.dogs?.remove(at: index!)
            //remove alldogs - than add new array
            for _ in 0...self!.dogs!.count{
                UserDefaults.standard.removeObject(forKey: "dogs")
            }
            Utils.saveMultiDogs(dogs: self!.dogs!)
            UIView.transition(with: self!.table, duration: 0.5, options: .transitionCrossDissolve, animations: {self!.table.reloadData()}, completion: nil)

        }
        let cancelAction = UIAlertAction(title: "No, Cancel", style: .cancel) { [weak self] (action) in
            //self!.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true) { }
    }
    
}

extension DeleteDogViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row < dogs!.count){
            //set current row as selected dog to delete
            dogToDelete = dogs![indexPath.row]
        }
        
    }
}

extension DeleteDogViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if((self.dogs) == nil){
            return 0
        }
        return self.dogs!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if(dogs != nil){
            if(indexPath.row < dogs!.count){
                let dog = dogs![indexPath.row]
                let name = dog.name
                print("adding \(name) to table")
                cell.textLabel?.text = "\(indexPath.row + 1). \(name) "
                cell.textLabel?.numberOfLines = 1
                deleteBtn.isHidden = false
                deleteBtn.isEnabled = true
            }
        }
        return cell
    }
}
