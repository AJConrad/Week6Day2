//
//  ViewController.swift
//  BEForClass
//
//  Created by Thomas Crawford on 5/15/16.
//  Copyright © 2016 VizNetwork. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var thanksLabel: UILabel!
    @IBOutlet weak var finePrintField: UITextView!
    
    let backendless = Backendless.sharedInstance()
    var userArray = [User]()
    let newEntry = User()
    
    //MARK: - Data Methods
    
    private func saveUser(newUser: User) {
        let dataStore = backendless.data.of(User.ofClass())
        newEntry.userFirstName = firstNameField.text!
        newEntry.userLastName = lastNameField.text!
        newEntry.userPhone = phoneField.text!
        newEntry.userEmail = emailField.text!
        newEntry.userWinner = false
        
        dataStore.save(newUser, response: { (result) in print("To Do Saved")
        }) { (fault) in
            print("Sever Reported Error \(fault)")
        }
        
    }
    
    func setupFinePrint() {
        finePrintField.text! = "(Contest Rules: Employees of and their family members are prohibited from entering this 'sweepstakes'. Entrants must fill out 'First Name' and 'Last Name' form fields, as well as one valid method of contact, either 'Phone Number' or 'Email Address'. Entrants must enter the drawing during the hours of 00:01 and 23:59 on May 17th, 2016. Winner will be drawn at 00:00 May 18th, and will be contacted by the contact method entered above. If 'Winner' does not respond within 24 hours, at the sole discretion of The Iron Yard, an alternate may be selected or the prize will be terminated. No purchase nessecary. With money anyways. By entering the 'Contest', 'Entrant' grants The Iron Yard eternal use of the 'Entrant's' likeness (for promotion), firstborn child and soul. Void where contest prohibited. Must be the age of majority in the 'Contest's' location. Not vegan friendly.)"
        finePrintField.font = .systemFontOfSize(25)
    }
    
    
    //MARK: - Interactivity Methods
    
    @IBAction func newEntry(sender: AnyObject) {
        
        firstNameField.text = ""
        lastNameField.text = ""
        phoneField.text = ""
        emailField.text = ""
        thanksLabel.text! = ""
    }
    
    @IBAction func singUpBarButton(sender: AnyObject) {
        
        if firstNameField.text!.characters.count < 2 {
            firstNameField.text = ""
        }
        if lastNameField.text!.characters.count < 2 {
            lastNameField.text = ""
        }
        if phoneField.text!.characters.count < 9 {
            phoneField.text = ""
        }
        if emailField.text!.characters.count < 5 {
            emailField.text = ""
        }
        
        if firstNameField.text! == "" || lastNameField.text! == "" {
            thanksLabel.text! = "Please enter a First AND Last name"
            return
        } else if phoneField.text! == "" && emailField.text! == "" {
            thanksLabel.text! = "Please enter a valid Email OR Phone Number"
            return
        } else if firstNameField.text! != "" && lastNameField.text! != "" && (phoneField.text! != "" || emailField.text! != "") {
            thanksLabel.text! = "Thank you for entering!"
            saveUser(newEntry)
        }
    }

    @IBAction func handleTap(recognizer: UITapGestureRecognizer) {
        print("tapped")
        performSegueWithIdentifier("Admin", sender: recognizer)
        
    }

    //MARK: - Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupFinePrint()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

