//
//  VentiApp.swift
//  Venti
//
//  Created by Andriy on 20/08/2022.
//

import SwiftUI

@main
struct VentiApp: App {
	
	@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
	@StateObject var localNotifications: LocalNotifications = .shared
	
    var body: some Scene {
        WindowGroup {
			HomeView()
				.environmentObject(HomeViewModel())
        }
    }
}
