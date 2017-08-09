//
//  SecondViewController.swift
//  ABNSDemo
//
//  Created by Ahmed Abdul Badie on 3/15/16.
//  Copyright © 2016 Ahmed Abdul Badie. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var scheduled: [ABNotification]?
    var queued: [ABNotification]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scheduled = ABNScheduler.scheduledNotifications()
        queued = ABNScheduler.notificationsQueue()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController!.navigationItem.rightBarButtonItem?.isEnabled = false
        self.tabBarController!.navigationItem.leftBarButtonItem?.isEnabled = false
        scheduled = ABNScheduler.scheduledNotifications()
        queued = ABNScheduler.notificationsQueue()
        self.tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: Table View
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "notificationCell")
        if indexPath.section == 0 {
            let alertBody = scheduled?[indexPath.row].alertBody
            let alertaction = scheduled?[indexPath.row].alertAction
            let repeatInterval = (scheduled?[indexPath.row].repeatInterval.rawValue)
            cell.textLabel!.text = "\(alertBody!) -- Repeats: \(repeatInterval!) \n\(String(describing: alertaction!))"
            if let date = scheduled?[indexPath.row].fireDate {
             cell.detailTextLabel!.text = String(describing: date)
            }
        }
//        else {
//            let alertBody = queued?[indexPath.row].alertBody
//            let repeatInterval = (queued?[indexPath.row].repeatInterval.rawValue)
//            cell.textLabel!.text = "\(alertBody!) -- Repeats: \(repeatInterval!)"
//            if let date = queued?[indexPath.row].fireDate {
//                cell.detailTextLabel!.text = "Fire date: " + String(describing: date)
//            }
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return ABNScheduler.scheduledCount()
       // case 1: return ABNScheduler.queuedCount()
        default: return 0
        }
    }
   @objc(tableView:didSelectRowAtIndexPath:) func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.tableView.cellForRow(at: indexPath as IndexPath)
        let text = cell?.textLabel?.text
        if let text = text {
            NSLog("did select and the text is \(text)")
        }
    let alertController = UIAlertController(title: "Detail About Task!", message: text, preferredStyle: UIAlertControllerStyle.alert) //Replace UIAlertControllerStyle.Alert by UIAlertControllerStyle.alert
    //            let DestructiveAction = UIAlertAction(title: "Destructive", style: UIAlertActionStyle.Destructive) {
    //                (result : UIAlertAction) -> Void in
    //                print("Destructive")
    //            }
    // Replace UIAlertActionStyle.Default by UIAlertActionStyle.default
    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
        (result : UIAlertAction) -> Void in
    }
    // alertController.addAction(DestructiveAction)
    alertController.addAction(okAction)
    self.present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Scheduled: \(String(ABNScheduler.scheduledCount()))"
      //  case 1: return "Queued: \(String(ABNScheduler.queuedCount()))"
        default: return nil
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            
        }
    }
}

