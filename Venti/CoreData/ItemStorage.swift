//
//  ItemStorage.swift
//  Venti
//
//  Created by Andriy on 20/08/2022.
//

import CoreData
import SwiftUI

@MainActor
final class ItemStorage: ObservableObject {
	
	// MARK: - Shared
	static let shared = ItemStorage()
	
	// MARK: - Properties
	private let persistence: Persistence
	
	@Published var persistentItems: [PersistentItem] = []
	
	// MARK: - Init
	init(isPreview: Bool = false) {
		if isPreview {
			self.persistence = Persistence.preview
		} else {
			self.persistence = Persistence.shared
		}
		
		Task {
			await fetch()
		}
	}
	
	// MARK: - Operations
	func fetch() async {
		let request = NSFetchRequest<PersistentItem>(entityName: "PersistentItem")
		
		do {
			persistentItems = try persistence.persistentContainer.viewContext.fetch(request)
		} catch {
			print("⚠️ Failed to fetch records! \(error)")
		}
	}
	
	func add(item: Item) async {
		let persistentItem = PersistentItem(context: persistence.persistentContainer.viewContext)
		persistentItem.id = UUID()
		persistentItem.title = item.title
		persistentItem.type = item.type.rawValue.asInt64
		persistentItem.createdDate = .now
		persistentItem.observedDate = item.observedDate
		persistentItem.textColorHex = item.textColor.toHex()
		persistentItem.backgroundColorHex = item.backgroundColor.toHex()
		
		await syncChanges()
	}
	
	func delete(with id: UUID) async {
//		persistence.persistentContainer.viewContext.delete(persistentHydrationItem)
		await syncChanges()
	}
	
	// MARK: - Helpers
	private func syncChanges() async {
		persistence.saveContext()
		await fetch()
	}
}
