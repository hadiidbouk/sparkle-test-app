//
//  ContentView.swift
//  SparkleTestApp
//
//  Created by Hadi Dbouk on 17/06/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
		.frame(width: 400, height: 300)
    }
}

#Preview {
    ContentView()
}
