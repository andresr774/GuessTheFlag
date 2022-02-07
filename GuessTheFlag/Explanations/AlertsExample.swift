//
//  AlertsExample.swift
//  GuessTheFlag
//
//  Created by Andres camilo Raigoza misas on 6/02/22.
//

import SwiftUI

struct AlertsExample: View {
    @State private var showAlert = false
    
    var body: some View {
        Button("Show Alert") {
            showAlert = true
        }
        .alert("Important message", isPresented: $showAlert) {
            Button("Delete", role: .destructive) { }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Please read this")
        }
    }
}

struct AlertsExample_Previews: PreviewProvider {
    static var previews: some View {
        AlertsExample()
    }
}
