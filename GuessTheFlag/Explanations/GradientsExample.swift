//
//  GradientsExample.swift
//  GuessTheFlag
//
//  Created by Andres camilo Raigoza misas on 6/02/22.
//

import SwiftUI

struct GradientsExample: View {
    var body: some View {
//        LinearGradient(gradient: Gradient(stops: [
//            .init(color: .white, location: 0.45),
//            Gradient.Stop(color: .black, location: 0.58)
//        ]), startPoint: .top, endPoint: .bottom)
//        RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 20, endRadius: 200)
        AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)
    }
}

struct GradientsExample_Previews: PreviewProvider {
    static var previews: some View {
        GradientsExample()
    }
}
