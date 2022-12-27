//
//  AddItemViewModel.swift
//  Venti
//
//  Created by Andriy on 26/10/2022.
//

import SwiftUI

class AddItemViewModel: ObservableObject {
	
	// MARK: - Properties
	@Published var title: String = ""
	@Published var type: ItemType = .rome
	@Published var date: Date = .now
	@Published var textColor: Color = .white
	@Published var backgroundColor: Color = .blue
	@Published var isNotificationEnabled: Bool = false
	
	let itemStorage: ItemStorage = .shared
	let localNotifications: LocalNotifications = .shared
	
	// MARK: - Computed Properties
	var item: Item {
		Item(id: UUID(), type: type, title: title, observedDate: date, textColor: textColor, backgroundColor: backgroundColor, isNotificationEnabled: isNotificationEnabled)
	}
	
	var itemViewModel: ItemViewModel {
		ItemViewModel(item: item)
	}
	
	// MARK: - Helpers
	func save() async {
		if isNotificationEnabled {
			await LocalNotifications.shared.scheduleNotification(for: item)
		}
		
		await itemStorage.add(item: item)
	}
	
	func isNotificationEnabled() async -> Bool {
		let status = await localNotifications.notificationsAuthorizationStatus()
		return status != UNAuthorizationStatus.denied
	}
}
