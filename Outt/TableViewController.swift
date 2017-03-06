//
//  TableViewController.swift
//  Outt
//
//  Created by Jenil Shah on 3/5/17.
//  Copyright © 2017 NerdAttack. All rights reserved.
//

import UIKit

//var  myString = ""

class TableViewController: UITableViewController {
    
    var title1 = [String]()
    var ind = [String]()
    var img1 = [String]()
    var href1 = [String]()
    var valueToPass:String!
    var passTitle:String!
    var passImage:UIImage!
    var passURL:String!
    var ir = 0;
    var expandedRows = Set<Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // title = [String]()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //calling url
        let urlString = "http://www.recipepuppy.com/api/?i=onions,garlic&q=omelet&p=3"
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error)
            } else {
                do {
                    if let data = data,
                        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                        let blogs = json["results"] as? [[String: Any]] {
                        for blog in blogs {
                            if let name = blog["title"] as? String {
                              //  title.append(name)
                              //  self.title.append(name)
                                self.title1.append(name)
                            }
                            if let inde = blog["ingredients"] as? String {
                                self.ind.append(inde)
                                
                            }
                            if let im = blog["thumbnail"] as? String {
                                self.img1.append(im)
                                
                            }
                            if let h = blog["href"] as? String {
                                self.href1.append(h)
                                
                            }
                        }
                    }
                
                } catch {
                    print("Error deserializing JSON: \(error)")
                }
                
                //print(self.ind[0])
                print(self.img1[0])
               // a = self.count
                self.tableView.reloadData()
            }
            
            }.resume()
        
      
       // print(a);
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("my height-",title1.count)
        return self.title1.count;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        let cell:CustomTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        
       // cell.myView.backgroundColor = self.colors[indexPath.row]
        cell.txtView.text = self.ind[indexPath.row]
        cell.title.text = self.title1[indexPath.row]
        
        
        if cell.txtView!.text.utf16.count >= 30
        {
            var abc : String =  (cell.txtView.text! as NSString).substring(with: NSRange(location: 0, length: 30))
            abc += "...ReadMore"
            cell.txtView!.text = abc
            let attribs = [NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: UIFont.systemFont(ofSize: 14.0)]
            let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: abc, attributes: attribs)
            attributedString.addAttribute(NSLinkAttributeName, value: "...ReadMore", range: NSRange(location: 30, length: 11))
            attributedString.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.styleSingle.rawValue, range: NSRange(location: 30, length: 11))
            
            cell.txtView!.attributedText = attributedString
            
            var readMoreGesture = UITapGestureRecognizer(target: self, action: #selector(self.readMoreDidClickedGesture))
         //   readMoreGesture.tag = 1
            readMoreGesture.numberOfTapsRequired = 1
            cell.txtView!.addGestureRecognizer(readMoreGesture)
            cell.txtView!.isUserInteractionEnabled = true
            
        
            
            
            //cell.txtView.delegate = self
            cell.txtView.isSelectable = false
        }
        
        
        //img
        if(img1[indexPath.row].isEmpty){
            print("Yes")
            let imag : UIImage = UIImage(named:"img")!
            cell.img.image = imag
        }
        else{
            if let url = NSURL(string: img1[indexPath.row]) {
                if let data = NSData(contentsOf: url as URL) {
                    cell.img.image = UIImage(data: data as Data)
                    // imageURL.image = UIImage(data: data)
                }
            }
        }
       
        cell.isExpanded = self.expandedRows.contains(indexPath.row)
        return cell
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
//        tableView.estimatedRowHeight = 100
    self.tableView.rowHeight = UITableViewAutomaticDimension
       //tableView.rowHeight = UITableViewAutomaticDimension
   }
   
 
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell
            else { return }
        
        self.expandedRows.remove(indexPath.row)
        
        cell.isExpanded = false
        
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
       
        
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.row)
//        guard let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell
//            else { return }
//        
//        switch cell.isExpanded
//        {
//        case true:
//            self.expandedRows.remove(indexPath.row)
//            var abc : String =  (cell.txtView.text! as NSString).substring(with: NSRange(location: 0, length: 30))
//            abc += "...ReadMore"
//            cell.txtView!.text = abc
//            let attribs = [NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: UIFont.systemFont(ofSize: 14.0)]
//            let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: abc, attributes: attribs)
//            attributedString.addAttribute(NSLinkAttributeName, value: "...ReadMore", range: NSRange(location: 30, length: 11))
//            attributedString.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.styleSingle.rawValue, range: NSRange(location: 30, length: 11))
//            
//            cell.txtView!.attributedText = attributedString
//            
//            
//        case false:
//            self.expandedRows.insert(indexPath.row)
//            cell.txtView.text = self.ind[indexPath.row]
//            
//            var abc : String =  cell.txtView.text
//            cell.txtView!.text = abc
//            let attribs = [NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: UIFont.systemFont(ofSize: 14.0)]
//            let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: abc, attributes: attribs)
//            
//            
//            cell.txtView!.attributedText = attributedString
//            
//        }
//        
//        
//        cell.isExpanded = !cell.isExpanded
//        
//        self.tableView.beginUpdates()
//        self.tableView.endUpdates()
//        
//    }
    
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
        
        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
        
        valueToPass = currentCell.textLabel?.text
        let cell = tableView.cellForRow(at: indexPath) as! CustomTableViewCell
        
        passTitle = cell.title.text
        valueToPass = cell.txtView.text
        passImage = cell.img.image
        passURL = href1[indexPath.row]
        myString = passURL
        print(valueToPass)
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    
    
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "showDetail") {
            // initialize new view controller and cast it as your view controller
            var viewController = segue.destination as! DetailViewController
            // your new view controller should have property that will store passed value
            viewController.receivedInde = valueToPass
            viewController.receivedTitle = passTitle
            viewController.receivedImage = passImage
            viewController.receivedURL = passURL
        }
    }
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 100
//    }
    
    func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool
    {
        print("clickeed")
        return true
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144.0
        
    }
    
    func readMoreDidClickedGesture(sender: UITapGestureRecognizer? = nil) {
        // handling code
       print("touch")
        var tapLocation = sender?.location(in: self.tableView)
        let indexPath : NSIndexPath = self.tableView.indexPathForRow(at: tapLocation!)! as NSIndexPath
//        let currentCell = tableView.cellForRow(at: indexPath as IndexPath)! as UITableViewCell
//        
//                valueToPass = currentCell.textLabel?.text
//                let cell = tableView.cellForRow(at: indexPath as IndexPath) as! CustomTableViewCell
//        
//                passTitle = cell.title.text
//                valueToPass = self.ind[indexPath.row]
//                passImage = cell.img.image
//                passURL = href1[indexPath.row]
//                myString = passURL
//                print(valueToPass)
//                performSegue(withIdentifier: "showDetail", sender: self)
        
        guard let cell = tableView.cellForRow(at: indexPath as IndexPath) as? CustomTableViewCell
            else { return }
        
        switch cell.isExpanded
        {
        case true:
            self.expandedRows.remove(indexPath.row)
            var abc : String =  (cell.txtView.text! as NSString).substring(with: NSRange(location: 0, length: 30))
            abc += "...ReadMore"
            cell.txtView!.text = abc
            let attribs = [NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: UIFont.systemFont(ofSize: 14.0)]
            let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: abc, attributes: attribs)
            attributedString.addAttribute(NSLinkAttributeName, value: "...ReadMore", range: NSRange(location: 30, length: 11))
            attributedString.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.styleSingle.rawValue, range: NSRange(location: 30, length: 11))
            
            cell.txtView!.attributedText = attributedString
            
            
        case false:
            self.expandedRows.insert(indexPath.row)
            cell.txtView.text = self.ind[indexPath.row]
            
            var abc : String =  cell.txtView.text
            cell.txtView!.text = abc
            let attribs = [NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: UIFont.systemFont(ofSize: 14.0)]
            let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: abc, attributes: attribs)
            
            
            cell.txtView!.attributedText = attributedString
            
        }
        
        
        cell.isExpanded = !cell.isExpanded
        
        self.tableView.beginUpdates()
        self.tableView.endUpdates()

    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
