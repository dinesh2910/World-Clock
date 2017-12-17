//
//  AddAlarmViewController.swift
//  World Clock
//
//  Created by dinesh danda on 9/7/16.
//  Copyright © 2016 dinesh danda. All rights reserved.
//

import UIKit

protocol AddAlarmProtocol {
    
    func addAlarm(alarmTime: Date, switchValue: Bool)
    func updateAlarm(alarmTime: Date, switchValue: Bool, index: Int)
    
}


class AddAlarmViewController: UIViewController {

    
    @IBOutlet var alarmTime: UIDatePicker!
    
    var delegate: AddAlarmProtocol?
    var addNew: Bool = true
    
    // For existing records, will need to be set from Alarm Table View Controller in prepareForSegue method
    var existingAlarm: alarmObject?
    var updateIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let alarm = existingAlarm {
            alarmTime.setDate(alarm.alarmTime, animated: true)
        }
    }
    
    

    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        
        let alarm = alarmTime.date
        
        if addNew {
            // Adding new record
            delegate?.addAlarm(alarmTime: alarm, switchValue: true)
            
        } else {
            // Updating existing record
            delegate?.updateAlarm(alarmTime: alarm, switchValue: existingAlarm!.alarmActive, index: updateIndex!)
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    

    

}
