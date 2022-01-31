//
//  QuizModel.swift
//  Quiz App
//
//  Created by Kevin  Watke on 1/28/22.
//

import Foundation

class QuizModel {
	
	var delegate: QuizDelegate?
	
	func getQuestions() {
		
		// Fetch the questions
//		getLocalJSONFile()
		getRemoteJSONFile()
	}
	
	
	func getLocalJSONFile() {
		
		// Get bundle path to JSON file
		let path = Bundle.main.path(forResource: "QuestionData", ofType: "json")
		
		// Verify the path isn't nil
		guard let path = path else {
			print("Couldn't find the json data file")
			return
		}

		// Create the URL object from the path
		let url = URL(fileURLWithPath: path)
		
		// Get the data from the URL
		do {
			let data = try Data(contentsOf: url)
			
			// Try to decode the data into objects
			let decoder = JSONDecoder()
			let array = try
			decoder.decode([Question].self, from: data)
			
			// Notify the delegate of the parsed objects
			delegate?.questionsRetrieved(array)
		} catch  {
			print("Error: Couldn't read the data at that URL")
		}
	}
	
	
	func getRemoteJSONFile() {

		// Get a URL object
		let urlString = "https://codewithchris.com/code/QuestionData.json"

		let url = URL(string: urlString)

		guard url != nil else {
			print("Could not create URL object")
			return

		}

		// Get a URL Session object
		let session = URLSession.shared

		// Get a data task object
		let dataTask = session.dataTask(with: url!) { (data, response, error) in

			// Check for error
			if error == nil && data != nil {

				do {

					// Create a JSON decoder object
					let decoder = JSONDecoder()

					// Parse the JSON
					let array = try decoder.decode([Question].self, from: data!)

					// Use the main thread to notify the vivew controller for UI Work
					DispatchQueue.main.async {

						// Notify the view controller
						self.delegate?.questionsRetrieved(array)
					}
				}
				catch  {
					print("Couldn't decode JSON")
				}
			}
		}

		// Call resume on the data task
		dataTask.resume()

	}
	
}
