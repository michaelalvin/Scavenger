//
//  StartViewController.swift
//  imagepicker
//
//  Created by Michael Alvin on 1/3/18.
//  Copyright © 2018 Sara Robinson. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

var gamecode = "0"

class StartViewController: UIViewController {

    @IBOutlet weak var gameCodeTextField: UITextField!
    
    
    override func viewDidLoad() {
        self.navigationItem.hidesBackButton = true;
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startGameButton(_ sender: Any) {
        gamecode = gameCodeTextField.text!
        self.performSegue(withIdentifier: "startsegue", sender: self)
    }
    
    // Create new game, by creating a random Firebase user (random email and password),
    // and shows their uid for sharing
    
    @IBAction func createNewGame(_ sender: Any) {
        // Create random email address
        var testString = "testing"
        testString.append(randomString(length: 10))
        testString.append("@gmail.com")
        
        // Create Firebase user here
        Auth.auth().createUser(withEmail: testString, password: randomString(length: 10), completion: { (user, error) in
            
            if user != nil {
                let databaseRef = Database.database().reference()
                let userInfo = ["email": testString, "uid": user?.uid, "list": [String](), "truth": [String](), "username": "scavengerplayer"] as [String : Any]
                let userRef = databaseRef.child("users").child((user?.uid)!)
                userRef.setValue(userInfo)
                
            } else {
                
                if let myError = error?.localizedDescription {
                    print(myError)
                } else {
                    print("ERROR")
                }
            }
            
        } )
        
        
        // Perform segue
        self.performSegue(withIdentifier: "newsegue", sender: self)
        list = [String]()
    }
    
// Pass data to next controller
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if(segue.identifier == "newsegue") {
//            let dest = segue.destination as! MyViewController
//            dest.check = false
//        }
//    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
}
