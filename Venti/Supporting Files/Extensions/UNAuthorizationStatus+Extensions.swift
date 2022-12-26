//
//  UNAuthorizationStatus+Extensions.swift
//  Venti
//
//  Created by Andriy on 26/12/2022.
//

import SwiftUI
import UserNotifications

extension UNAuthorizationStatus {
	var title: String {
		switch self {
		case .notDetermined:
			return "Not Determined"
		case .denied:
			return "Denied"
		case .authorized:
			return "Authorized"
		case .provisional:
			return "Provisional"
		case .ephemeral:
			return "Ephemeral"
		@unknown default:
			return "Unknown"
		}
	}
	
	var color: Color {
		switch self {
		case .notDetermined, .ephemeral:
			return .systemOrange
		case .denied:
			return .systemRed
		case .authorized, .provisional:
			return .systemGreen
		@unknown default:
			return .systemOrange
		}
	}
	
	var showOpenSettings: Bool {
		switch self {
		case .notDetermined, .ephemeral, .denied:
			return true
		case .authorized, .provisional:
			return false
		@unknown default:
			return false
		}
	}
}
