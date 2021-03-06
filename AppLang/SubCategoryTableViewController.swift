//
//  SubCategoryTableViewController.swift
//  AppLang
//
//  Created by Emir Kartal on 20.04.2017.
//  Copyright © 2017 Emir Kartal. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SubCategoryTableViewController: UITableViewController {

    var subCategoryArr = [String]()
    var json:JSON = []
    var frCatDic = [String:Any]()
    var categoryId = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewDesign(sender: self)
        navigationItem.title = frCatDic["subCatNavTitle"] as? String
        
        categoryId = frCatDic["selectedCatId"] as! Int
        /*
        let userDefaultsCatId = UserDefaults.standard.integer(forKey: "selectedCatId")
        
        if userDefaultsCatId < 1
        {
            categoryId = frCatDic["selectedCatId"] as! Int
            UserDefaults.standard.set(categoryId, forKey: "selectedCatId")
            
        }else
        {
            categoryId = userDefaultsCatId
        }
        */
        
        //selectedCatId
        getJSON(categoryId : categoryId)
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
        return subCategoryArr.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subCategoryCell", for: indexPath)
        
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = subCategoryArr[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let questionId = json[indexPath.row]["Id"].int
        performSegue(withIdentifier: "toQuestion", sender: questionId)
      
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toQuestion" {
            if let vc = segue.destination as? QuestionViewController {
                vc.qId = sender as! Int
                
            }
        }
    }
    
    
    func getJSON(categoryId : Int) {
        
        let url = "http://api.bankokuponlar.org/api/v1/SubCategory/GetSubCategoriesByCategoryId/\(categoryId)"
        Alamofire.request(url ,method: .get ,parameters: nil, encoding: URLEncoding.default).responseJSON { response in
            
            if let data = response.result.value{
                self.json = JSON(data)
                for unit in self.json{
                    let subCategoryName = unit.1["Title"].string
                    
                    self.subCategoryArr.append(subCategoryName!)
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
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
