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
    @IBOutlet var titleLbl: UINavigationItem!
    @IBOutlet var detailedTxt: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        detailedTxt.text = receivedInde
        titleLbl.title = receivedTitle
        img2.image = receivedImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
