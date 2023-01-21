//
//  ContentView.swift
//  Budget
//
//  Created by Алексей Зарицький on 20.01.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        WelcomeScreenView()
            .preferredColorScheme(.light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
