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

class MyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableViewController: UITableView!
    
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
        myTableViewController.reloadData()
    }
    
    override func viewDidLoad() {
        self.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        self.title = nil;
        super.viewDidLoad()
    }
    
    @IBAction func taskButtonTapped(_ sender: Any) {
        let checkedImage = UIImage(named: "checkmark")! as UIImage
        self.performSegue(withIdentifier: "segue1", sender: self)
    }

    //PASS DATA TO NEXT CONTROLLER
    public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("EE")
            //let controller = segue.destinationViewController as! ViewController
            //controller.text = "hello"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


