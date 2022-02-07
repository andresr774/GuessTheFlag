//
//  ButtonsExample.swift
//  GuessTheFlag
//
//  Created by Andres camilo Raigoza misas on 6/02/22.
//

import SwiftUI

struct ButtonsExample: View {
    var body: some View {
        VStack {
            Button("Delete Section", role: .destructive, action: executeDelete)
            
            Button("Button 1") { }
            .buttonStyle(.bordered)
            Button("Button 2", role: .destructive) { }
            .buttonStyle(.bordered)
            Button("Button 3") { }
            .buttonStyle(.borderedProminent)
            .tint(.mint)
            Button("Button 4", role: .destructive) { }
            .buttonStyle(.borderedProminent)
            
            Button {
                print("Button was tapped")
            } label: {
                //Label("Edit", systemImage: "pencil")
                Image(systemName: "pencil")
                    .renderingMode(.original)
            }
        }
    }
    func executeDelete() {
        
    }
}

struct ButtonsExample_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsExample()
    }
}
