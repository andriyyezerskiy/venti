//
//  SettingsViewModel.swift
//  Venti
//
//  Created by Andriy on 26/12/2022.
//

import SwiftUI
import UserNotifications

@MainActor
final class SettingsViewModel: ObservableObject {
	
	// MARK: - Properties
	@Published var authorizationStatus: UNAuthorizationStatus = .notDetermined
	@Published var isLoadingAuthorizationStatus: Bool = false
	
	@Published var showDataDeletionWarning: Bool = false
	
	var isPreview: Bool = false
	
	let itemStorage: ItemStorage = .shared
	let localNotifications: LocalNotifications = .shared
	
	// MARK: - Init
	init() {
		
	}
	
	/// Modifies properties for preview
	init(authorizationStatus: UNAuthorizationStatus, isLoadingAuthorizationStatus: Bool) {
		self.isPreview = true
		self.authorizationStatus = authorizationStatus
		self.isLoadingAuthorizationStatus = isLoadingAuthorizationStatus
	}
	
	// MARK: - Computed Properties
	var openSettingsURL: URL? {
		URL(string: UIApplication.openSettingsURLString)
	}
	
	var showOpenSettings: Bool {
		authorizationStatus.showOpenSettings && !isLoadingAuthorizationStatus
	}
	
	// MARK: - Actions
	func clearAllData() async {
		await itemStorage.deleteAll()
	}
	
	// MARK: - Helpers
	func determineAuthorizationStatus() async {
		if !isPreview {
			isLoadingAuthorizationStatus = true
			authorizationStatus = await localNotifications.notificationsAuthorizationStatus()
			isLoadingAuthorizationStatus = false
		}
	}
}
