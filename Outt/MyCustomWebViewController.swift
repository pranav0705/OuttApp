//
//  MyCustomWebViewController.swift
//  Outt
//
//  Created by Jenil Shah on 3/5/17.
//  Copyright © 2017 NerdAttack. All rights reserved.
//

import UIKit

class MyCustomWebViewController: UIViewController {
var receivedURL12 : String = ""
    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        receivedURL12 = myString
        
        
        print(",,,,,,,",receivedURL12)
        // Do any additional setup after loading the view.
      //  self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent
        let url = NSURL (string: receivedURL12)
        let requestObj = NSURLRequest(url: url! as URL);
        webView.loadRequest(requestObj as URLRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(_ sender: Any) {
        self.view.removeFromSuperview()

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
