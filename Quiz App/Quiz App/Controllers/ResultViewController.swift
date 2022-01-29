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
	
	var delegate: ResultDelegate?
	
	
	@IBAction func dismissTapped(_ sender: UIButton) {
		dismiss(animated: true, completion: nil)
		
		// Notify delegate the popup was dismissed
		delegate?.dialogDismissed()
	}
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		
		dialogView.layer.cornerRadius = 10
		dialogView.clipsToBounds = true
	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		// Now that the elements have loaded, set the text
		titleLabel.text = titleText
		feedbackLabel.text = feedbackText
		dismissButton.setTitle(buttonText, for: .normal)
	}
}
