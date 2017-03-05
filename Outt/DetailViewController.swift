//
//  DetailViewController.swift
//  Outt
//
//  Created by Jenil Shah on 3/5/17.
//  Copyright © 2017 NerdAttack. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var img2: UIImageView!
    var receivedInde:String = ""
    var receivedTitle:String = ""
    var receivedImage : UIImage!
    var receivedURL:String = ""
  
 
    @IBOutlet var titleLbl: UINavigationItem!
    @IBOutlet var detailedTxt: UITextView!
    @IBOutlet var WebBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("-------",receivedURL)
        // Do any additional setup after loading the view.
        
        detailedTxt.text = receivedInde
        titleLbl.title = receivedTitle
        img2.image = receivedImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func buttonTapped(button: UIButton)
    {
        print("buttong clinedllllllll")
      
        
        performSegue(withIdentifier: "popup1", sender: self)
        
        let popVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popup") as! MyCustomWebViewController
        self.addChildViewController(popVC)
        popVC.view.frame = self.view.frame
        self.view.addSubview(popVC.view)
        popVC.didMove(toParentViewController: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "popup1") {
            // initialize new view controller and cast it as your view controller
            var viewController = segue.destination as! MyCustomWebViewController
            // your new view controller should have property that will store passed value
            viewController.receivedURL12 = receivedURL
        }
    }

}
