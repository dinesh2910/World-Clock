//
//  StopwatchViewController.swift
//  World Clock
//
//  Created by dinesh danda on 9/7/16.
//  Copyright © 2016 dinesh danda. All rights reserved.
//

import UIKit

class StopwatchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var stopWatchLabel: UILabel!
    @IBOutlet var lapsTableView: UITableView!
    
    @IBOutlet var startButton: UIButton!
    @IBOutlet var lapButton: UIButton!
    
    var timer = Timer()
    
    var minutes: Int = 0
    var seconds: Int = 0
    var fractions: Int = 0
    
    var stopWatchString: String = ""
    
    var startStopWatch: Bool = true
    
    var laps = [String]()
    var addLap: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        stopWatchLabel.text = "00:00.00"
        
        lapsTableView.delegate = self
        lapsTableView.dataSource = self
    }
    
    
    func updateStopWatch() {
        
        fractions += 1
        
        if fractions == 100 {
            
            seconds += 1
            fractions = 0
            
        }
        
        if seconds == 60 {
            minutes += 1
            seconds = 0
        }
        
        
        let fractionsString = fractions > 9 ? "\(fractions)" : "0\(fractions)"
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        
        stopWatchString = "\(minutesString):\(secondsString).\(fractionsString)"
        stopWatchLabel.text = stopWatchString
        
        
    }
    

    @IBAction func startPressed(_ sender: UIButton) {
        
        if startStopWatch {
            
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateStopWatch), userInfo: nil, repeats: true)
            
            RunLoop.current.add(timer, forMode: RunLoopMode.commonModes)
            
            startStopWatch = false
            
            
            startButton.setImage(UIImage(named: "stop.png"), for: .normal)
            lapButton.setImage(UIImage(named: "lap.png"), for: .normal)
            
            addLap = true
            
        } else {
            
            
            timer.invalidate()
            startStopWatch = true
            
            startButton.setImage(UIImage(named: "start.png"), for: .normal)
            lapButton.setImage(UIImage(named: "reset.png"), for: .normal)
            
            
            addLap = false
            
        }
        
        
        
        
    }
    
    @IBAction func lapPressed(_ sender: UIButton) {
        
        if addLap {
            
            laps.insert(stopWatchString, at: 0)
            lapsTableView.reloadData()
            
        } else {
            
            lapButton.setImage(UIImage(named: "lap.png"), for: .normal)
            
            laps.removeAll()
            lapsTableView.reloadData()
            
            fractions = 0
            seconds = 0
            minutes = 0
            
            stopWatchString = "00:00.00"
            stopWatchLabel.text = stopWatchString
            
            
            
            
        }
        
        
        
        
    }
    
    // Mark: Table View Methods
    
    /*
     1. No of sections
     2. no of rows
     3. cell for row at index path
 
    */
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "cell")
        
        // Configure the cell
        
        cell.textLabel?.text = "Lap \(laps.count - indexPath.row)"
        cell.detailTextLabel?.text = "\(laps[indexPath.row])"
        
        return cell
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    

}
