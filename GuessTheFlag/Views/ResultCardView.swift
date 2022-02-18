//
//  ResultCardView.swift
//  GuessTheFlag
//
//  Created by Andres camilo Raigoza misas on 17/02/22.
//

import SwiftUI

struct ResultCardView: View {
    @ObservedObject var vm: ContentModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(.ultraThickMaterial)
                .shadow(radius: 5)
            
            VStack(alignment: .leading, spacing: 10) {
                Label(vm.scoreTitle,
                      systemImage: vm.flagSelected == vm.correctAnswer ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .foregroundColor(vm.flagSelected == vm.correctAnswer ? .green : .red)
                
                HStack {
                    if let message = vm.scoreMessage {
                        Text("\(message) / ")
                    }
                    Text("Score:")
                    
                    Text("\(vm.score)")
                }
                Spacer(minLength: 0)
                Button(action: vm.askQuestion) {
                    Text(vm.attemptsRemaining == 0 ? "Finish" : "Continue")
                        .font(.headline)
                        .padding(.vertical, 13)
                        .frame(maxWidth: .infinity)
                        .background(vm.flagSelected == vm.correctAnswer ? .green : .red)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                Spacer(minLength: 0)

            }
            .padding()
            .padding(.vertical, 5)
        }
        .frame(height: 180)
    }
}

struct ResultCardView_Previews: PreviewProvider {
    static var previews: some View {
        ResultCardView(vm: ContentModel())
    }
}
