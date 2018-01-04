//
//  MyViewController.swift
//  imagepicker
//
//  Created by Michael Alvin on 1/1/18.
//  Copyright © 2018 Sara Robinson. All rights reserved.
//

import UIKit

//
//  FirstViewController.swift
//  toDo
//
//  Created by Michael Alvin on 5/27/17.
//  Copyright © 2017 Codepath. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

var currentRow = 0

class MyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableViewController: UITableView!
    
    @IBOutlet weak var userIDLabel: UILabel!
    
    @IBOutlet weak var spinner2: UIActivityIndicatorView!
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (list.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        cell.taskLabel.text = list[indexPath.row]
        
        return(cell)
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle:
        UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        
        if editingStyle == UITableViewCellEditingStyle.delete{
            list.remove(at: indexPath.row)
            myTableViewController.reloadData()
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        spinner2.startAnimating()
        
        reloadListValues()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            // Put your code which should be executed with a delay here
            self.reloadButtonImage()
        })
        
        spinner2.stopAnimating()
    }
    
    public func reloadListValues() {
        let ref = Database.database().reference()
        
        list = [String]()
        
        // If this is initial user
        if let uid = Auth.auth().currentUser?.uid {
            // Reload list from Firebase
            ref.child("users").child(uid).child("list").observe(.childAdded, with: {
                snapshot in
                
                if let item = snapshot.value as? String {
                    list.append(item)
                    self.myTableViewController.reloadData()
                }
                
            }) { (error) in
                print(error.localizedDescription)
            }
        } else {
            // Reload from uid
            ref.child("users").child(gamecode).child("list").observe(.childAdded, with: {
                snapshot in
                
                if let item = snapshot.value as? String {
                    list.append(item)
                    self.myTableViewController.reloadData()
                }
                
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
    
    public func reloadButtonImage() {
        let ref = Database.database().reference()
        
        // Reload truth from Firebase, set the label image to red/green
        if let uid = Auth.auth().currentUser?.uid {
            var count = 0
            let checkedImage = UIImage(named: "checkmark")! as UIImage
            let uncheckedImage = UIImage(named: "empty")! as UIImage
            ref.child("users").child(uid).child("truth").observe(.childAdded, with: {
                snapshot in

                if let item = snapshot.value as? String {
                    let indexPath = IndexPath(row: count, section: 0)
                    let cell = self.myTableViewController.cellForRow(at: indexPath)
                    
//                    if(cell != nil) {
                        let customcell = cell as! CustomTableViewCell

                        if(item == "0") {
                            customcell.taskButton.setImage(uncheckedImage, for: .normal)
                        } else {
                            customcell.taskButton.setImage(checkedImage, for: .normal)
                        }
                        self.checkFinished()
                        count = count + 1
//                    }
                }

            }) { (error) in
                print(error.localizedDescription)
            }
        } else {
            // Reload from uid
            var count = 0
            let checkedImage = UIImage(named: "checkmark")! as UIImage
            let uncheckedImage = UIImage(named: "empty")! as UIImage
            ref.child("users").child(gamecode).child("truth").observe(.childAdded, with: {
                snapshot in
                
                if let item = snapshot.value as? String {
                    let indexPath = IndexPath(row: count, section: 0)
                    let cell = self.myTableViewController.cellForRow(at: indexPath)
                    
//                    if(cell != nil) {
                        let customcell = cell as! CustomTableViewCell
                        
                        if(item == "0") {
                            customcell.taskButton.setImage(uncheckedImage, for: .normal)
                        } else {
                            customcell.taskButton.setImage(checkedImage, for: .normal)
                        }
                        self.checkFinished()
                        count = count + 1
//                    }
                }
                
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
    
//    func again(cell: UITableViewCell?) {
//        if cell != nil {
//            let customcell = cell as! CustomTableViewCell
//            return customcell
//        }
//    }
    
    
    override func viewDidLoad() {
        self.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        self.title = nil
        spinner2.hidesWhenStopped = true
        super.viewDidLoad()
        
        if let uid = Auth.auth().currentUser?.uid {
            userIDLabel.text = "Code: " + uid
        }
    }
    
    var check = true
    
    // Check game condition
    public func checkFinished() {
        var finished = true
        let checkedImage = UIImage(named: "checkmark")! as UIImage
        
        for cell in myTableViewController.visibleCells {
            let cell2 = cell as! CustomTableViewCell
            
            if(!(cell2.taskButton.image(for: .normal)?.isEqual(checkedImage))!) {
                finished = false
            }
        }
        
        // Game is finished
        if(finished) {
            self.performSegue(withIdentifier: "seguedone", sender: self)
        } else {
            
        }
        
    }
    
    @IBOutlet weak var taskString: UILabel!
    
    // Move to ViewController
    
    var text: String?
    var button: UIButton?
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let row = indexPath.row
        currentRow = row
        
        // Prints row to check
        // print("Row: \(row)")
        
        let cell = myTableViewController.cellForRow(at: indexPath) as! CustomTableViewCell
        
        text = cell.taskLabel.text
        button = cell.taskButton
        
        self.performSegue(withIdentifier: "segue1", sender: self)
    }
    
    // let checkedImage = UIImage(named: "checkmark")! as UIImage

    // Pass data to next controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if(segue.identifier == "segue1") {
            let dest = segue.destination as! ViewController
            dest.text = text
            dest.button = button
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


