//
//  Question.swift
//  Quiz App
//
//  Created by Kevin  Watke on 1/28/22.
//

import Foundation

struct Question: Codable {
	
	var question: String?
	var answers: [String]?
	var correctAnswerIndex: Int?
	var feedback: String?
}
