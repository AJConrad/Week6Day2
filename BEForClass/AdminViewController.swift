//
//  AdminViewController.swift
//  SweepstakesUser
//
//  Created by Andrew Conrad on 6/7/16.
//  Copyright © 2016 VizNetwork. All rights reserved.
//

import UIKit

class AdminViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let backendless = Backendless.sharedInstance()
    var userArray = [User]()
    let newEntry = User()
    
    @IBOutlet weak var entrantsTableView: UITableView!
    
    
    
    //MARK: - Data Methods
    
    @IBAction func chooseWinner(sender: AnyObject) {
        let dataStore = backendless.data.of(User.ofClass())
        
        var resetLoopCount = 0
        while resetLoopCount < userArray.count {
            userArray[resetLoopCount].userWinner = false
            resetLoopCount = resetLoopCount + 1
        }
        
        let randomWinner = Int(arc4random_uniform(UInt32(userArray.count)))
        userArray[randomWinner].userWinner = true
        
        for user in userArray {
            dataStore.save(user)
        }
        
        entrantsTableView.reloadData()
    }
    
    private func fetchUsers() {
        
        let dataQuery = BackendlessDataQuery()
        var error: Fault?
        let bc = backendless.data.of(User.ofClass()).find(dataQuery, fault: &error)
        if error == nil {
            userArray = bc.getCurrentPage() as! [User]
        } else {
            print("Server Error \(error)")
            userArray = [User]()
        }
        print("Got \(userArray.count)")
    }
    
    
    
    //MARK: - Table View Methods

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let currentUser = userArray[indexPath.row]
        cell.textLabel!.text = currentUser.userFirstName //+ currentUser.userLastName
        
        
        if currentUser.userWinner == true {
            cell.backgroundColor = UIColor .greenColor()
        } else if currentUser.userWinner == false {
            cell.backgroundColor = UIColor .whiteColor()
        } else {
            print("Error with boolean")
        }
        
        return cell
    }
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
//        let currentBill = billsArray[indexPath.row]
//        
//        let formatter = NSDateFormatter()
//        formatter.dateFormat = "EEEE, MMM d, yyyy"
//        let dueDateString = formatter.stringFromDate(currentBill.dueDate!)
//        cell.textLabel!.text = currentBill.title
//        cell.detailTextLabel!.text = dueDateString
//        
//        if currentBill.paid == true {
//            cell.backgroundColor = UIColor .greenColor()
//            cell.detailTextLabel!.text = "Paid on \(currentBill.paidDate)"
//        }
//        
//        return cell
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        fetchUsers()
        entrantsTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
