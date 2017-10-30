//
//  ViewController.swift
//  Boilerplate-email
//
//  Created by Víctor Galán on 10/4/17.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit
import WeDeploy

class EmailViewController: UIViewController {

	@IBOutlet weak var toTextField: BorderLessTextField!
	@IBOutlet weak var fromTextField: BorderLessTextField!
	@IBOutlet weak var subjectTextField: BorderLessTextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap))
		view.addGestureRecognizer(tapGesture)
	}
	
	@IBAction func submitButtonClick() {
		guard let to = toTextField.text,
			let from = fromTextField.text,
			let subject = subjectTextField.text else {
				
			print("You have to fill all the fields")
			return
		}
		
		let auth = TokenAuth(token: "073e93d6-7dcc-4df5-9a18-9dd121b92f50")
		WeDeploy.email("https://email-boilerplateemail.wedeploy.io", authorization: auth)
			.to(to)
			.from(from)
			.subject(subject)
			.message(subject)
			.send()
			.toCallback { emailId, error in
				if let emailId = emailId {
					self.showAlert(with: "Success", message: "Email sent! Wait a little bit until it arrives :)")
					print("Email id: \(emailId)")
				}
				else {
					self.showAlert(with: "Error", message: "Error sending the email")
					print(String(describing: error))
				}
			}
	}
	
	@objc func handleScreenTap() {
		view.endEditing(true)
	}
	
	func showAlert(with title: String, message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
		alert.addAction(action)
		
		present(alert, animated: true, completion: nil)
	}

}

