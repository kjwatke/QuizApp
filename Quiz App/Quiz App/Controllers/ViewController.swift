//
//  ViewController.swift
//  Quiz App
//
//  Created by Kevin  Watke on 1/28/22.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var questionLabel: UILabel!
	@IBOutlet weak var tableView: UITableView!
	
	var model = QuizModel()
	var questions = [Question]()
	var currentQuestionIndex = 0
	var numCorrect = 0
	
	var resultDialog: ResultViewController?
	
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		// Initialize the result dialog
		resultDialog = storyboard?.instantiateViewController(withIdentifier: "ResultVC") as? ResultViewController
		resultDialog?.modalPresentationStyle = .overCurrentContext
		
		// Set self as the dataSource and the delegate for tableView
		tableView.delegate = self
		tableView.dataSource = self
		
		model.delegate = self
		resultDialog?.delegate = self
		
		model.getQuestions()
	}
	
	func displayQuestion() {
		
		// Check if there are questions and check that the currentQuestionIndex is not out of bounds
		guard questions.count > 0 && currentQuestionIndex < questions.count else {
			return
		}
		
		questionLabel.text = questions[currentQuestionIndex].question

	}
}

// MARK: - QuizModel Delegate methods

extension ViewController: QuizDelegate {
	func questionsRetrieved(_ questions: [Question]) {
		
		// Get a reference to the questions
		self.questions = questions
		
		// Check if we should restore the state, before showing question #!
		let savedIndex = StateManager.retrieveValue(key: StateManager.questionIndexKey) as? Int
		
		guard let savedIndex = savedIndex, savedIndex < questions.count else { return }
		currentQuestionIndex = savedIndex
		
		// Retrieve the number of correct questions
		let savedNumCorrect  = StateManager.retrieveValue(key: StateManager.numCorrectKey) as? Int
		
		guard let savedNumCorrect = savedNumCorrect else { return }
		
		numCorrect = savedNumCorrect
		
		
		// Display the first question
		displayQuestion()
	}
}

// MARK: - Result Delegate method
extension ViewController: ResultDelegate {
	func dialogDismissed() {
		// Increment the currentQuestionIndex
		currentQuestionIndex += 1
		
		if currentQuestionIndex == questions.count {
			
			// The user has just answered the last question
			// Show the popup
			guard let resultDialog = resultDialog else {
				return
			}
			
				// Cusstomize the dialog text
			resultDialog.titleText = "Summary"
			resultDialog.feedbackText = "You got \(numCorrect) correct out of \(questions.count) questions"
			resultDialog.buttonText = "Restart"
			
			present(resultDialog, animated: true, completion: nil)
			
			// Clear the state
			StateManager.clearState()
			
		}
		else if currentQuestionIndex > questions.count {
			
			// Restart
			numCorrect = 0
			currentQuestionIndex = 0
			displayQuestion()
		}
		else if currentQuestionIndex < questions.count {
			
			// We have more questions to show
			// Display the next question
			displayQuestion()
			
			// Save the state
			StateManager.saveState(numCorrect: numCorrect, questionIndex: currentQuestionIndex)
		}
	}
}

// MARK: - UITableView Delegate & UITableViewDataSource methods

extension ViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		// Make sure the questions array contains at least a question
		guard questions.count > 0 else { return 0 }
		
		// Return the number of answers for this question
		let currentQuestion = questions[currentQuestionIndex]
		
		if currentQuestion.answers!.count > 0 {
			return currentQuestion.answers!.count
		}
		else {
			return 0
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		// Get a cell
		let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath)
		
		// Customize the cell
		let label = cell.viewWithTag(1) as? UILabel
		
		if label != nil {
		    
			let question = questions[currentQuestionIndex]
			
			if question.answers !=  nil && indexPath.row < question.answers!.count {
				// Set the answer text for the label
				label?.text = question.answers![indexPath.row]
			}
			
			
		}

		// Return the cell
		return cell
	}
	
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		var titleText = ""
		
		// User has tapped on a row, check if it's the right answer
		let question = questions[currentQuestionIndex]
		
		if question.correctAnswerIndex == indexPath.row {
			// User got it right
			print("User got it right")
			titleText = "Correct"
			numCorrect += 1
		}
		else {
			// User got it wrong
			print("User got it wrong")
			titleText = "Wrong"
		}
		
		// Show the popup
		guard let resultDialog = resultDialog else {
			return
		}
		
		// Cusstomize the dialog text
		resultDialog.titleText = titleText
		resultDialog.feedbackText = question.feedback!
		resultDialog.buttonText = "Next"
		
		present(resultDialog, animated: true, completion: nil)
	}
	
	
}
