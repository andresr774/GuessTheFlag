//
//  ContentModel.swift
//  GuessTheFlag
//
//  Created by Andres camilo Raigoza misas on 17/02/22.
//

import Foundation
import SwiftUI

class ContentModel: ObservableObject {
    @Published var showingScore = false
    @Published var showGameFinished = false
    @Published var scoreTitle = ""
    @Published var scoreMessage: String?
    @Published var gameFinishedMessage = ""
    @Published var scoreButtonTitle = ""
    @Published var score = 0
    @Published var attemptsRemaining = 8
    @Published var gameEnded = false
    @Published var flagSelected: Int?
    @Published var disableButtons = false
    @Published var animateFlags = false
    
    @Published var countries = ["Estonia", "France", "Germany", "Ireland", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @Published var correctAnswer = Int.random(in: 0...2)
    
    func flagTapped(_ number: Int) {
        disableButtons = true
        flagSelected = number
        animateFlags = true
        
        if attemptsRemaining > 0 {
            withAnimation(.easeInOut) {
                attemptsRemaining -= 1
            }
        }
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score += 1
        } else {
            scoreTitle = "Wrong!"
            scoreMessage = "That's the flag of \"\(countries[number])\""
        }
        if attemptsRemaining == 0 {
            scoreButtonTitle = "Finish"
        } else {
            scoreButtonTitle = "Continue"
        }
        withAnimation {
            showingScore = true
        }
    }
    
    func askQuestion() {
        withAnimation {
            showingScore = false
        }
        self.animateFlags = false
        
        if attemptsRemaining == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.showGameFinished = true
            }
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.countries.shuffle()
            self.correctAnswer = Int.random(in: 0...2)
            self.scoreMessage = nil
            self.disableButtons = false
            self.flagSelected = nil
        }
    }
    
    func reset() {
        score = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        scoreMessage = nil
        disableButtons = false
        flagSelected = nil
        withAnimation(.easeInOut(duration: 0.5)) {
            attemptsRemaining = 8
        }
    }
    
    func getGameFinishedMessage() -> String {
        if score > 6 {
            return "Great! 😀 you got \(score) of 8"
        } else if score > 4 {
            return "Almost! 😐 you got \(score) of 8"
        } else {
            return "🙁 You can do better! got \(score) of 8"
        }
    }
}
