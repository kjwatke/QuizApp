//
//  QuizProtocol.swift
//  Quiz App
//
//  Created by Kevin  Watke on 1/28/22.
//

import Foundation

protocol QuizDelegate {
	
	func questionsRetrieved(_ questions: [Question])
}
