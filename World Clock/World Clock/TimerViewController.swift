//
//  TimerViewController.swift
//  World Clock
//
//  Created by dinesh danda on 9/7/16.
//  Copyright © 2016 dinesh danda. All rights reserved.
//

import UIKit
import UserNotifications

class TimerViewController: UIViewController {

    @IBOutlet var timerPicker: UIDatePicker!
    @IBOutlet var displayLabel: UILabel!
    
    @IBOutlet var pauseButton: UIButton!
    @IBOutlet var startButton: UIButton!
    
    var timer = Timer()
    
    var seconds: Int = 0
    
    var startTimer: Bool = true
    var canPause: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayLabel.text = ""
        displayLabel.isHidden = true
        pauseButton.isEnabled = false
        
    }

    
    @IBAction func startPressed(_ sender: UIButton) {
        
        if startTimer {
            
            displayLabel.text = ""
            
            let formatter = DateFormatter()
            formatter.dateFormat = "HH"
            let hours = Int(formatter.string(from: timerPicker.date))
            formatter.dateFormat = "mm"
            let minutes = Int(formatter.string(from: timerPicker.date))
            
            seconds = hours! * 60 * 60 + minutes! * 60
            
            startButton.setImage(UIImage(named: "timer_cancel"), for: .normal)
            pauseButton.isEnabled = true
            pauseButton.setImage(UIImage(named: "timer_pause"), for: .normal)
            
            timerPicker.isHidden = true
            displayLabel.isHidden = false
            
            startTimer = false
            canPause = true
            
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateLabel), userInfo: nil, repeats: true)
            
            setupNotification()
            
        } else {
            
            startButton.setImage(UIImage(named: "timer_start"), for: .normal)
            pauseButton.setImage(UIImage(named: "timer_pause"), for: .normal)
            pauseButton.isEnabled = false
            
            timerPicker.isHidden = false
            displayLabel.isHidden = true
            
            startTimer = true
            canPause = false
            
            timer.invalidate()
            
            removeNotification()
            
        }
        
        
        
        
        
        
        
        
    }
    
    @IBAction func pausePressed(_ sender: UIButton) {
        
        if canPause {
            timer.invalidate()
            canPause = false
            pauseButton.setImage(UIImage(named: "timer_resume"), for: .normal)
            
            removeNotification()
            
        } else {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateLabel), userInfo: nil, repeats: true)
            canPause = true
            pauseButton.setImage(UIImage(named: "timer_pause"), for: .normal)
            
            setupNotification()
        }
        
        
    }

    func updateLabel() {
        
        if seconds <= 0 {
            timer.invalidate()
            return
        }
        
        seconds -= 1
        print(seconds)
        
        let displayHours = seconds / 3600
        let remainingSeconds = seconds % 3600
        
        let displayMinutes = remainingSeconds / 60
        let displaySeconds = remainingSeconds % 60
        
        
        let hoursString = displayHours > 9 ? "\(displayHours)" : "0\(displayHours)"
        let minutesString = displayMinutes > 9 ? "\(displayMinutes)" : "0\(displayMinutes)"
        let secondsString = displaySeconds > 9 ? "\(displaySeconds)" : "0\(displaySeconds)"
        
        displayLabel.text = "\(hoursString):\(minutesString):\(secondsString)"
        
        
    }
    
    func setupNotification() {
        
        let content = UNMutableNotificationContent()
        content.title = "Timer"
        content.subtitle = "Notification"
        content.body = "Timer is finished"
        content.sound = UNNotificationSound.default()
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(seconds), repeats: false)
        
        let requestIdentifier = "timerRequest"
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        
    }
    
    
    func removeNotification() {
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["timerRequest"])
    }
    
    
    
    
    

}
