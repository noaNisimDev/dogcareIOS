//
//  DogCareViewController.swift
//  DogCare
//

import Foundation
import UIKit

class DogCareViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private var collectionView : UICollectionView?
    @IBOutlet weak var nameLbl : UILabel?
    @IBOutlet weak var morningTrip: UISwitch!
    @IBOutlet weak var noonTrip: UISwitch!
    @IBOutlet weak var nightTrip: UISwitch!
    @IBOutlet weak var morningFeed: UISwitch!
    @IBOutlet weak var noonFeed: UISwitch!
    @IBOutlet weak var nightFeed: UISwitch!
    @IBOutlet weak var saveBtn: UIButton!
    
    
    var dogs:[Dog]? = nil
    var selectedDogPos:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.backgroundColor = .none
        collectionView?.register(CircleCollectionViewCell.self, forCellWithReuseIdentifier: CircleCollectionViewCell.identifier)
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.delegate = self
        collectionView?.dataSource = self
        guard let myCollection = collectionView else {
            return
        }
        view.addSubview(myCollection)
        
        dogs = Utils.getDogs()
        if(dogs != nil){
            for dog in dogs! {
                //check if date is not today - if so zero down all feeds and trips
                print(dog)
            }
        }
    }
    
    @IBAction func didTapSaveButton(){
        for _ in 0...self.dogs!.count{
            UserDefaults.standard.removeObject(forKey: "dogs")
        }
        Utils.saveMultiDogs(dogs: self.dogs!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // this line need
        dogs = Utils.getDogs()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: 100).integral
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDogPos = indexPath.row
        //refresh from Storage
        self.dogs! = Utils.getDogs()
        nameLbl?.text = "Let's take care of \(self.dogs![indexPath.row].name)"
        setAllToBase()
        switch self.dogs![indexPath.row].numOfTrips {
        case 1:
            morningTrip.isEnabled = true
            noonTrip.isOn = false
            nightTrip.isOn = false
            if(self.dogs![indexPath.row].trips[0] == true){
                morningTrip.setOn(true, animated: true)
            }
            else{
                morningTrip.setOn(false, animated: true)
                
            }
        case 2:
            morningTrip.isEnabled = true
            noonTrip.isEnabled = true
            nightTrip.isOn = false
            if(self.dogs![indexPath.row].trips[0] == true){
                morningTrip.setOn(true, animated: true)
            }
            else{
                morningTrip.setOn(false, animated: true)
            }
            if(self.dogs![indexPath.row].trips[1] == true){
                noonTrip.setOn(true, animated: true)
            }
            else{
                noonTrip.setOn(false, animated: true)
            }
        case 3:
            morningTrip.isEnabled = true
            noonTrip.isEnabled = true
            nightTrip.isEnabled = true
            if(self.dogs![indexPath.row].trips[0] == true){
                morningTrip.setOn(true, animated: true)
            }
            else{
                morningTrip.setOn(false, animated: true)
            }
            if(self.dogs![indexPath.row].trips[1] == true){
                noonTrip.setOn(true, animated: true)
            }
            else{
                noonTrip.setOn(false, animated: true)
            }
            if(self.dogs![indexPath.row].trips[2] == true){
                nightTrip.setOn(true, animated: true)
            }
            else{
                nightTrip.setOn(false, animated: true)
            }
        default:
            return
        }
        
        switch self.dogs![indexPath.row].numOfFood {
        case 1:
            morningFeed.isEnabled = true
            noonFeed.isOn = false
            nightFeed.isOn = false
            if(self.dogs![indexPath.row].food[0] == true){
                morningFeed.setOn(true, animated: true)
            }
            else{
                morningFeed.setOn(false, animated: true)
                
            }
        case 2:
            morningFeed.isEnabled = true
            noonFeed.isEnabled = true
            nightFeed.isOn = false
            if(self.dogs![indexPath.row].food[0] == true){
                morningFeed.setOn(true, animated: true)
            }
            else{
                morningFeed.setOn(false, animated: true)
            }
            if(self.dogs![indexPath.row].food[1] == true){
                noonFeed.setOn(true, animated: true)
            }
            else{
                noonFeed.setOn(false, animated: true)
            }
        case 3:
            morningFeed.isEnabled = true
            noonFeed.isEnabled = true
            nightFeed.isEnabled = true
            if(self.dogs![indexPath.row].food[0] == true){
                morningFeed.setOn(true, animated: true)
            }
            else{
                morningFeed.setOn(false, animated: true)
            }
            if(self.dogs![indexPath.row].food[1] == true){
                noonFeed.setOn(true, animated: true)
            }
            else{
                noonFeed.setOn(false, animated: true)
            }
            if(self.dogs![indexPath.row].food[2] == true){
                nightFeed.setOn(true, animated: true)
            }
            else{
                nightFeed.setOn(false, animated: true)
            }
        default:
            return
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dogs?.count ?? 0
        //return dogImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CircleCollectionViewCell.identifier, for: indexPath) as! CircleCollectionViewCell
        cell.configure(with: dogs![indexPath.row].image)
        return cell
    }
    
    func setAllToBase(){
        self.morningFeed.isEnabled = false
        self.noonFeed.isEnabled = false
        self.nightFeed.isEnabled = false
        self.morningTrip.isEnabled = false
        self.noonTrip.isEnabled = false
        self.nightTrip.isEnabled = false
    }
    
    @IBAction func morningTripChange(_ sender: Any) {
        self.dogs?[self.selectedDogPos].trips[0] = morningTrip.isOn
    }
    
    @IBAction func noonTripChange(_ sender: Any) {
        self.dogs?[self.selectedDogPos].trips[1] = noonTrip.isOn
    }
    @IBAction func nightTripChange(_ sender: Any) {
        self.dogs?[self.selectedDogPos].trips[2] = nightTrip.isOn
    }
    
    @IBAction func morningFeegChange(_ sender: Any) {
        self.dogs?[self.selectedDogPos].food[0] = morningFeed.isOn
    }
    
    @IBAction func noonFeedChange(_ sender: Any) {
        self.dogs?[self.selectedDogPos].food[1] = noonFeed.isOn
    }
    
    @IBAction func nightFeedChange(_ sender: Any) {
        self.dogs?[self.selectedDogPos].food[2] = nightFeed.isOn
    }
    
    
    
}
