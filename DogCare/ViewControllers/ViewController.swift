//
//  ViewController.swift
//  DogCare
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapButton() {
        let vc = storyboard?.instantiateViewController(identifier: "main_screen") as! UITabBarController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
    }
    
    
}

