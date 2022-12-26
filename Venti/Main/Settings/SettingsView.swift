//
//  SettingsView.swift
//  Venti
//
//  Created by Andriy on 27/11/2022.
//

import SwiftUI

struct SettingsView: View {
	
	@Environment(\.scenePhase) var scenePhase

	@StateObject var viewModel = SettingsViewModel()
	
    var body: some View {
		ScrollView {
			notificationsSection
		}
		.navigationBarTitleDisplayMode(.inline)
		.toolbarRole(.navigationStack)
		.toolbar(.automatic, for: .navigationBar)
		.task {
			await viewModel.determineAuthorizationStatus()
		}
		.onChange(of: scenePhase) { newValue in
			if newValue == .active {
				Task {
					await viewModel.determineAuthorizationStatus()
				}
			}
		}
	}
	
	var notificationsSection: some View {
		VStack(alignment: .leading) {
			
			Text("Notifications")
				.fontWeight(.semibold)
				.padding(.leading)
			
			VStack(spacing: 12) {
				HStack {
					Text("Status")
					
					Spacer()
					
					if viewModel.isLoadingAuthorizationStatus {
						ProgressView()
					} else {
						HStack {
							Text(viewModel.authorizationStatus.title)

							
							Circle()
								.fill(viewModel.authorizationStatus.color)
								.frame(width: 12, height: 12)
						}
					}
				}
				
				if let openSettingsURL = viewModel.openSettingsURL, viewModel.showOpenSettings {
					
					Text("Current notification authorization state might partially or fully prevent notifications from being delivered. To address this issue visit applications settings page.")
						.font(.caption2)
						.fontWeight(.light)
						.multilineTextAlignment(.leading)
					
					Link(destination: openSettingsURL) {
						Label("Open Settings", systemImage: "bell.badge.fill")
					}
				}
			}
			.materialContainer()
		}
		.padding()
	}
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
		Group {
			SettingsView(viewModel: .init(authorizationStatus: .notDetermined, isLoadingAuthorizationStatus: false))
				.previewDisplayName("Notifications warning state")
			
			SettingsView(viewModel: .init(authorizationStatus: .notDetermined, isLoadingAuthorizationStatus: true))
				.previewDisplayName("Notifications loading state")
			
			SettingsView(viewModel: .init(authorizationStatus: .authorized, isLoadingAuthorizationStatus: false))
				.previewDisplayName("Notifications authorized state")
		}
    }
}
