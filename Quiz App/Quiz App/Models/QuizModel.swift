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
		getLocalJSONFile()
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
		
	}
}
