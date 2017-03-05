//
//  TableViewController.swift
//  Outt
//
//  Created by Jenil Shah on 3/5/17.
//  Copyright © 2017 NerdAttack. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var title1 = [String]()
    var ind = [String]()
    var img1 = [String]()
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
        if let url = NSURL(string: img1[indexPath.row]) {
            if let data = NSData(contentsOf: url as URL) {
                cell.img.image = UIImage(data: data as Data)
               // imageURL.image = UIImage(data: data)
            }        
        }
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension
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
