//
//  CategoryTableViewController.swift
//  AppLang
//
//  Created by Emir Kartal on 20.04.2017.
//  Copyright © 2017 Emir Kartal. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CategoryTableViewController: UITableViewController {
    
    
    var frTopCatDic = [String:Any]()
    var categoryArr = [String]()
    var json:JSON = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        tableViewDesign(sender: self)
        navigationItem.title = frTopCatDic["catNavTitle"] as? String
        getJSON()
        
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
        return categoryArr.count
    }
   
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)

        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = categoryArr[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let toSubCatDic:[String:Any] = ["selectedCatId": json[indexPath.row]["Id"].int!, "subCatNavTitle": json[indexPath.row]["Title"].string!]
        
        performSegue(withIdentifier: "toSubCategory", sender: toSubCatDic)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSubCategory" {
            if let vc = segue.destination as? SubCategoryTableViewController {
                vc.frCatDic = sender as! [String:Any]
            }
        }
    }
    
    func getJSON() {
        //let deviceId = UIDevice.current.identifierForVendor?.uuidString Cihaz ID
        
        let url = "http://api.bankokuponlar.org/api/v1/Category/GetCategoriesByTopCategoryId/\(frTopCatDic["selectedTopCatId"] as! Int)"
        
        print(frTopCatDic["selectedTopCatId"] )
        
        Alamofire.request(url ,method: .get ,parameters: nil, encoding: URLEncoding.default).responseJSON { response in
            
            if let data = response.result.value{
                self.json = JSON(data)
                for unit in self.json{
                    let CategoryName = unit.1["Title"].string
                    
                    self.categoryArr.append(CategoryName!)
                }
                
                self.tableView.reloadData()
            }else {
                print("error")
            }
            
        }
    }
    
    func tableViewDesign(sender: UITableViewController) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(red:0.76, green:0.22, blue:0.39, alpha:1.0).cgColor, UIColor(red:0.11, green:0.15, blue:0.44, alpha:1.0).cgColor]
        gradientLayer.frame = sender.tableView.bounds
        let backgroundView = UIView(frame: sender.tableView.bounds)
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        sender.tableView.backgroundView = backgroundView
        
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
