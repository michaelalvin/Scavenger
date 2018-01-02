//
//  MainViewController.swift
//  imagepicker
//
//  Created by Michael Alvin on 1/1/18.
//  Copyright © 2018 Sara Robinson. All rights reserved.
//

import UIKit

var list = [String]()

class MainViewController: UIViewController {

    @IBOutlet weak var itemOne: UITextField!
    
    @IBOutlet weak var itemTwo: UITextField!
    
    @IBOutlet weak var itemThree: UITextField!
    
    @IBOutlet weak var itemFour: UITextField!
    
    @IBOutlet weak var itemFive: UITextField!
    
    @IBAction func startHuntButtonTapped(_ sender: Any) {
        if(itemOne.text != ""){
            list.append(itemOne.text!)
        }
        
        if(itemTwo.text != ""){
            list.append(itemTwo.text!)
        }
        
        if(itemThree.text != ""){
            list.append(itemThree.text!)
        }
        
        if(itemFour.text != ""){
            list.append(itemFour.text!)
        }
        
        if(itemFive.text != ""){
            list.append(itemFive.text!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
