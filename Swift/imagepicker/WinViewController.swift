//
//  WinViewController.swift
//  imagepicker
//
//  Created by Michael Alvin on 1/2/18.
//  Copyright © 2018 Sara Robinson. All rights reserved.
//

import UIKit

class WinViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var celebrationImage: UIImageView!
    
    @IBAction func backToMenuButton(_ sender: Any) {
        self.performSegue(withIdentifier: "segueback", sender: self)
    }
    
    // Pass data to next controller
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if(segue.identifier == "segueback") {
//            let dest = segue.destination as! MyViewController
//            dest.check = true
//        }
//    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        let checkedImage = UIImage(named: "emptyspace")! as UIImage
        celebrationImage.image = checkedImage

        celebrationImage.frame = view.frame
        view.addSubview(celebrationImage)

        imageFadeIn(imageView: celebrationImage)
    }
    
    func imageFadeIn(imageView: UIImageView) {

        let secondImageView = UIImageView(image: UIImage(named: "winner"))
        secondImageView.frame = view.frame
        secondImageView.alpha = 0.0

        view.insertSubview(secondImageView, aboveSubview: imageView)

        UIView.animate(withDuration: 2.0, delay: 2.0, options: .curveEaseOut, animations: {
            secondImageView.alpha = 1.0
        }, completion: {_ in
            imageView.image = secondImageView.image
            secondImageView.removeFromSuperview()
        })

        let alert = UIAlertController(title: "Finished!", message: "Congratulations! You have successfully finished the scavenger hunt.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
