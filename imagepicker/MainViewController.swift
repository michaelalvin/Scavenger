//
//  MainViewController.swift
//  imagepicker
//
//  Created by Michael Alvin on 1/1/18.
//  Copyright © 2018 Sara Robinson. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

var list = [String]()
var truth = [String]()

class MainViewController: UIViewController {

    @IBOutlet weak var itemOne: UITextField!
    
    @IBOutlet weak var itemTwo: UITextField!
    
    @IBOutlet weak var itemThree: UITextField!
    
    @IBOutlet weak var itemFour: UITextField!
    
    @IBOutlet weak var itemFive: UITextField!
    
    @IBAction func startHuntButtonTapped(_ sender: Any) {
        if(itemOne.text != ""){
            list.append(itemOne.text!)
            truth.append("0")
        }
        
        if(itemTwo.text != ""){
            list.append(itemTwo.text!)
            truth.append("0")
        }
        
        if(itemThree.text != ""){
            list.append(itemThree.text!)
            truth.append("0")
        }
        
        if(itemFour.text != ""){
            list.append(itemFour.text!)
            truth.append("0")
        }
        
        if(itemFive.text != ""){
            list.append(itemFive.text!)
            truth.append("0")
        }
        
        
        if let uid = Auth.auth().currentUser?.uid {
            let ref = Database.database().reference()
            
            var key = ref.child("users").child(uid).child("list")
            key.setValue(list)
            
            key = ref.child("users").child(uid).child("truth")
            key.setValue(truth)
        }
    }
    
    override func viewDidLoad() {
        self.navigationItem.hidesBackButton = true;
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        //view.endEditing(true)
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
