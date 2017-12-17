//
//  TimeZonesTableViewController.swift
//  World Clock
//
//  Created by dinesh danda on 9/7/16.
//  Copyright © 2016 dinesh danda. All rights reserved.
//

import UIKit

protocol WorldClockProtocol {
    func addTimeZone(timeZone: String)
}


class TimeZonesTableViewController: UITableViewController, UISearchBarDelegate {

    
    var timeZones: [String] = []
    
    @IBOutlet var searchText: UISearchBar!
    
    var delegate: WorldClockProtocol?
    
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchText.delegate = self
        
        timeZones = NSTimeZone.knownTimeZoneNames
        
    }

    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeZones.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...

        cell.textLabel?.text = timeZones[indexPath.row]
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedTimeZone: String = timeZones[indexPath.row]
        delegate?.addTimeZone(timeZone: selectedTimeZone)
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    // Mark: - UISearchBar Delegate Methods
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText != "" {
            
            timeZones = NSTimeZone.knownTimeZoneNames.filter { $0.contains(searchText) }
            
        } else {
            
            timeZones = NSTimeZone.knownTimeZoneNames
            
        }
        
        tableView.reloadData()
        
        
    }

}
