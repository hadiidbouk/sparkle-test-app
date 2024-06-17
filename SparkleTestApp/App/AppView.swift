//
//  AppView.swift
//  SparkleTestApp
//
//  Created by Hadi Dbouk on 17/06/2024.
//

import SwiftUI

struct AppView: View {
	let viewModel: AppViewModel

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world")

			Divider()

			Text("Command line tool output: \(viewModel.commandLineToolMessage)")
				.frame(alignment: .leading)
        }
        .padding()
		.frame(width: 400, height: 300)
		.task {
			viewModel.viewWillAppear()
		}
    }
}

#Preview {
	AppView(viewModel: AppViewModel())
}
