//
//  WorldClockTableViewController.swift
//  World Clock
//
//  Created by dinesh danda on 9/7/16.
//  Copyright © 2016 dinesh danda. All rights reserved.
//

import UIKit

class WorldClockTableViewController: UITableViewController, WorldClockProtocol {

    var timeZonesToDisplay: [String] = []
    
    func addTimeZone(timeZone: String) {
        timeZonesToDisplay.append(timeZone)
        tableView.reloadData()
        setUserDefaults()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        timeZonesToDisplay = getUserDefaults()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeZonesToDisplay.count
    }
    
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WorldClockTableViewCell
     
     // Configure the cell...
     
        cell.timeZoneName.text = timeZonesToDisplay[indexPath.row]
        
        
     return cell
     }
    
    
    
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     return true
     }
    
    
    
    
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            timeZonesToDisplay.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            setUserDefaults()
        }
     }
    
    
    
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        let temp1 = timeZonesToDisplay[fromIndexPath.row]
        let temp2 = timeZonesToDisplay[to.row]
        
        timeZonesToDisplay[fromIndexPath.row] = temp2
        timeZonesToDisplay[to.row] = temp1
        
        tableView.reloadData()
        
        setUserDefaults()
        
     }
    
    
    
    
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     
        return true
     }
    
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "modalViewSegue" {
            
            let destination = segue.destination as! TimeZonesTableViewController
            destination.delegate = self
            
            
        }
        
        
        
     }
    
    // Mark: - User Defaults 
    
    func setUserDefaults() {
        
        UserDefaults.standard.set(timeZonesToDisplay, forKey: "WorldClocks")
        UserDefaults.standard.synchronize()
        
        
    }
    
    func getUserDefaults() -> [String] {
        
        if UserDefaults.standard.value(forKey: "WorldClocks") != nil {
            timeZonesToDisplay = UserDefaults.standard.value(forKey: "WorldClocks") as! [String]
        }
        
        return timeZonesToDisplay
    }
    
    
    
    
    
    

}
