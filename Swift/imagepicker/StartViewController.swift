//
//  StartViewController.swift
//  imagepicker
//
//  Created by Michael Alvin on 1/3/18.
//  Copyright © 2018 Sara Robinson. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

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
        self.performSegue(withIdentifier: "startsegue", sender: self)
    }
    
    @IBAction func createNewGame(_ sender: Any) {
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

}
