//
//  LocalNotifications.swift
//  Venti
//
//  Created by Andriy on 21/12/2022.
//

import SwiftUI
import UserNotifications

class LocalNotifications: NSObject, ObservableObject {
	
	@Published private(set) var authorizationStatus: UNAuthorizationStatus?
	
	let notificationCenter = UNUserNotificationCenter.current()
	
	// MARK: - Init
	override init() {
		super.init()
		
		UNUserNotificationCenter.current().delegate = self
	}
	
	// MARK: - Shared
	static let shared: LocalNotifications = .init()
	
	// MARK: - Helpers
	func requestAuthorizationForNotifications() async throws -> Bool {
		let authorizationOptions: UNAuthorizationOptions = [.alert, .sound, .badge]
		
		do {
			let authorizationGranted = try await notificationCenter.requestAuthorization(options: authorizationOptions)
			return authorizationGranted
		} catch {
			throw error
		}
	}
	
	func notificationsAuthorizationStatus() async -> UNAuthorizationStatus {
		await notificationCenter.notificationSettings().authorizationStatus
	}
	
	func scheduleNotification(for: Item? = nil) async {
		do {
			let isAuthorized = try await requestAuthorizationForNotifications()
			
			if isAuthorized {
				let content = UNMutableNotificationContent()
				content.title = "Feed the cat"
				content.subtitle = "It looks hungry"
				content.sound = UNNotificationSound.default
				
				// show this notification five seconds from now
				let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
				
				// choose a random identifier
				let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
				
				// add our notification request
				try await notificationCenter.add(request)
			} else {
				print("Missing authorization")
			}
		} catch {
			print("Something failed")
		}
	}
}

extension LocalNotifications: UNUserNotificationCenterDelegate {
	func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
		
	}
	
	func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
		[.badge, .banner, .sound]
	}
}

