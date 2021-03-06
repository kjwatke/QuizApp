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
		
		// Fade out the dim view and then dismiss the popup
		UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
			self.dimView.alpha = 0
		} completion: { completed in
			self.dismiss(animated: true, completion: nil)
			
				// Notify delegate the popup was dismissed
			self.delegate?.dialogDismissed()
		}
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
		
		// Hide the UI elements
		dimView.alpha = 0
		titleLabel.alpha = 0
		feedbackLabel.alpha = 0
	}
	
	
	override func viewDidAppear(_ animated: Bool) {
		
		// Fade in the dimmed view
		UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut) {
			self.dimView.alpha = 1
			self.feedbackLabel.alpha = 1
			self.titleLabel.alpha = 1
		}
			
	}
}
