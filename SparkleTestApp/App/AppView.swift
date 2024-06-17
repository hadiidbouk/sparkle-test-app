//
//  AppView.swift
//  SparkleTestApp
//
//  Created by Hadi Dbouk on 17/06/2024.
//

import SwiftUI

struct AppView: View {
	@Bindable var viewModel: AppViewModel

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world")

			Divider()

			Text("Command line tool output: \(viewModel.commandLineToolMessage)")
				.frame(alignment: .leading)

			Section("XPC Service") {
				HStack {
					TextField("First Number", text: $viewModel.firstNumber)
					Text("+")
					TextField("Second Number", text: $viewModel.secondNumber)
					Spacer()
					Text("=")
					Text(viewModel.xpcServiceResult)
				}
			}
        }
        .padding()
		.frame(width: 400, height: 300)
		.task {
			await viewModel.viewWillAppear()
		}
    }
}

#Preview {
	AppView(viewModel: AppViewModel())
}
