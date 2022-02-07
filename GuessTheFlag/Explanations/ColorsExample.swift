//
//  ColorsExample.swift
//  GuessTheFlag
//
//  Created by Andres camilo Raigoza misas on 6/02/22.
//

import SwiftUI

struct ColorsExample: View {
    var body: some View {
        ZStack {
//            Color.blue
//            Color.secondary
            VStack(spacing: 0) {
                Color.red
                Color.blue
            }
            
            Text("Your Content")
                .foregroundColor(.secondary)
                .padding(50)
                .background(.ultraThinMaterial)
                .cornerRadius(12)
        }
        .ignoresSafeArea()
    }
}

struct ColorsExample_Previews: PreviewProvider {
    static var previews: some View {
        ColorsExample()
            //.preferredColorScheme(.dark)
    }
}
