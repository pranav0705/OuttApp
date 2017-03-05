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
        
        
        //img
        if(img1[indexPath.row].isEmpty){
            print("Yes")
            var imag : UIImage = UIImage(named:"img")!
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
       
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
   
    
    
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
    
    func tableView( tableView : UITableView,  titleForHeaderInSection section: Int)->String {
        return "Recipe"
    }
    
    func tableView (tableView:UITableView , heightForHeaderInSection section:Int)->Float
    {
        
        var title = self.tableView(tableView, titleForHeaderInSection: section)
        if (title == "") {
            return 0.0
        }
        return 44.0
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
