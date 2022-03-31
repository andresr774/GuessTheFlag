//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Andres camilo Raigoza misas on 6/02/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = ContentModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            background
            VStack {
                Spacer()
                title
                flagsBox
                Spacer()
                score
                Spacer()
                Spacer()
            }
            .padding()
            .padding(.bottom, 30)
            
            if vm.showingScore {
                ResultCardView(vm: vm)
                    .zIndex(1)
                    .transition(.move(edge: .bottom))
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .overlay(alignment: .topTrailing) {
            remainingAttempts
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

extension ContentView {
    private var background: some View {
        RadialGradient(stops: [
            .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
            .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
        ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
    }
    private var title: some View {
        Text("Guess the Flag")
            .font(.largeTitle.bold())
            .foregroundColor(.white)
            .alert("Game Finished", isPresented: $vm.showGameFinished) {
                Button("Play Again!") {
                    vm.reset()
                }
            } message: {
                Text(vm.getGameFinishedMessage())
            }
    }
    private var flagsBox: some View {
        VStack(spacing: 15) {
            flagName
            flags
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(.regularMaterial)
        .cornerRadius(20)
    }
    private var flagName: some View {
        VStack {
            Text("Tap the flag of:")
                .foregroundStyle(.secondary)
                .font(.subheadline.weight(.heavy))
            Text(vm.countries[vm.correctAnswer])
                .font(.largeTitle.weight(.semibold))
        }
    }
    private var flags: some View {
        ForEach(0..<3) { number in
            Button {
                vm.flagTapped(number)
            } label: {
                Image(vm.countries[number])
                    .renderingMode(.original)
                    .clipShape(Capsule())
                    .shadow(radius: 5)
                    .rotation3DEffect(
                        .degrees((vm.flagSelected == number && vm.animateFlags) ? -360 : 0),
                        axis: (x: 0, y: 1, z: 0)
                    )
                    .scaleEffect(
                        (vm.flagSelected == number && vm.animateFlags) ? 1.2 :
                            vm.animateFlags ? 0.9 : 1.0
                    )
                    .opacity((vm.flagSelected != number && vm.animateFlags) ? 0.25 : 1)
                    .animation(.easeInOut, value: vm.animateFlags)
                    .accessibilityLabel(vm.labels[vm.countries[number], default: "Unknown flag"])
            }
            .disabled(vm.disableButtons)
        }
    }
    private var score: some View {
        Text("Score: \(vm.score)")
            .foregroundColor(.white)
            .font(.title.bold())
    }
    private var remainingAttempts: some View {
        ZStack(alignment: .center) {
            Circle()
                .stroke(.gray.opacity(0.3), lineWidth: 3)
            
            Circle()
                .trim(from: 0.0,to: 1/8 * CGFloat(vm.attemptsRemaining))
                .rotation(.degrees(-90))
                .stroke(.green, style: .init(lineWidth: 3, lineCap: .round))
            
            Text(vm.attemptsRemaining, format: .number)
                .font(.title2.weight(.semibold))
                .foregroundColor(.white)
        }
        .frame(width: 55, height: 55)
        .padding(.trailing, 20)
    }
}
