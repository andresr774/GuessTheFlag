//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Andres camilo Raigoza misas on 6/02/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var showGameFinished = false
    @State private var scoreTitle = ""
    @State private var gameFinishedMessage = ""
    @State private var scoreButtonTitle = ""
    @State private var score = 0
    @State private var numberOfAttempts = 8
    @State private var gameEnded = false
    @State private var trimValue: CGFloat = 1.0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
                .overlay(alignment: .topTrailing) {
                    ZStack(alignment: .center) {
                        Circle()
                            .stroke(.gray.opacity(0.3), lineWidth: 2)
                        
                        Circle()
                            .trim(from: 0.0,to: trimValue)
                            .rotation(.degrees(-90))
                            .stroke(.green, style: .init(lineWidth: 2, lineCap: .round))
                        
                        Text(numberOfAttempts, format: .number)
                            .font(.title2.weight(.semibold))
                            .foregroundColor(.white)
                    }
                    .frame(width: 55, height: 55)
                    .padding(.trailing, 20)
                }
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .alert("Game Finished!", isPresented: $showGameFinished) {
                        Button("Reset") {
                            reset()
                        }
                    } message: {
                        Text(getGameFinishedMessage())
                    }
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of:")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .alert(scoreTitle, isPresented: $showingScore) {
                    Button(scoreButtonTitle, action: askQuestion)
                } message: {
                    Text("Your score is \(score)")
                }
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
    }
    
    func flagTapped(_ number: Int) {
        if numberOfAttempts > 0 {
            numberOfAttempts -= 1
            withAnimation(.easeInOut) {
                trimValue = 1/8 * CGFloat(numberOfAttempts)
            }
        }
        if number == correctAnswer {
            scoreTitle = "Correct! 🥳"
            score += 1
        } else {
            scoreTitle = "Wrong! 😭 That's the flag of \"\(countries[number])\""
        }
        if numberOfAttempts == 0 {
            scoreButtonTitle = "Finish"
        } else {
            scoreButtonTitle = "Continue"
        }
        showingScore = true
    }
    
    func askQuestion() {
        if numberOfAttempts == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                showGameFinished = true
            }
            return
        }
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset() {
        score = 0
        numberOfAttempts = 8
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        withAnimation(.easeInOut(duration: 0.5)) {
            trimValue = 1/8 * CGFloat(numberOfAttempts)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            //.preferredColorScheme(.dark)
    }
}
