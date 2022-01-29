//
//  ResultViewController.swift
//  Quiz App
//
//  Created by Kevin  Watke on 1/28/22.
//

import UIKit

class ResultViewController: UIViewController {

	@IBOutlet weak var dimView: UIView!
	@IBOutlet weak var dialogView: UIView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var feedbackLabel: UILabel!
	@IBOutlet weak var dismissButton: UIButton!
	
	var titleText = ""
	var feedbackText = ""
	var buttonText = ""
	
	
	@IBAction func dismissTapped(_ sender: UIButton) {
		
		
	}
	
	
    override func viewDidLoad() {

		super.viewDidLoad()
		
		// Now that the elements have loaded, set the text
		titleLabel.text = titleText
		feedbackLabel.text = feedbackText
		dismissButton.setTitle(buttonText, for: .normal)

    }
}
